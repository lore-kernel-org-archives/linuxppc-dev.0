Return-Path: <R58472@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F178B1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 14:39:22 +1100 (EST)
Received: from mail20-db3 (localhost.localdomain [127.0.0.1])	by
	mail20-db3-R.bigfish.com (Postfix) with ESMTP id 232B311685EB	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 03:24:06 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.254])	by
	mail20-db3.bigfish.com (Postfix) with ESMTP id 0E7D2370058	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 03:23:17 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9E3NFYq006893	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 20:23:15 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9E3dTEW007630	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 22:39:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
Date: Thu, 14 Oct 2010 11:23:24 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F6333462F@zch01exm26.fsl.freescale.net>
In-Reply-To: <1287021866-22095-1-git-send-email-b21989@freescale.com>
References: <1287021866-22095-1-git-send-email-b21989@freescale.com>
From: Li Yang-R58472 <r58472@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: alexandre.bounine@idt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: [PATCH 2/3] fsl_rio: fix non-standard HID1 register access
>
>From: Li Yang <leoli@freescale.com>
>
>The access to HID1 register is only legitimate for e500 v1/v2 cores.
>Also fixes magic number.
>
>Signed-off-by: Li Yang <leoli@freescale.com>
>Signed-off-by: Shaohui Xie <b21989@freescale.com>

This patch is depending on another patch at
http://patchwork.ozlabs.org/patch/56138/

- Leo

>---
> arch/powerpc/sysdev/fsl_rio.c |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/sysdev/fsl_rio.c =
b/arch/powerpc/sysdev/fsl_rio.c
>index 4127636..dfff3b7 100644
>--- a/arch/powerpc/sysdev/fsl_rio.c
>+++ b/arch/powerpc/sysdev/fsl_rio.c
>@@ -1537,9 +1537,12 @@ int fsl_rio_setup(struct platform_device *dev)
> #ifdef CONFIG_E500
> 	saved_mcheck_exception =3D ppc_md.machine_check_exception;
> 	ppc_md.machine_check_exception =3D fsl_rio_mcheck_exception;
>-#endif
>-	/* Ensure that RFXE is set */
>-	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
>+
>+#ifndef CONFIG_PPC_E500MC
>+	/* Ensure that RFXE is set on e500 v1/v2 */
>+	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | HID1_RFXE));
>+#endif /* !PPC_E500MC */
>+#endif /* E500 */
>
> 	return 0;
> err:
>--
>1.6.4
