Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AF05B7CF1
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 02:04:19 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0QEsHDd027192
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 09:54:17 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0QF4BXq1052730
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 10:04:11 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0QF4BLi007152
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 10:04:11 -0500
Date: Tue, 26 Jan 2010 10:04:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] powerpc/44x: Add MTD support (NOR FLASH) to Katmai dts
Message-ID: <20100126150403.GQ7484@zod.rchland.ibm.com>
References: <1264513807-16289-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1264513807-16289-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2010 at 02:50:07PM +0100, Stefan Roese wrote:
>This patch adds NOR FLASH MTD support to the Katmai (440SPe) dts file.
>
>Additionally with a small whitespace cleanup.
>
>Signed-off-by: Stefan Roese <sr@denx.de>
>Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>---
> arch/powerpc/boot/dts/katmai.dts |   71 +++++++++++++++++++++++++++----------
> 1 files changed, 52 insertions(+), 19 deletions(-)
>
>diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
>index 8f345de..8cf2c0c 100644
>--- a/arch/powerpc/boot/dts/katmai.dts
>+++ b/arch/powerpc/boot/dts/katmai.dts
>@@ -156,7 +156,7 @@
> 			compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
>-			ranges = <0x00000000 0x00000004 0xe0000000 0x20000000>;
>+			ranges = <0xe0000000 0x00000004 0xe0000000 0x20000000>;

Could you explain why this was needed?  It seems to shift the addresses of all
the rest of the devices under the OPB.

> 			clock-frequency = <0>; /* Filled in by zImage */
>
> 			EBC0: ebc {
>@@ -165,14 +165,47 @@
> 				#address-cells = <2>;
> 				#size-cells = <1>;
> 				clock-frequency = <0>; /* Filled in by zImage */
>+				/* ranges property is supplied by U-Boot */

That's probably true for newer U-Boot versions, but Katmai shipped with an old
version of U-Boot that wasn't FDT-aware.  Wouldn't this break a new kernel
on the older boards that don't have an updated U-Boot since the ranges property
will be missing entirely there?

josh
