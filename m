Return-Path: <linuxppc-dev+bounces-17581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBB0EDA681
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQK302fM2z3c5j;
	Wed, 04 Mar 2026 02:09:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772550572;
	cv=none; b=lxK8Px2Ryv2GNjlOLU5muiD0RKFT7f/+N9zE+6jnnh+MSbFgswTkua0t/beHmEYMPhIgkc1ymRp1EJTyGUrxqa5O1fPggDK0DCwk42iakOHKG8OO2ww2FeMefxcYMx6YLwzzdVTJJwS6sLfiPx9KpKFKBxYQSTOuHWpNN6wJALVxksmbNw/7REreTOCR8HDHvw6CVqUuDRGnoRcCDIcv4eJOzfBaiv00EtiRlwvi+uF6LfNGlteXA6jccNV82BVdUMn9zEewpoOlbynY2sWWWEaRrbfKUcfnXbeEQ13JaN2YSIf1Vvz7sC0JYrn8IMFLDYxoKU4NmzOA4HlDkEGf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772550572; c=relaxed/relaxed;
	bh=G0KEZhmPd2TgZzHz/FCaHPQYhyC3qJWcX3PRvXt+40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHumNc9K5Car1Fl9FbhLR4je/dqGMn59czA09/yddp1kE3wUG15CehQYMo4/6y3ri2pcFuRh1gZa1U2/KpWRN05lf/Jvd8STiVGu+KnEq5gf4FamKdC7TpyDa+l/L6f0UShPr8lxHMXwbWen9m8453HTlm32Aqjz2bh4XqRTRHqfN/DHc4gzP19mblsJKdJirF7zagTg7MRF7gMke3+dcQFLg/wtn8rb107mAs2CpJ5Yk34m43sZNDlICjiXrZPf+Fhk8siqsiV5co/E0zIgM602qAoVAyN+/WE6vMbuK9/b61Cx/j40G5QRDlnPK7Hz41fUzNKlkmvRwzj+6Ry+9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ryan.roberts@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQK2z2Yhmz3bsC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 02:09:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F4C1477;
	Tue,  3 Mar 2026 07:08:53 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7BB53F73B;
	Tue,  3 Mar 2026 07:08:55 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	David Laight <david.laight.linux@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/2] randomize_kstack: Maintain kstack_offset per task
Date: Tue,  3 Mar 2026 15:08:38 +0000
Message-ID: <20260303150840.3789438-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstack_offset was previously maintained per-cpu, but this caused a
couple of issues. So let's instead make it per-task.

Issue 1: add_random_kstack_offset() and choose_random_kstack_offset()
expected and required to be called with interrupts and preemption
disabled so that it could manipulate per-cpu state. But arm64, loongarch
and risc-v are calling them with interrupts and preemption enabled. I
don't _think_ this causes any functional issues, but it's certainly
unexpected and could lead to manipulating the wrong cpu's state, which
could cause a minor performance degradation due to bouncing the cache
lines. By maintaining the state per-task those functions can safely be
called in preemptible context.

Issue 2: add_random_kstack_offset() is called before executing the
syscall and expands the stack using a previously chosen random offset.
choose_random_kstack_offset() is called after executing the syscall and
chooses and stores a new random offset for the next syscall. With
per-cpu storage for this offset, an attacker could force cpu migration
during the execution of the syscall and prevent the offset from being
updated for the original cpu such that it is predictable for the next
syscall on that cpu. By maintaining the state per-task, this problem
goes away because the per-task random offset is updated after the
syscall regardless of which cpu it is executing on.

Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Closes: https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
Cc: stable@vger.kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/randomize_kstack.h | 26 +++++++++++++++-----------
 include/linux/sched.h            |  4 ++++
 init/main.c                      |  1 -
 kernel/fork.c                    |  2 ++
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 1d982dbdd0d0b..5d3916ca747cc 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -9,7 +9,6 @@
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			 randomize_kstack_offset);
-DECLARE_PER_CPU(u32, kstack_offset);
 
 /*
  * Do not use this anywhere else in the kernel. This is used here because
@@ -50,15 +49,14 @@ DECLARE_PER_CPU(u32, kstack_offset);
  * add_random_kstack_offset - Increase stack utilization by previously
  *			      chosen random offset
  *
- * This should be used in the syscall entry path when interrupts and
- * preempt are disabled, and after user registers have been stored to
- * the stack. For testing the resulting entropy, please see:
- * tools/testing/selftests/lkdtm/stack-entropy.sh
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. Preemption may be enabled. For testing the resulting
+ * entropy, please see: tools/testing/selftests/lkdtm/stack-entropy.sh
  */
 #define add_random_kstack_offset() do {					\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
 		asm volatile("" :: "r"(ptr) : "memory");		\
@@ -69,9 +67,9 @@ DECLARE_PER_CPU(u32, kstack_offset);
  * choose_random_kstack_offset - Choose the random offset for the next
  *				 add_random_kstack_offset()
  *
- * This should only be used during syscall exit when interrupts and
- * preempt are disabled. This position in the syscall flow is done to
- * frustrate attacks from userspace attempting to learn the next offset:
+ * This should only be used during syscall exit. Preemption may be enabled. This
+ * position in the syscall flow is done to frustrate attacks from userspace
+ * attempting to learn the next offset:
  * - Maximize the timing uncertainty visible from userspace: if the
  *   offset is chosen at syscall entry, userspace has much more control
  *   over the timing between choosing offsets. "How long will we be in
@@ -85,14 +83,20 @@ DECLARE_PER_CPU(u32, kstack_offset);
 #define choose_random_kstack_offset(rand) do {				\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		offset = ror32(offset, 5) ^ (rand);			\
-		raw_cpu_write(kstack_offset, offset);			\
+		current->kstack_offset = offset;			\
 	}								\
 } while (0)
+
+static inline void random_kstack_task_init(struct task_struct *tsk)
+{
+	tsk->kstack_offset = 0;
+}
 #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 #define add_random_kstack_offset()		do { } while (0)
 #define choose_random_kstack_offset(rand)	do { } while (0)
+#define random_kstack_task_init(tsk)		do { } while (0)
 #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f0..8358e430dd7fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1592,6 +1592,10 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+	u32				kstack_offset;
+#endif
+
 #ifdef CONFIG_X86_MCE
 	void __user			*mce_vaddr;
 	__u64				mce_kflags;
diff --git a/init/main.c b/init/main.c
index 1cb395dd94e43..0a1d8529212e9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -833,7 +833,6 @@ static inline void initcall_debug_enable(void)
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
-DEFINE_PER_CPU(u32, kstack_offset);
 
 static int __init early_randomize_kstack_offset(char *buf)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518a..5715adeb6adfe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -95,6 +95,7 @@
 #include <linux/thread_info.h>
 #include <linux/kstack_erase.h>
 #include <linux/kasan.h>
+#include <linux/randomize_kstack.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring_types.h>
@@ -2233,6 +2234,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	random_kstack_task_init(p);
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.43.0


