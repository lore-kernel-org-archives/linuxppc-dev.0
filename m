Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B31606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVCUnC9O
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDMz235V1z2ySk;
	Tue, 27 Oct 2026 18:47:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793087246;
	cv=none; b=KMi1wKNQI8nqVdMmCP8MtZpyIF1nU6iNYIH2SZIupWwfD/dCW9lQ0rJYjP7eJvD0lNnr0QW4NEed0YfTBXRYUzCi0A710jo5WXN7icOfsC1rAmXLZhoxJNLtUmVM407CnafVsd44KMBzSDb7odb8O99AhOduacHs9Q7Fw6q94MtXN+Pf/SjcRQ6Vx8LUrIkhK7XZGxobbZsOu98S4ix67lArYzZoib/8MBUp1l/3JROEtPXjHqpavZwQ9X35oz6R3jA3145EfBaxFDjikAwNDx9MwPqi7x9Z4Q/wX+zhQfD4kx11Of1APzesKkZdw3xuVoNdtAmkVb3pK1PekJV42A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793087246; c=relaxed/relaxed;
	bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M2Bopn8AlQETldN9ZK6tkdzE7yyI8+piKAVjhqg/YUZcITiod7KZaZB0pt+cGiNbmny2BktvEZmh6qVStw9EntyP7ciOFl3idFkQ6IyP3ESq3/n4IuE7Y6ogJKrpu2WxnBUKaqNm7EtnvvHszOweuOSC3ASPC3/qJ8Z0gKBOOH/aXXbcAp7eL11vf8UoAjPPGOQk8qBvo2JrGt7yynrFzN8R6czz/qDbG1KsD5ZOoPmEYS/x9Gr/6ww40PzzEiUylPHi7upV5XKvchgIk3G/UBFnmt5eiK7MCW7llYDE/AOC7Ml/vy7A6JjsHfj/6aSuwbLqDGr8G+Y7pl+vPGbpgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVCUnC9O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVCUnC9O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDMz06nWWz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 18:47:24 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1757403c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793087242; x=1793692042; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
        b=aVCUnC9ONy9L7p6qA0N7b1ER5YWvDShyiS/6K/NfwsNjLxKPIqJjjo1o/jPh5cjRnt
         xqatCA7jGCKjrtzXycszYD7+U7A1uXDDGsj1FeDSMKdvxQhhRyAOn2EhNlZkfiETWZjD
         zf7EbXdYJ9CwjmNfF2u9+xfIDF4U+KrTadzCOuXP+RfprsqlILh22U1VYs9I8BzbjgUn
         qHruw9vgyHhBoZG3mFziFdqTnVjTNlCVBRoD/saX9nh4HGT6FGrsdxDOqaYFrtK65axk
         epDGkIBvfCW+gi62ZAqs3sS4oWnFFpaLzD71GAiBBpXC8Qi+Ldsw9n5ZeFnszs7sXx7F
         LKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087242; x=1793692042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t18E7UE4PFJI3gidN0TaBJ4kzWBHAiAbXIwjPN/F3kE=;
        b=MOVnlcREChfVjRk+OQJHBGILV4OEJMsJZXATMs1erxxSlz3S37vQJepCeR0kXDi5Yh
         ISjiqsn6F7UW9AKEEQDsWLmT1wgVOBH/U+W8b5ovhnA5jmf1tzqMSuBEUwLh/mvd/82C
         FlWlxFdA6amWWFcRh+M4TINPmTtwYSrCVa8JxIBYQb7RsTOj5RKK8cXfuH0vErFDf49P
         TzzlKeWC/kWOPTmJ2AvQxdALInI0MaeOKpkg3+FHHUciFU+6YQJ3rSlJ/+nUbkoBDYM7
         oee4yjiYLQ+o2hgWC7gtUx+X/iTk0zEte+mvqxi3evc4XMZSy68ZQOIWCrV5OItmkt8r
         p9Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxG58Tiz27G7CjufQv2H166gC+KxpyzS61BuouHwmW/GQWcY6saSFYv1qQ3/1LIn2QR5WB0Oz9Jr1F2q/4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJTujG2p0XQG1lts6XyUwp5JijRLJsH4SSwjmdSB/W4DiNkDHdP
	LgVsPoytL8uZtosu4jx/30+rryENui89MNkHqClBFaCs7yF7bHS17Eld
