Return-Path: <linuxppc-dev+bounces-24717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B8EC531C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:32:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Qs362Bmz2yFg;
	Thu, 23 Jul 2026 19:32:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784799175;
	cv=none; b=BdvU8pGfg/Z6wFJ8tY6lIq3zcctR1gkYBWp26XCpWj6P+ddIHTHncNYFcUPr4891/OcMv1j0/SdyA8vKJZt+t25ymZ4J6wV6k6GUpLqeJziywr6y67O9vC7YafpPc3eqAhRLbK2/X6xjFqnnV5j9qv9sQa+bxMS/dLtmp/YKk2c5N8vrdmLW2o3ARnqg8nvEMvNLCl8qeOrs6VVE6kpYgo0Y5XdYMN/N/r8A/jINPrr9LtWrI22qaDnHp6DdgY9EQccSeq5O/OouUZUNGlMliFANzd333TCw3yyCMoyPlNepC8cmWcTBrsLkrziSyAnmfcVUYV1MgUDDDPbC/XQUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784799175; c=relaxed/relaxed;
	bh=u/GMBJUw9496HN7qmeuqom0Q2euvhvcvLf/qGj65tWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9OQIcWxceoMu9z/n+5XdT3hP2MhI6LK2AZ4qVpTh7uvp5nOmUx3u/1icFRm3U0aYFfFhAeYcI6Fy3NJLrA27dSVlPTB4TZS2IMnH+J19TsI7ll6q8iCp3G21AA48PzU8Z77cCaEemaIw+8hhAs16f7HOeyYCFYcS8Mk/OPltS51u3FcKsElZZLPWayzOmx0dO5Bgp84SlP+RXnyqOmrH76Wn1lrxq0mCWvK9Ha/JDnnja9hULBCVVuI4g1CB3iVLGdMSBzgjbPGZ4P6Vz6owfAXxjYOamsqk7j1pWnd0j/MrkA8KkL0xY4GsQz57hU29ex96FfmPiMjzyTwFmeYxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iabglp1V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iabglp1V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Qs24vJqz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 19:32:53 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-382ef647e20so405935a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784799171; x=1785403971; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/GMBJUw9496HN7qmeuqom0Q2euvhvcvLf/qGj65tWM=;
        b=Iabglp1VQ9jkouErHVmeir8X1gXlkvgqY8lALLUClRMXSm6oEyXFBRD6Y0+1futl1G
         ZMBYsJF+W0ISeWvoOQicMpShANSyOoIV3DLVNMoRjY5Fe13WWIbWnjw7FzmaxAXyY9qr
         e4I0TNh/AhsOtnKxb9wIEMfIg7HPHUIZhCmrbTpWxdsmHuq4AKrKpXvY7WGMnc0oCoqq
         DYfcfwuuVIMfRhSa51u3lUnh0EHAddk2gXq9LKNMBKZ4OGtlInbrNWbcN9Nl+2Uzz+gL
         jNsH6Y4O4CDWPE5PqM7R5QjdvyltzJt2t31f1MPHMQYVI3o0RzHzUbd0xSma6PuWjUrJ
         MoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799171; x=1785403971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/GMBJUw9496HN7qmeuqom0Q2euvhvcvLf/qGj65tWM=;
        b=SDnYRhA/mp44seX7uWA3N1fpcWnPl6+sPBpNDImPAHCfvGVdgbdhqCvzG3QRITmBH2
         XnrmLExaQXtZeqbt4J9dAVEAyO6u1i51A6025X3eu0tKGctfhmba0VEYXFgDEPElsxC+
         vcYvRWTiyNJYAFUye3MfJ7EiniHZcdmYYO5uX/Zvad5B7iTmwBm89VGeSRyaikZ09AV5
         XrfZOeebXVZn2w/5j/2G4bAns65pckfO94vr8DH69O59gKPQ5avQ83bBjaecd5lh1eBP
         4oaNMDoLYL/x4oo5iNi26ZaYgyEaR/pYq7ap4/1UHvbKLYXhePUHf0/LKwZMOxaarrtv
         iE7A==
