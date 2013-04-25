Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 848322C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 21:45:45 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/1] kvm:book3e: Fix a build error
Date: Thu, 25 Apr 2013 19:45:36 +0800
Message-ID: <1366890336-4282-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cd66cc2e, "powerpc/85xx: Add AltiVec support for e6500", adds
support for AltiVec on a Book-E class processor, but while compiling 
in the CONFIG_PPC_BOOK3E_64 and CONFIG_VIRTUALIZATION case, this
introduce the following error:

arch/powerpc/kernel/exceptions-64e.S:402: undefined reference to `kvmppc_handler_42_0x01B'
arch/powerpc/kernel/built-in.o: In function `exc_altivec_assist_book3e':
arch/powerpc/kernel/exceptions-64e.S:424: undefined reference to `kvmppc_handler_43_0x01B'
make: *** [vmlinux] Error 1

Looks we should add these altivec kvm handlers.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..fa9c78a 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -319,6 +319,11 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
 	SPRN_DSRR0, SPRN_DSRR1, 0
 kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
 	SPRN_CSRR0, SPRN_CSRR1, 0
+/* altivec */
+kvm_handler BOOKE_INTERRUPT_ALTIVEC_UNAVAIL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_ALTIVEC_ASSIST, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
 #else
 /*
  * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
-- 
1.7.9.5
