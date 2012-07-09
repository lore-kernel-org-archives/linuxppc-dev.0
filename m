Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A01002C0200
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:05:45 +1000 (EST)
Received: from mail217-co1 (localhost [127.0.0.1])	by
 mail217-co1-R.bigfish.com (Postfix) with ESMTP id B53D140300	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 13:03:24 +0000 (UTC)
Received: from CO1EHSMHS018.bigfish.com (unknown [10.243.78.226])	by
 mail217-co1.bigfish.com (Postfix) with ESMTP id 778F1B80044	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 13:03:22 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q69D5ZHQ011676	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 06:05:36 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/4] powerpc/booke: Add CPU_FTR_EMB_HV check for e5500.
Date: Mon, 9 Jul 2012 18:34:01 +0530
Message-ID: <1341839041-17223-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added CPU_FTR_EMB_HV feature check for e550.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 1345e1b..dcd8819 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -143,7 +143,13 @@ _GLOBAL(__setup_cpu_e5500)
 	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
 	beq	1f
 	bl	.setup_ehv_ivors
+	b	2f
 1:
+	ld	r10,CPU_SPEC_FEATURES(r4)
+	LOAD_REG_IMMEDIATE(r9,CPU_FTR_EMB_HV)
+	andc	r10,r10,r9
+	std	r10,CPU_SPEC_FEATURES(r4)
+2:
 	mtlr	r5
 	blr
 #endif
-- 
1.7.4.1