X-Gm-Gg: AYBFou1tz99YGVFQodn+WZBVerT9gVewx8LXkd1+eZ2YKRWQnqpoEMs5V4SyOuqTHvs
	05jjIwNTeFoKEZCbgbxyzOWTNbsmS6xnLxUUqiEXfzhl5OajQZdL9tYORo41MaBZWCiSFuIF8b4
	c8yU9+DjirFeZgNxg3L7vjospm1vyfyJugAKjPOHAACy7k8E2iBqoiyhnO6Ac0d46ZpZr01zg+D
	M5suzJSdAjDiU65nI1eNv8JLX/XEHVrNn22xwvxmPFaSS2zU/0fEOI5oyXwq+dfPRbrQOlmW7zR
	zuG25zlypLw9uSLOxHwvPFj6rLo6H5oq2W5xQ0Oq1osajupib77oSm48kWtLK9VHwAUZeP/XQYw
	UOykHrH1CVYlzXAyrTsPNWIaqLcc7sK+Jl+0hdO9vT93eMEmeFMfFSrXa54BjA3CFFcuzVeX85Y
	yni58lupch4FPffMHn+yjMieftJ3lAlYx7x+jD7DalhF1VTKvHD8nsD8SCMutGRCoYLeHmJOI3i
	C7PuPlQIadVPqNAgu499s/8APgZ/bgTtO5fmPJX9OP1LeNaHNNjrm6O90SGYJgdwmGosFZfej4m
	YbabG2rPCH3IbIOSCjAnri1rgL4Jw88=
X-Received: by 2002:a05:7022:1508:b0:195:49ee:94c7 with SMTP id a92af1059eb24-19934a926ecmr14662254c88.8.1793087242216;
        Tue, 27 Oct 2026 00:47:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm36526698c88.10.2026.10.27.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:47:21 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	mkchauras@gmail.com,
	msuchanek@suse.de,
	bwiedemann@suse.de,
	ryan.roberts@arm.com,
	mchauras@linux.ibm.com,
	agordeev@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH V2] powerpc: Support for generic TIF bits
Date: Tue, 27 Oct 2026 13:17:10 +0530
Message-ID: <20261027074710.129819-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.56.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

powerpc already uses GENERIC_ENTRY for the irq entry/exit path.  That
means the generic entry code handles all the arch-independent
thread_info flags (TIF_SIGPENDING, TIF_NOTIFY_RESUME, TIF_NOTIFY_SIGNAL,
TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY, TIF_UPROBE, TIF_PATCH_PENDING,
TIF_MEMDIE, TIF_RSEQ, TIF_HRTIMER_REARM, TIF_USER_RETURN_NOTIFY) on
behalf of the arch.  The only remaining blocker was that powerpc defined
its own bit numbers for those flags, which conflicted with the layout
required by the common header include/asm-generic/thread_info_tif.h.

This patch selects HAVE_GENERIC_TIF_BITS and switches powerpc's
thread_info.h over to include <asm-generic/thread_info_tif.h> for the
arch-independent bits, using HAVE_TIF_NEED_RESCHED_LAZY to opt in to
the lazy-preemption flag.  The powerpc-private bits (TIF_RESTORE_TM,
TIF_SINGLESTEP, TIF_RESTOREALL, TIF_NOERROR, TIF_EMULATE_STACK_STORE,
TIF_ELF2ABI, TIF_POLLING_NRFLAG, TIF_32BIT, TIF_SYSCALL_RET) are
renumbered to start at bit 16, which is the reserved range for arch use.

