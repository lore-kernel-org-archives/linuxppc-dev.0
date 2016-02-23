Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C3BF1A0730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:39:59 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D37C7140B9C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:58 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 23 Feb 2016 13:39:58 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 10F7F3578058
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:55 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N3dksG6029594
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N3dMl5000976
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:22 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH v5 4/9] powerpc: Explicitly disable math features when copying
 thread
Date: Tue, 23 Feb 2016 14:38:17 +1100
Message-Id: <1456198702-29657-5-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently when threads get scheduled off they always giveup the FPU,
Altivec (VMX) and Vector (VSX) units if they were using them. When they are
scheduled back on a fault is then taken to enable each facility and load
registers. As a result explicitly disabling FPU/VMX/VSX has not been
necessary.

Future changes and optimisations remove this mandatory giveup and fault
which could cause calls such as clone() and fork() to copy threads and run
them later with FPU/VMX/VSX enabled but no registers loaded.

This patch starts the process of having MSR_{FP,VEC,VSX} mean that a
threads registers are hot while not having MSR_{FP,VEC,VSX} means that the
registers must be loaded. This allows for a smarter return to userspace.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dccc87e..e0c3d2d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 		f = ret_from_fork;
 	}
+	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
 	sp -= STACK_FRAME_OVERHEAD;
 
 	/*
-- 
2.7.1
