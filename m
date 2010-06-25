Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 78A11100864
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 22/26] KVM: PPC: PV assembler helpers
Date: Sat, 26 Jun 2010 01:25:10 +0200
Message-Id: <1277508314-915-23-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we hook an instruction we need to make sure we don't clobber any of
the registers at that point. So we write them out to scratch space in the
magic page. To make sure we don't fall into a race with another piece of
hooked code, we need to disable interrupts.

To make the later patches and code in general easier readable, let's introduce
a set of defines that save and restore r30, r31 and cr. Let's also define some
helpers to read the lower 32 bits of a 64 bit field on 32 bit systems.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm_emul.S |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index c7b9fc9..7da835a 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -25,3 +25,32 @@
 
 #define KVM_MAGIC_PAGE		(-4096)
 
+#ifdef CONFIG_64BIT
+#define LL64(reg, offs, reg2)	ld	reg, (offs)(reg2)
+#define STL64(reg, offs, reg2)	std	reg, (offs)(reg2)
+#else
+#define LL64(reg, offs, reg2)	lwz	reg, (offs + 4)(reg2)
+#define STL64(reg, offs, reg2)	stw	reg, (offs + 4)(reg2)
+#endif
+
+#define SCRATCH_SAVE							\
+	/* Enable critical section. We are critical if			\
+	   shared->critical == r1 */					\
+	STL64(r1, KVM_MAGIC_PAGE + KVM_MAGIC_CRITICAL, 0);		\
+									\
+	/* Save state */						\
+	PPC_STL	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH1)(0);		\
+	PPC_STL	r30, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH2)(0);		\
+	mfcr	r31;							\
+	stw	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH3)(0);
+
+#define SCRATCH_RESTORE							\
+	/* Restore state */						\
+	PPC_LL	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH1)(0);		\
+	lwz	r30, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH3)(0);		\
+	mtcr	r30;							\
+	PPC_LL	r30, (KVM_MAGIC_PAGE + KVM_MAGIC_SCRATCH2)(0);		\
+									\
+	/* Disable critical section. We are critical if			\
+	   shared->critical == r1 and r2 is always != r1 */		\
+	STL64(r2, KVM_MAGIC_PAGE + KVM_MAGIC_CRITICAL, 0);
-- 
1.6.0.2
