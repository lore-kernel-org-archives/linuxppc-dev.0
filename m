Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C0D40679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 12:32:31 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k653nc8J028843
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Jul 2006 21:49:38 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k652WR7R002268
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Jul 2006 21:32:28 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306FA6F52@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>, pantelis@embeddedalley.com
Subject: RE: Linux 2.6.x  :  cpm_dpalloc alignment bug perhaps not fully r
	esolved
Date: Wed, 5 Jul 2006 10:32:18 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Did you apply the alignment patch too?  AFAIK, the problem is never fixed in 
mainstream trees.

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On Behalf
> Of Laurent Lagrange
> Sent: Tuesday, July 04, 2006 11:37 PM
> To: pantelis@embeddedalley.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not fully resolved
> 
> 
> Hello Pantelis,
> 
> Few months ago (25 January 2006), I sent a mail about an alignment bug in
> cpm_dpalloc.
> I applied and verified the provided patch. I was very satisfied with the
> result.
> 
> Today I port a driver from Linux 2.4 to Linux 2.6 and I have strange
> results.
> 
> The driver allocates rx and tx bds (8 bytes aligned) in the module_init for
> 4 SCC ports.
> That is always right. Then one port is opened by an application and a user
> configuration
> is set via an ioctl (set_conf).
> 
> This ioctl first frees the old bds :
> 	cpm_dpfree(chan->rx_bd_offset);
> 	cpm_dpfree(chan->tx_bd_offset);
> then allocates the new ones :
> 	chan->rx_bd_offset = cpm_dpalloc(sizeof(cbd_t) * chan->conf.rx_bufnbr,
> 8);
> 	chan->tx_bd_offset = cpm_dpalloc(sizeof(cbd_t) * chan->conf.tx_bufnbr,
> 8);
> with rx_bufnbr == 8 and tx_bufnbr == 2
> 
> module_init
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8
> SCC2 rx_bd_offset=1c0
> SCC2 tx_bd_offset=208
> SCC3 rx_bd_offset=220
> SCC3 tx_bd_offset=260
> SCC4 rx_bd_offset=278
> SCC4 tx_bd_offset=2c0
> set_conf
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a4	-> ???
> 
> module_init
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8
> SCC2 rx_bd_offset=1c0
> SCC2 tx_bd_offset=208
> SCC3 rx_bd_offset=220
> SCC3 tx_bd_offset=260
> SCC4 rx_bd_offset=278
> SCC4 tx_bd_offset=2c0
> set_conf
> SCC2 rx_bd_offset=1c0
> SCC2 tx_bd_offset=202	-> ???
> 
> module_init
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8
> SCC2 rx_bd_offset=1c0
> SCC2 tx_bd_offset=208
> SCC3 rx_bd_offset=220
> SCC3 tx_bd_offset=260
> SCC4 rx_bd_offset=278
> SCC4 tx_bd_offset=2c0
> set_conf
> SCC3 rx_bd_offset=220
> SCC3 tx_bd_offset=260	-> ok
> 
> module_init
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8
> SCC2 rx_bd_offset=1c0
> SCC2 tx_bd_offset=208
> SCC3 rx_bd_offset=220
> SCC3 tx_bd_offset=260
> SCC4 rx_bd_offset=278
> SCC4 tx_bd_offset=2c0
> set_conf
> SCC4 rx_bd_offset=278
> SCC4 tx_bd_offset=2c0	-> ok
> 
> WARNING : if I only uses the SCC1 port without allocating bds for the other
> ports,
> I can free and reallocate the bds for the SCC1 port as many times I want.
> 
> module_init
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8
> set_conf
> SCC1 rx_bd_offset=160
> SCC1 tx_bd_offset=1a8	-> ok
> 
> Really, I don't understand how this can arise.
> Any idea ?
> 
> Thanks
> Laurent
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