X-Forwarded-Encrypted: i=1; AHgh+Roc1V2NKY/nsdEUNyQzsWhTbdSYl0DjcY4ojoPnrIsj/KhwY0d2ckm8/ZUv0IOHvpegtR94GRn39wrZe3I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziHTZ+cmk94bP1KXhdu6gYSuwXNlzVS+JeXLJEjzp0VzEixk1i
	XfhdTpgkmDHJFwwXnqzgXCpPhraUeCs7c+b5yJZs1Yzp3z3M7f/zZdgb
X-Gm-Gg: AR+sD11rEieW5wLi0IaNJiPbcTdc9XqCmyX/FJNlj/Gc2kuh2vdmbRKDSmzXChbbLhY
	XuSj/2rVChRNvWbez86YsjRbaQhRGKuyjtFW1VLGc6sJ2i3Gln017Q9DKCySRFY7n0cC9BS60gZ
	OJoF65ysKu8LzZjyewrVoID7JisiBvnbx6MCMptTS7qRYs2VP+BxrW5noofV5VetW4HEHOePqMi
	mE5gul0kZY71lFJwpNZRTwr/eFzGy1hXPhZyTITWACjnkNQbrSBl8/Vqx3jDqMiIwFAxd0rRBrJ
	1MfANE0tlc41iqCUIiws1kA1k+qIrecJtArm7Kf1PzbzsOFll048luTnamTkUiSC0uTVy4GTAI6
	KjDOj4BSD4RhE83r45LwFlSeivtFADXh7ycdCBC3B38lrOrQG9c7iXbQ6Fi0MGdZl5B84w9okyt
	1sgOgznVrXZ7kUMcyjVo65sH3N+o+CZSVsQNRP3w+2C7/rKrt1
X-Received: by 2002:a17:90b:4ac3:b0:38e:447c:9a15 with SMTP id 98e67ed59e1d1-38ec66435bamr2067906a91.36.1784799170931;
        Thu, 23 Jul 2026 02:32:50 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaf50c09sm694442a91.14.2026.07.23.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:32:49 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:02:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, mchauras@linux.ibm.com, thuth@redhat.com, ruanjinjie@huawei.com, 
	sshegde@linux.ibm.com, akpm@linux-foundation.org, charlie@rivosinc.com, deller@gmx.de, 
	macro@orcam.me.uk, segher@kernel.crashing.org, peterz@infradead.org, 
	bigeasy@linutronix.de, namcao@linutronix.de, tglx@linutronix.de, mark.barnett@arm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
Message-ID: <amHfaIAiRu748JBa@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
 <20260123073916.956498-6-mkchauras@linux.ibm.com>
 <20260722070155.GA11808@strace.io>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722070155.GA11808@strace.io>

On Wed, Jul 22, 2026 at 10:01:55AM +0300, Dmitry V. Levin wrote:
> On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
> > From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> > 
> > Add a new field `exit_flags` in the pt_regs structure. This field will hold
> > the flags set during interrupt or syscall execution that are required during
> > exit to user mode.
> 
> Apparently, this change breaks PTRACE_GETREGS as the latter has no means
> to communicate the size of struct pt_regs being written to userspace.
> 
> As result, the kernel with this patch will write to userpsace 32 more
> bytes than before, and unless the userspace is re-compiled with the latest
> ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
> overwritten.
> 
> This issue was detected by strace test suite, specifically, the test that
> checks whether the actual number of bytes written by
> ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
> with runtime version v7.1 and headers version v7.2-rc1.
> 
[...]

Hey,

Can you try this fix? This should fix the ABI breakage.

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fdeb97421785..d53c4dd4d8b6 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -53,9 +53,6 @@ struct pt_regs
 				unsigned long esr;
 			};
 			unsigned long result;
-			unsigned long exit_flags;
-			/* Maintain 16 byte interrupt stack alignment */
-			unsigned long __pt_regs_pad[3];
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ee3b9adb5b67..0487e94d3416 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -57,6 +57,7 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
+	unsigned long	exit_flags;		/* Exit Flags for entry/exit */
 	unsigned long	syscall_work;		/* SYSCALL_WORK_ flags */
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH_64
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index a393b7f2760a..01e630149d48 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -55,8 +55,6 @@ struct pt_regs
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
-	unsigned long exit_flags;	/* System call exit flags */
-	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLER__ */
@@ -116,12 +114,10 @@ struct pt_regs
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#define PT_EXIT_FLAGS 44
-#define PT_PAD 47 /* 3 times */
-#define PT_DSCR 48
-#define PT_REGS_COUNT 48
+#define PT_DSCR 44
+#define PT_REGS_COUNT 44
 
