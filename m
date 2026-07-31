Return-Path: <linuxppc-dev+bounces-25174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36968C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 08:15:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBJmB2f8gz2xg8;
	Fri, 31 Jul 2026 18:15:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785485738;
	cv=none; b=T9qcO28TU2Fk4zRjMokRtEzoAvjoaIQRPOF14Rqc8TvpGbH2LQuAr9zVtQ4sq52/CNoQOljJyf6V6ZcFt1cEz22BrqEjGoILjnMHETtCyjdcybs1jCx+UVdScQ/6/B5tY6u7hSRdJTOc+Q7CZcfE+hJVv30wAnH1j9bM3CEpcyXi/7Quf6dSLsuPgCUywJPuHo6WlDSo2ZXwRK+Mx/pKrjr/RXTGYykX6Cn4IyLeK2Hjkn0lui08BOKMOIuHjtqbMDmPs3arfC3uaLlJSttBzNQOlPJkxxL7oTW31vEFpfRrRVi/6MJac/zIhYv/ttQd/EAww63Q0cJD8Gj+M7aFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785485738; c=relaxed/relaxed;
	bh=L7qVGVE6k+yrpPk+UhHXnejs9qdoQvkOw+rsZvIfl6o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwZ+qZWY+rjfjth7//ZNZC05aGN8FT04due8NX+Iz2Ysc15iQzvIBCcpB4qkhxq7BSKGIT3Oi06cDt6e4+/f97PLNJ/ssTZDO2/gM4jhBSWBzgUpI9oOozTR+HiqN6gNRjErRmSMQtmF8ImUiejgnmgXXgxsQ0m+WNGsWWU3bT+FThV8xNz6dfcW8/Me6+Ou4hUbomlXIBa+Akdn0w/tInnohfIux9ORfmd2MoL4CUEwhCLtGqLQWdEW8mw8SzkSQMeZzYlAACOYANzTL2v63s/Aa/fhRTrK45xACEzIsoL6J8BogzOvtNJLOqxhvHPodrFE0Mp6V26sNaLpRHipNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MfrqYfLB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MfrqYfLB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBJm86d1Kz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 18:15:36 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2ce98cb8165so6083785ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785485733; x=1786090533; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7qVGVE6k+yrpPk+UhHXnejs9qdoQvkOw+rsZvIfl6o=;
        b=MfrqYfLBLtcuZ9mi9iP+V0pYkNMT2CweVlW1zLTMRKPgtTTjxdbPyz7y8CCW99Z3PI
         mQa9H4+vhLLmsEm0GloaIRVyaDqDMBpLQaDw8BsXMqSU+NlvtZbXMKKWENnYvXeibTQw
         TyKrRnAww7Xz8WnLwNLYNgvMX2tX/TUtlo+21exvlYCZurcu/15qbqlYirf6iY761uA0
         CLWC0NR9fO8wUGRmi9dGwvxetY8aem9rY82Hd+2g6APvc2gF2Jb+ay77ivBZe9ACy9RF
         mwDm4FYXKLhD8JZUsb5ygfgBZpvZ6yAzmKTZJtyD9OsOqosBR2544S64nh2O3pC9rExk
         cIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785485733; x=1786090533;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7qVGVE6k+yrpPk+UhHXnejs9qdoQvkOw+rsZvIfl6o=;
        b=YF2U9AUWzK40UesnR37KEtmMOuGRnYvYIEW7ZYcYXqEUu3W5c8z3WbwaBGXDzfIBH+
         PoxmdbVOhIYK74kpmlKWMCz4i3m8wW/5scRXBPp2UDx6uG50uv4SKd41nKi96DqNmfhk
         SXymxBWxTYqW1PijweWw9FNic8trNDajpk2ox1STkxhcx9n9gaES/U+GvSozACB6liTX
         oLxJ7PzYai+nT9xKDYGIaJCkRh3pxsMI4ETnOwWbqRmfht0r33lfaSBclcF+jWea2xt3
         5wNHz3i2rUHzjJ7wYZXD72/N2q1/HXfchj5m+YigZNN+q2Eb4VnDN2MemzswaW74g1pA
         qz5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrtPbIYhJa4clqE5QFvx4MjMyio01BTpx1hrAoUZYeJEyJ6ZFfJeHln4ZPLVeCNnAWiNai+tmwDtI60cPA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNZpUulEFeErc9tIIe0ieVOj4H5xqXcHC9xtCumyZRxTlNWauX
	e9S5DfJThuAFMoGDYE62gGrfoQccRAYQ0RoHmbKl4ayjxPUpBj4ICakc
