Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycVc02pFmzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 03:45:20 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFGh1fR057948
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 11:45:18 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8refu3x8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 11:45:17 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 09:45:17 -0700
Subject: Re: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
To: Daniel Axtens <dja@axtens.net>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Sivakumar Krishnasamy <ksiva@linux.vnet.ibm.com>, stable@vger.kernel.org
References: <20171114153420.3911-1-bryantly@linux.vnet.ibm.com>
 <87inec2r83.fsf@linkitivity.dja.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 10:45:12 -0600
MIME-Version: 1.0
In-Reply-To: <87inec2r83.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <94eb928a-5d8d-6bf8-9efd-5a9cd602050f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/14/17 8:47 PM, Daniel Axtens wrote:

> Hi Bryant,
>
> This looks a bit better, but...
>
>> The following patch ensures that the bounce_buffer is not null
>> prior to using it within skb_copy_from_linear_data.
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

When checksum or largesend attribute for VEA is enabled, it triggers a
ibmveth_set_features->ibmveth_set_csum_offload or ibmveth_set_tso

Those two routines will do a ibmveth_close, which as you see unmaps and frees
the bounce buffer. 

Like you said if there is data in transmit, it causes the system to crash due
to bounce_buffer being used when its already freed elsewhere.

This patch just closes the window, bad things can still happen. I wanted to leave it
up to the people who actively develop in ibmveth to close the window, since introducing
a lock can be expensive in tx. 

>> The problem can be recreated toggling on/off Large send offload.
>>
>> The following script when run (along with some iperf traffic recreates the
>> crash within 5-10 mins or so).
>>
>> while true
>> do
>> 	ethtool -k ibmveth0 | grep tcp-segmentation-offload
>> 	ethtool -K ibmveth0 tso off
>> 	ethtool -k ibmveth0 | grep tcp-segmentation-offload
>> 	ethtool -K ibmveth0 tso on
>> done
>>
>> Note: This issue happens the very first time largsesend offload is
>> turned off too (but the above script recreates the issue all the times)
>>
>> [76563.914173] Unable to handle kernel paging request for data at address 0x00000000
>> [76563.914197] Faulting instruction address: 0xc000000000063940
>> [76563.914205] Oops: Kernel access of bad area, sig: 11 [#1]
>> [76563.914210] SMP NR_CPUS=2048 NUMA pSeries
>> [76563.914217] Modules linked in: rpadlpar_io rpaphp dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag nls_utf8 isofs binfmt_misc pseries_rng rtc_generic autofs4 ibmvfc scsi_transport_fc ibmvscsi ibmveth
>> [76563.914251] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-34-generic #53-Ubuntu
>                                                             ^--- yikes!
>
> There are relevant changes to this area since 4.4:
> 2c42bf4b4317 ("ibmveth: check return of skb_linearize in ibmveth_start_xmit")
> 66aa0678efc2 ("ibmveth: Support to enable LSO/CSO for Trunk VEA.")
>
> Does this crash occurs on a more recent kernel?

We DKMS ibmveth, so we have the most recent stuff. Also I have a test 4.14 kernel
that still have this problem. 

>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index f210398200ece..1d29b1649118d 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1092,8 +1092,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
>>  	 */
>>  	if (force_bounce || (!skb_is_nonlinear(skb) &&
>>  				(skb->len < tx_copybreak))) {
>> -		skb_copy_from_linear_data(skb, adapter->bounce_buffer,
>> -					  skb->len);
>> +		if (adapter->bounce_buffer) {
>> +			skb_copy_from_linear_data(skb, adapter->bounce_buffer,
>> +						  skb->len);
>> +		} else {
>> +			adapter->tx_send_failed++;
>> +			netdev->stats.tx_dropped++;
>> +			goto out;
> Finally, as I alluded to at the top of this message, isn't the
> disappearance of the bounce-buffer a pretty serious issue? As I
> understand it, it means your data structures are now inconsistent. Do
> you need to - at the least - be more chatty here?
>
> Regards,
> Daniel

Yes, we can be more chatty, but like I said previously the real solution is to make sure
if there is data in transmit to clear that up first before napi_disable in ibmveth_close. 

-Bryant
