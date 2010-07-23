Return-Path: <R58472@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id B83FF100895
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 14:14:53 +1000 (EST)
Received: from mail148-va3 (localhost.localdomain [127.0.0.1])	by
	mail148-va3-R.bigfish.com (Postfix) with ESMTP id 346FC14481F6	for
	<linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 03:59:46 +0000 (UTC)
Received: from VA3EHSMHS014.bigfish.com (unknown [10.7.14.252])	by
	mail148-va3.bigfish.com (Postfix) with ESMTP id AB2C1F2004C	for
	<linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 03:59:45 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6N3xhpL003421	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 20:59:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6N4Ct9M026050	for <linuxppc-dev@ozlabs.org>;
	Thu, 22 Jul 2010 23:12:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: [PATCH] RapidIO,powerpc/85xx: remove MCSR_MASK in fsl_rio
Date: Fri, 23 Jul 2010 11:59:39 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F630BCA95@zch01exm26.fsl.freescale.net>
In-Reply-To: <1279730810-24926-1-git-send-email-alexandre.bounine@idt.com>
References: <1279730810-24926-1-git-send-email-alexandre.bounine@idt.com>
From: Li Yang-R58472 <r58472@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Alexandre Bounine" <alexandre.bounine@idt.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: [PATCH] RapidIO,powerpc/85xx: remove MCSR_MASK in fsl_rio
>
>Fixes compile problem caused by MCSR_MASK removal from book-E =
definitions.

Hi Alex,

Only with your patch, there will still be problem on SRIO platforms =
other than MPC85xx.

I have posted a patch series to fix this together with several =
compatibility issues a month before.

http://patchwork.ozlabs.org/patch/56135/
http://patchwork.ozlabs.org/patch/56136/
http://patchwork.ozlabs.org/patch/56138/
http://patchwork.ozlabs.org/patch/56137/


Can anyone pick the patch series quickly as currently there is a compile =
error when SRIO is enabled.

- Leo

>
>Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
>Cc: Kumar Gala <galak@kernel.crashing.org>
>Cc: Grant Likely <grant.likely@secretlab.ca>
>Cc: Matt Porter <mporter@kernel.crashing.org>
>---
> arch/powerpc/sysdev/fsl_rio.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/sysdev/fsl_rio.c =
b/arch/powerpc/sysdev/fsl_rio.c
>index 30e1626..c58df58 100644
>--- a/arch/powerpc/sysdev/fsl_rio.c
>+++ b/arch/powerpc/sysdev/fsl_rio.c
>@@ -245,7 +245,7 @@ static int (*saved_mcheck_exception)(struct pt_regs
>*regs);  static int fsl_rio_mcheck_exception(struct pt_regs *regs)  {
> 	const struct exception_table_entry *entry =3D NULL;
>-	unsigned long reason =3D (mfspr(SPRN_MCSR) & MCSR_MASK);
>+	unsigned long reason =3D mfspr(SPRN_MCSR);
>
> 	if (reason & MCSR_BUS_RBERR) {
> 		reason =3D in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
