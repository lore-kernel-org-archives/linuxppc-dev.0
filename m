Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id AE930679E8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:34:15 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ABcpBm014194
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:38:54 +0300 (EEST)
Message-ID: <4280985D.80108@intracom.gr>
Date: Tue, 10 May 2005 14:17:49 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
In-Reply-To: <20050509133808.A16776@cox.net>
Content-Type: multipart/mixed; boundary="------------080806040803050004050302"
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080806040803050004050302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Porter wrote:
> On Mon, May 09, 2005 at 02:45:03PM +0300, Pantelis Antoniou wrote:
> 
>>Hi
>>
>>The following patch is a combined FCC/FEC ethernet driver
>>for the Freescale line of PowerQUICCs.
>>
>>FECs on 8xx and FCCs on 82xx are supported.
>>
>>This part of the patch contains the mac drivers
>>for FEC & FCC.
> 
> 
> As mentioned on IRC, this needs to be scrubbed of all iopa() usage
> in favor of standard DMA API calls.
> 
> -Matt
> 
> 

This patch replace iopa use with virt_to_phys.

Regards

Pantelis


--------------080806040803050004050302
Content-Type: text/x-patch;
 name="fs_enet-iopa-kill.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-iopa-kill.patch"

Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fcc.c
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/mac-fcc.c
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fcc.c
@@ -226,8 +226,8 @@ static void restart(struct net_device *d
 		__fcc_out8((char *)ep + i, 0);
 
 	/* point to bds */
-	W32(ep, fen_genfcc.fcc_rbase, iopa((__u32)fep->rx_bd_base));
-	W32(ep, fen_genfcc.fcc_tbase, iopa((__u32)fep->tx_bd_base));
+	W32(ep, fen_genfcc.fcc_rbase, virt_to_phys(fep->rx_bd_base));
+	W32(ep, fen_genfcc.fcc_tbase, virt_to_phys(fep->tx_bd_base));
 
 	/* Set maximum bytes per receive buffer.
 	 * It must be a multiple of 32.
Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/mac-fec.c
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
@@ -306,8 +306,8 @@ static void restart(struct net_device *d
 	/*
 	 * Set receive and transmit descriptor base. 
 	 */
-	FW(fecp, r_des_start, iopa((__u32)fep->rx_bd_base));
-	FW(fecp, x_des_start, iopa((__u32)fep->tx_bd_base));
+	FW(fecp, r_des_start, virt_to_phys(fep->rx_bd_base));
+	FW(fecp, x_des_start, virt_to_phys(fep->tx_bd_base));
 
 	fs_init_bds(dev);
 

--------------080806040803050004050302--