Enabling HAVE_GENERIC_TIF_BITS unlocks the following features that were
previously unavailable on powerpc because their Kconfig dependencies
could not be satisfied:

  1. RSEQ_SLICE_EXTENSION (CONFIG_RSEQ_SLICE_EXTENSION)
     Allows userspace to register an RSEQ critical section and request
     a limited time-slice extension when the task is about to be
     preempted.  The kernel grants the extension (via the RSEQ shared
     data ABI) so the critical section can complete, avoiding the
     thundering-herd problem where many threads spin on the same
     lock/resource after a preemption.  This feature requires a
     dedicated TIF_RSEQ bit, which only exists when HAVE_GENERIC_TIF_BITS
     is set.  Depends on: RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY &&
     HAVE_GENERIC_TIF_BITS.

  2. HRTIMER_REARM_DEFERRED (CONFIG_HRTIMER_REARM_DEFERRED)
     Defers re-arming of the hrtimer interrupt to the return-to-user
     path, using the dedicated TIF_HRTIMER_REARM bit.  This avoids
     redundant hrtimer_interrupt() invocations within the same tick
     period and reduces latency jitter for high-resolution timer users
     (e.g., PREEMPT_RT workloads, audio, real-time tasks).  Depends on:
     GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS && HIGH_RES_TIMERS &&
     SCHED_HRTICK.

  3. Dedicated TIF_RSEQ flag (fast-path RSEQ handling)
     Without HAVE_GENERIC_TIF_BITS, TIF_RSEQ falls back to aliasing
     TIF_NOTIFY_RESUME, forcing the generic entry slow-path to run on
     every return-to-user for all RSEQ-registered threads.  With the
     dedicated bit, the fast path can skip RSEQ work unless the flag
     is actually set, reducing overhead in the common case.

  4. TIF_USER_RETURN_NOTIFY
     The generic bit for the user-return-notifier subsystem
     (kernel/user-return-notifier.c).  Used by KVM on x86 to lazily
     restore guest MSRs; having the generic bit available means future
     powerpc KVM work can use the same infrastructure.

The arch-specific bits that do not exist in the generic header retain
their private numbering in the powerpc-reserved range (bits 16+), so
no existing powerpc functionality is affected.

Tested on powerpc (POWER11 pSeries CONFIG_RSEQ=y +
CONFIG_RSEQ_SLICE_EXTENSION=y + CONFIG_HRTIMER_REARM_DEFERRED=y):

  * tools/testing/selftests/rseq/ -- all tests pass (basic_test,
    param_test, basic_percpu_ops_test, syscall_errors_test,
    slice_test via run_timeslice_test.sh)
  * tools/testing/selftests/timers/hrtimer-rearm.sh -- deferred=1
    events observed; no new dmesg warnings
  * Boot and basic workload testing shows no regression

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
This patch is applicabe over
https://lore.kernel.org/all/961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de/

Changelog:

V1 -> V2:
 - Commit message updated
V1: https://lore.kernel.org/all/20261021144453.232372-2-mkchauras@gmail.com/

 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/thread_info.h | 36 +++++++++-----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7f7910f38a67..e5527b56159a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -255,6 +255,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 4b7ec1db3034..4df3f4b5bd56 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -93,44 +93,32 @@ void arch_setup_new_exec(void);
 
 #endif /* __ASSEMBLER__ */
 
+#define HAVE_TIF_NEED_RESCHED_LAZY
+
+#include <asm-generic/thread_info_tif.h>
 /*
  * thread information flag bit numbers
  */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
-#define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
-#define TIF_PATCH_PENDING	6	/* pending live patching update */
-#define TIF_SINGLESTEP		8	/* singlestepping active */
-#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
-#define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
-#define TIF_NOERROR		12	/* Force successful syscall return */
-#define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
-#define TIF_UPROBE		14	/* breakpointed or single-stepping */
-#define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
+#define TIF_RESTORE_TM		16	/* need to restore TM FP/VEC/VSX */
+#define TIF_SINGLESTEP		17	/* singlestepping active */
+#define TIF_RESTOREALL		18	/* Restore all regs (implies NOERROR) */
+#define TIF_NOERROR		19	/* Force successful syscall return */
+#define TIF_EMULATE_STACK_STORE	20	/* Is an instruction emulation
 						for stack store? */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
 #if defined(CONFIG_PPC64)
-#define TIF_ELF2ABI		18	/* function descriptors must die! */
+#define TIF_ELF2ABI		21	/* function descriptors must die! */
 #endif
-#define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
-#define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
+#define TIF_POLLING_NRFLAG	22	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_32BIT		23	/* 32 bit binary */
+#define TIF_SYSCALL_RET		24	/* syscall error value set */
 
 /* as above, but as bit values */
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-- 
2.56.0


