Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69DC52C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 23:18:30 +1000 (EST)
Received: from mail29-co1 (localhost [127.0.0.1])	by mail29-co1-R.bigfish.com
 (Postfix) with ESMTP id 1E15E720061	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 12 Sep 2012 13:18:23 +0000 (UTC)
Received: from CO1EHSMHS015.bigfish.com (unknown [10.243.78.233])	by
 mail29-co1.bigfish.com (Postfix) with ESMTP id 4046FDC0057	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:18:20 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q8CDIFYF002578	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 06:18:17 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
Date: Wed, 12 Sep 2012 16:18:14 +0300
Message-ID: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current form of DO_KVM macro restricts its use to one call per input
parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
definition.
Duplicate calls of DO_KVM are required by distinct implementations of
exeption handlers which are delegated at runtime. Use a rare label number
to avoid conflicts with the calling contexts.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index 30a600f..a37a12a 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -38,9 +38,9 @@
 #ifdef CONFIG_KVM_BOOKE_HV
 BEGIN_FTR_SECTION
 	mtocrf	0x80, r11	/* check MSR[GS] without clobbering reg */
-	bf	3, kvmppc_resume_\intno\()_\srr1
+	bf	3, 1975f
 	b	kvmppc_handler_\intno\()_\srr1
-kvmppc_resume_\intno\()_\srr1:
+1975:
 END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #endif
 .endm
-- 
1.7.4.1
