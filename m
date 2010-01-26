Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D969BB7DC9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 02:32:01 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/44x: Add MTD support (NOR FLASH) to Katmai dts
Date: Tue, 26 Jan 2010 16:31:56 +0100
References: <1264513807-16289-1-git-send-email-sr@denx.de>
	<20100126150403.GQ7484@zod.rchland.ibm.com>
In-Reply-To: <20100126150403.GQ7484@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201001261631.56701.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 26 January 2010 16:04:03 Josh Boyer wrote:
> On Tue, Jan 26, 2010 at 02:50:07PM +0100, Stefan Roese wrote:
> >This patch adds NOR FLASH MTD support to the Katmai (440SPe) dts file.
> >
> >Additionally with a small whitespace cleanup.
> >
> >Signed-off-by: Stefan Roese <sr@denx.de>
> >Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >---
> > arch/powerpc/boot/dts/katmai.dts |   71
> > +++++++++++++++++++++++++++---------- 1 files changed, 52 insertions(+),
> > 19 deletions(-)
> >
> >diff --git a/arch/powerpc/boot/dts/katmai.dts
> > b/arch/powerpc/boot/dts/katmai.dts index 8f345de..8cf2c0c 100644
> >--- a/arch/powerpc/boot/dts/katmai.dts
> >+++ b/arch/powerpc/boot/dts/katmai.dts
> >@@ -156,7 +156,7 @@
> > 			compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
> > 			#address-cells = <1>;
> > 			#size-cells = <1>;
> >-			ranges = <0x00000000 0x00000004 0xe0000000 0x20000000>;
> >+			ranges = <0xe0000000 0x00000004 0xe0000000 0x20000000>;
> 
> Could you explain why this was needed?  It seems to shift the addresses of
>  all the rest of the devices under the OPB.

Yes. This is needed to being able to map the EBC ranges (physical addresses of 
each chip-select) correctly.

I'll update the commit text to explain this change a bit.
 
> > 			clock-frequency = <0>; /* Filled in by zImage */
> >
> > 			EBC0: ebc {
> >@@ -165,14 +165,47 @@
> > 				#address-cells = <2>;
> > 				#size-cells = <1>;
> > 				clock-frequency = <0>; /* Filled in by zImage */
> >+				/* ranges property is supplied by U-Boot */
> 
> That's probably true for newer U-Boot versions, but Katmai shipped with an
>  old version of U-Boot that wasn't FDT-aware.  Wouldn't this break a new
>  kernel on the older boards that don't have an updated U-Boot since the
>  ranges property will be missing entirely there?

When the ranges property is missing in this EBC node, the NOR FLASH mapping 
will not work. So not MTD devices. But it won't break anything.

Cheers,
Stefan
