Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34494DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 04:40:55 +1000 (EST)
Message-ID: <4856B3B4.9020206@freescale.com>
Date: Mon, 16 Jun 2008 13:40:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
References: <788575.91210.qm@web83508.mail.sp1.yahoo.com>
In-Reply-To: <788575.91210.qm@web83508.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> I don't see a "dma" node in the mpc8377mds.dts (2.6.25).  I found one in mpc8610_hpcd.dts and
> modeled it after that.

Try head-of-tree.

> 		dma@82a8 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "fsl,elo-dma";
> 			cell-index = <0>;
> 			reg = <0x82a8 0x4>; /* DMA general status register */
> 			ranges = <0x0 0x8100 0x200>;

Should also put the interrupts in the dma node itself, so that the 
driver can register it once and use the shared status register (but 
don't remove it from the individual channels).

-Scott
