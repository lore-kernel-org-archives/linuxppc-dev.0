Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCEA9B7C37
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:35 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 03/27] Add Book3s definitions
Date: Fri, 30 Oct 2009 16:47:03 +0100
Message-Id: <1256917647-6200-4-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need quite a bunch of new constants for KVM on Book3s,
so let's define them now.

These constants will be used in later patches.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v3 -> v4

  - remove old kernel compat code
---
 arch/powerpc/include/asm/kvm_asm.h |   39 ++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 56bfae5..19ddb35 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -49,6 +49,45 @@
 #define BOOKE_INTERRUPT_SPE_FP_ROUND 34
 #define BOOKE_INTERRUPT_PERFORMANCE_MONITOR 35
 
+/* book3s */
+
+#define BOOK3S_INTERRUPT_SYSTEM_RESET	0x100
+#define BOOK3S_INTERRUPT_MACHINE_CHECK	0x200
+#define BOOK3S_INTERRUPT_DATA_STORAGE	0x300
+#define BOOK3S_INTERRUPT_DATA_SEGMENT	0x380
+#define BOOK3S_INTERRUPT_INST_STORAGE	0x400
+#define BOOK3S_INTERRUPT_INST_SEGMENT	0x480
+#define BOOK3S_INTERRUPT_EXTERNAL	0x500
+#define BOOK3S_INTERRUPT_ALIGNMENT	0x600
+#define BOOK3S_INTERRUPT_PROGRAM	0x700
+#define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
+#define BOOK3S_INTERRUPT_DECREMENTER	0x900
+#define BOOK3S_INTERRUPT_SYSCALL	0xc00
+#define BOOK3S_INTERRUPT_TRACE		0xd00
+#define BOOK3S_INTERRUPT_PERFMON	0xf00
+#define BOOK3S_INTERRUPT_ALTIVEC	0xf20
+#define BOOK3S_INTERRUPT_VSX		0xf40
+
+#define BOOK3S_IRQPRIO_SYSTEM_RESET		0
+#define BOOK3S_IRQPRIO_DATA_SEGMENT		1
+#define BOOK3S_IRQPRIO_INST_SEGMENT		2
+#define BOOK3S_IRQPRIO_DATA_STORAGE		3
+#define BOOK3S_IRQPRIO_INST_STORAGE		4
+#define BOOK3S_IRQPRIO_ALIGNMENT		5
+#define BOOK3S_IRQPRIO_PROGRAM			6
+#define BOOK3S_IRQPRIO_FP_UNAVAIL		7
+#define BOOK3S_IRQPRIO_ALTIVEC			8
+#define BOOK3S_IRQPRIO_VSX			9
+#define BOOK3S_IRQPRIO_SYSCALL			10
+#define BOOK3S_IRQPRIO_MACHINE_CHECK		11
+#define BOOK3S_IRQPRIO_DEBUG			12
+#define BOOK3S_IRQPRIO_EXTERNAL			13
+#define BOOK3S_IRQPRIO_DECREMENTER		14
+#define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	15
+#define BOOK3S_IRQPRIO_MAX			16
+
+#define BOOK3S_HFLAG_DCBZ32			0x1
+
 #define RESUME_FLAG_NV          (1<<0)  /* Reload guest nonvolatile state? */
 #define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
 
-- 
1.6.0.2