-#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
+#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
 
 #ifndef __powerpc64__
 
@@ -133,7 +129,7 @@ struct pt_regs
 #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
 
 
-#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
+#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
 #define PT_VSCR (PT_VR0 + 32*2 + 1)
 #define PT_VRSAVE (PT_VR0 + 33*2)
 
@@ -141,7 +137,7 @@ struct pt_regs
 /*
  * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
  */
-#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
 #define PT_VSR31 (PT_VSR0 + 2*31)
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index f04978080837..5b88bf72786c 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -89,15 +89,17 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 					   long scv)
 {
 	unsigned long ti_flags;
+	unsigned long ret = 0;
 	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
 
 	kuap_assert_locked();
 
 	regs->result = r3;
-	regs->exit_flags = 0;
 
-	ti_flags = read_thread_flags();
+	/* Clear exit_flags so only flags set during this exit are visible */
+	current->thread_info.exit_flags = 0;
 
+	ti_flags = read_thread_flags();
 	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
 			r3 = -r3;
@@ -107,7 +109,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	if (unlikely(ti_flags & _TIF_PERSYSCALL_MASK)) {
 		if (ti_flags & _TIF_RESTOREALL)
-			regs->exit_flags = _TIF_RESTOREALL;
+			ret = _TIF_RESTOREALL;
 		else
 			regs->gpr[3] = r3;
 		clear_bits(_TIF_PERSYSCALL_MASK, &current_thread_info()->flags);
@@ -116,7 +118,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	}
 
 	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
-		regs->exit_flags |= _TIF_RESTOREALL;
+		ret |= _TIF_RESTOREALL;
 	}
 
 	syscall_exit_to_user_mode(regs);
@@ -132,17 +134,19 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-
+	ret |= current->thread_info.exit_flags;
 #ifdef CONFIG_PPC64
-	regs->exit_result = regs->exit_flags;
+	regs->exit_result = ret;
 #endif
 
-	return regs->exit_flags;
+	return ret;
 }
 
 #ifdef CONFIG_PPC64
 notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *regs)
 {
+	unsigned long ret;
+
 	/*
 	 * This is called when detecting a soft-pending interrupt as well as
 	 * an alternate-return interrupt. So we can't just have the alternate
@@ -167,9 +171,11 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 	}
 
 	kuap_user_restore(regs);
-	regs->exit_result |= regs->exit_flags;
+	ret = current_thread_info()->exit_flags & _TIF_RESTOREALL;
+	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
+	regs->exit_result |= ret;
 
-	return regs->exit_result;
+	return ret;
 }
 #endif
 
@@ -186,8 +192,10 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	 */
 	kuap_assert_locked();
 
+	/* Clear exit_flags so only flags set during this exit are visible */
+	current_thread_info()->exit_flags = 0;
+
 	local_irq_disable();
-	regs->exit_flags = 0;
 again:
 	check_return_regs_valid(regs);
 	user_enter_irqoff();
@@ -200,9 +208,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-
-	ret = regs->exit_flags;
-
+	ret = current_thread_info()->exit_flags & _TIF_RESTOREALL;
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
 #endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 316d4f5ead8e..6cd180bc36ab 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -291,7 +291,6 @@ void __init pt_regs_check(void)
 	CHECK_REG(PT_DAR, dar);
 	CHECK_REG(PT_DSISR, dsisr);
 	CHECK_REG(PT_RESULT, result);
-	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
 	#undef CHECK_REG
 
 	BUILD_BUG_ON(PT_REGS_COUNT != sizeof(struct user_pt_regs) / sizeof(unsigned long));
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index bb42a8b6c642..cc6498501610 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -356,6 +356,6 @@ void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
 void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	BUG_ON(regs != current->thread.regs);
-	regs->exit_flags |= _TIF_RESTOREALL;
+	current_thread_info()->exit_flags |= _TIF_RESTOREALL;
 	do_signal(current);
 }


