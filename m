Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC7711007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 21:07:58 +1100 (EST)
Received: from mail62-db3 (localhost.localdomain [127.0.0.1])	by
	mail62-db3-R.bigfish.com (Postfix) with ESMTP id AFA11684DA	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2010 10:07:52 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.250])	by
	mail62-db3.bigfish.com (Postfix) with ESMTP id 4E9BE7B0050	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2010 10:07:52 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oA3A8iuQ026184	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 3 Nov 2010 03:08:44 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oA3AOeHv004117	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 3 Nov 2010 05:24:41 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <akpm@linux-foundation.org>
Subject: [PATCH 2/4][v2] fsl_rio: fix non-standard HID1 register access
Date: Wed, 3 Nov 2010 17:36:37 +0800
Message-ID: <1288776997-23562-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <b21989@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>, linux-kernel@vger.kernel.org,
	Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaohui Xie <b21989@freescale.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    6 ++++++
 arch/powerpc/sysdev/fsl_rio.c             |    2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 0adb50a..8fd5bc6 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -63,6 +63,12 @@ _GLOBAL(__setup_cpu_e500v2)
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500_ivors
+#ifdef CONFIG_RAPIDIO
+	/* Ensure that RFXE is set */
+	mfspr	r3,SPRN_HID1
+	oris	r3,r3,HID1_RFXE@h
+	mtspr	SPRN_HID1,r3
+#endif
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_e500mc)
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 4127636..1143c93 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1538,8 +1538,6 @@ int fsl_rio_setup(struct platform_device *dev)
 	saved_mcheck_exception = ppc_md.machine_check_exception;
 	ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
 #endif
-	/* Ensure that RFXE is set */
-	mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
 
 	return 0;
 err:
-- 
1.6.4
