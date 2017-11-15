Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yc9yv3nWrzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 15:15:35 +1100 (AEDT)
Message-ID: <1510715692.2397.41.camel@kernel.crashing.org>
Subject: Re: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Axtens <dja@axtens.net>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, Sivakumar
 Krishnasamy <ksiva@linux.vnet.ibm.com>, stable@vger.kernel.org
Date: Wed, 15 Nov 2017 14:14:52 +1100
In-Reply-To: <87inec2r83.fsf@linkitivity.dja.id.au>
References: <20171114153420.3911-1-bryantly@linux.vnet.ibm.com>
 <87inec2r83.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-15 at 13:47 +1100, Daniel Axtens wrote:
> Hi Bryant,
> 
> This looks a bit better, but...
> 
> > The following patch ensures that the bounce_buffer is not null
> > prior to using it within skb_copy_from_linear_data.
> 
> How would this occur?
> 
> Looking at ibmveth.c, I see bounce_buffer being freed in ibmveth_close()
> and allocated in ibmveth_open() only. If allocation fails, the whole
> opening of the device fails with -ENOMEM.
> 
> It seems your test case - changing TSO - causes ibmveth_set_tso() to
> cause an adaptor restart - an ibmveth_close(dev) and then an
> ibmveth_open(dev). Is this happening in parallel with an out of memory
> condition - is the memory allocation failing?
> 
> Alternatively, could it be the case that you're closing the device while
> packets are in flight, and then trying to use a bounce_buffer that's
> been freed elsewhere? Do you need to decouple memory freeing from
> ibmveth_close?

Hrm, you should at least stop the tx queue and NAPI (and synchronize)
while doing a reset. A lot of drivers, rather than doing close/open
(which does subtly different things) tend to instead fire a work queue
(often called reset_task) which does the job (and uses the same lower
level helpers as open/close to free/allocate the rings etc...).


> > The problem can be recreated toggling on/off Large send offload.
> > 
> > The following script when run (along with some iperf traffic recreates the
> > crash within 5-10 mins or so).
> > 
> > while true
> > do
> > 	ethtool -k ibmveth0 | grep tcp-segmentation-offload
> > 	ethtool -K ibmveth0 tso off
> > 	ethtool -k ibmveth0 | grep tcp-segmentation-offload
> > 	ethtool -K ibmveth0 tso on
> > done
> > 
> > Note: This issue happens the very first time largsesend offload is
> > turned off too (but the above script recreates the issue all the times)
> > 
> > [76563.914173] Unable to handle kernel paging request for data at address 0x00000000
> > [76563.914197] Faulting instruction address: 0xc000000000063940
> > [76563.914205] Oops: Kernel access of bad area, sig: 11 [#1]
> > [76563.914210] SMP NR_CPUS=2048 NUMA pSeries
> > [76563.914217] Modules linked in: rpadlpar_io rpaphp dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag nls_utf8 isofs binfmt_misc pseries_rng rtc_generic autofs4 ibmvfc scsi_transport_fc ibmvscsi ibmveth
> > [76563.914251] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-34-generic #53-Ubuntu
> 
>                                                             ^--- yikes!
> 
> There are relevant changes to this area since 4.4:
> 2c42bf4b4317 ("ibmveth: check return of skb_linearize in ibmveth_start_xmit")
> 66aa0678efc2 ("ibmveth: Support to enable LSO/CSO for Trunk VEA.")
> 
> Does this crash occurs on a more recent kernel?
> 
> > diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> > index f210398200ece..1d29b1649118d 100644
> > --- a/drivers/net/ethernet/ibm/ibmveth.c
> > +++ b/drivers/net/ethernet/ibm/ibmveth.c
> > @@ -1092,8 +1092,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
> >  	 */
> >  	if (force_bounce || (!skb_is_nonlinear(skb) &&
> >  				(skb->len < tx_copybreak))) {
> > -		skb_copy_from_linear_data(skb, adapter->bounce_buffer,
> > -					  skb->len);
> > +		if (adapter->bounce_buffer) {
> > +			skb_copy_from_linear_data(skb, adapter->bounce_buffer,
> > +						  skb->len);
> > +		} else {
> > +			adapter->tx_send_failed++;
> > +			netdev->stats.tx_dropped++;
> > +			goto out;
> 
> Finally, as I alluded to at the top of this message, isn't the
> disappearance of the bounce-buffer a pretty serious issue? As I
> understand it, it means your data structures are now inconsistent. Do
> you need to - at the least - be more chatty here?
> 
> Regards,
> Daniel
> > +		}
> >  
> >  		descs[0].fields.flags_len = desc_flags | skb->len;
> >  		descs[0].fields.address = adapter->bounce_buffer_dma;
> > -- 
> > 2.13.6 (Apple Git-96)
