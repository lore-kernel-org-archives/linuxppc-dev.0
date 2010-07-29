Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AECEC1007DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 5/7] KVM: PPC: Use MSR_DR for external load_up
Date: Thu, 29 Jul 2010 15:04:20 +0200
Message-Id: <1280408662-10328-6-git-send-email-agraf@suse.de>
In-Reply-To: <1280408662-10328-1-git-send-email-agraf@suse.de>
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
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

Book3S_32 requires MSR_DR to be disabled during load_up_xxx while on Book3S_64
it's supposed to be enabled. I misread the code and disabled it in both cases,
potentially breaking the PS3 which has a really small RMA.

This patch makes KVM work on the PS3 again.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_rmhandlers.S |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 506d5c3..229d3d6 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -202,8 +202,25 @@ _GLOBAL(kvmppc_rmcall)
 
 #if defined(CONFIG_PPC_BOOK3S_32)
 #define STACK_LR	INT_FRAME_SIZE+4
+
+/* load_up_xxx have to run with MSR_DR=0 on Book3S_32 */
+#define MSR_EXT_START						\
+	PPC_STL	r20, _NIP(r1);					\
+	mfmsr	r20;						\
+	LOAD_REG_IMMEDIATE(r3, MSR_DR|MSR_EE);			\
+	andc	r3,r20,r3;		/* Disable DR,EE */	\
+	mtmsr	r3;						\
+	sync
+
+#define MSR_EXT_END						\
+	mtmsr	r20;			/* Enable DR,EE */	\
+	sync;							\
+	PPC_LL	r20, _NIP(r1)
+
 #elif defined(CONFIG_PPC_BOOK3S_64)
 #define STACK_LR	_LINK
+#define MSR_EXT_START
+#define MSR_EXT_END
 #endif
 
 /*
@@ -215,19 +232,12 @@ _GLOBAL(kvmppc_load_up_ ## what);				\
 	PPC_STLU r1, -INT_FRAME_SIZE(r1);			\
 	mflr	r3;						\
 	PPC_STL	r3, STACK_LR(r1);				\
-	PPC_STL	r20, _NIP(r1);					\
-	mfmsr	r20;						\
-	LOAD_REG_IMMEDIATE(r3, MSR_DR|MSR_EE);			\
-	andc	r3,r20,r3;		/* Disable DR,EE */	\
-	mtmsr	r3;						\
-	sync;							\
+	MSR_EXT_START;						\
 								\
 	bl	FUNC(load_up_ ## what);				\
 								\
-	mtmsr	r20;			/* Enable DR,EE */	\
-	sync;							\
+	MSR_EXT_END;						\
 	PPC_LL	r3, STACK_LR(r1);				\
-	PPC_LL	r20, _NIP(r1);					\
 	mtlr	r3;						\
 	addi	r1, r1, INT_FRAME_SIZE;				\
 	blr
-- 
1.6.0.2