X-Gm-Gg: AR+sD12XBybWbklJbK36OvQCtA8LHwpOfkt7zzsodsufDv7AoHJd1Ww8gH1RX1UQBB1
	ZJx63trdppDZDpIeklxAoENgZ3hVlONcRJHxYclry/eDAVIlKznPNgCmlkDQG2qP9yVH+rAmXxi
	JA3RnoVS2xJ6ozGK5lTzKGe5m7QbtMdguiej78AXrdmfM94QteMt3ddKYbLXKbDOOwjTpcievfj
	Js7laYSHxnjTaXjdpczB4oYvNXFoPAD0rBFfVpiSv4lgfr58PmrfMdki5oxoYURZk7T3GqX4/t/
	E71RxdZS3ks5CXZjgJtqGmUcihT+xre/giJtN3lf4v2Iw74APw/whxZanZny+J4KNldUEuLQqPe
	8MUxINFsVNnrHR3XJuASOUwAd8L2VKZ2KLALd6WjcMS2QO17nUyX6hRnFo8DDN3CPZ3GY46zSoF
	a5fq/sgT3AdlZWjEjUOgQ7GjgmbFJ1TIx1T49J8t7bc2Tkhtb9nT4XMbEUWvIsqL6EKhUfRo1ZG
	YnfdomkgZL1wczxU7K998izPJEWHVjgALisEWZPQw==
X-Received: by 2002:a17:903:17c3:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d047e38bc5mr8591215ad.18.1785485733348;
        Fri, 31 Jul 2026 01:15:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fc98sm3088605eec.21.2026.07.31.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:15:32 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@gmail.com,
	mchauras@linux.ibm.com,
	msuchanek@suse.de,
	sshegde@linux.ibm.com,
	david@kernel.org,
	thuth@redhat.com,
	agordeev@linux.ibm.com,
	mark.rutland@arm.com,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Fri, 31 Jul 2026 13:45:21 +0530
Message-ID: <20260731081521.1852133-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling GENERIC_ENTRY on PowerPC, syscall_enter_from_user_mode()
returns -1 as a sentinel to signal that seccomp or ptrace has intercepted
the syscall and already set a return value via syscall_set_return_value().
system_call_exception() was not handling this sentinel, and since -1UL
is >= NR_syscalls, the code fell into the out-of-range path and returned
-ENOSYS, overwriting the errno already placed in regs->gpr[3].

The naive fix of checking r0 == -1L before the NR_syscalls bounds check
is ambiguous: a user legitimately calling syscall(-1) also produces r0 ==
-1L, and a tracer intercepting such a call would have its injected return
value silently discarded.

Fix this by introducing a thread flag that is set whenever
syscall_set_return_value() explicitly updates the return value. In
system_call_exception(), check and clear this flag before dispatching
the syscall, and return the preset value directly when it is present.
This ensures that an explicitly supplied return value always suppresses
syscall execution, regardless of the syscall number.

This handles all seccomp actions correctly:

  - SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE (no tracer), SECCOMP_RET_USER_NOTIF:
    all call syscall_set_return_value(), flag is set, injected value returned.
  - SECCOMP_RET_TRAP, SECCOMP_RET_KILL: call syscall_rollback() and deliver
    a signal; flag is not set, but the process is dying so the return value
    is irrelevant.

The fix covers both ppc32 and ppc64 with no #ifdefs.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
Tested-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
v5 -> v6:
 - remove the pt_regs field and use preexisting thread_info flag.
v5: https://lore.kernel.org/linuxppc-dev/20260714075935.1830145-1-mkchauras@gmail.com/

v4 -> v5:
 - Fixed build failure where BITS macro is not available
v4: https://lore.kernel.org/linuxppc-dev/20260707063729.387129-1-mkchauras@gmail.com/

v3 -> v4:
 - Use syscall_get_error (Michal)
v3:https://lore.kernel.org/linuxppc-dev/20260703081100.1681924-1-mkchauras@gmail.com/ 

v2 -> v3:
 - Last fix is not working for -1 syscall. Fixed that with this.
v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com

v1 -> v2:
 - Fix issues in the previous fix (Michal)
v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com

 arch/powerpc/include/asm/syscall.h     | 6 ++++++
 arch/powerpc/include/asm/thread_info.h | 1 +
 arch/powerpc/kernel/syscall.c          | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 834fcc4f7b54..19d1739af0b7 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -98,6 +98,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
 			regs->gpr[3] = val;
 		}
 	}
+	/*
+	 * Mark that a return value has been explicitly set by seccomp or
+	 * ptrace so that system_call_exception() can skip the syscall
+	 * unconditionally, even when the user requested syscall(-1).
+	 */
+	set_thread_flag(TIF_SYSCALL_RET);
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ee3b9adb5b67..bf08b476fb3b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -119,6 +119,7 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_SYSCALL_RET		21	/* syscall error value set */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index a9da2af6efa8..9d1b29f44ea0 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -22,6 +22,9 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
 
+	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
+		return syscall_get_error(current, regs);
+
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
-- 
2.55.0


