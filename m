Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9kf6Bm0zF3HV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:00:08 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:48 +0200
Message-Id: <20180918175850.4437-7-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey for
 handling pkey exceptions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that _exception no longer calls _exception_pkey it is no longer
necessary to handle any signal with any si_code.  All pkey exceptions
are SIGSEGV with paired with SEGV_PKUERR.  So just handle
that case and remove the now unnecessary parameters from _exception_pkey.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/asm/bug.h |  2 +-
 arch/powerpc/kernel/traps.c    | 10 +++++-----
 arch/powerpc/mm/fault.c        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index fd06dbe7d7d3..fed7e6241349 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -133,7 +133,7 @@ struct pt_regs;
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
-extern void _exception_pkey(int, struct pt_regs *, int, unsigned long, int);
+extern void _exception_pkey(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
 extern bool die_will_crash(void);
 extern void panic_flush_kmsg_start(void);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c38bec51dd84..e5ea69222459 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -362,20 +362,20 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 	return true;
 }
 
-void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long addr, int key)
+void _exception_pkey(struct pt_regs *regs, unsigned long addr, int key)
 {
 	siginfo_t info;
 
-	if (!exception_common(signr, regs, code, addr))
+	if (!exception_common(SIGSEGV, regs, SEGV_PKUERR, addr))
 		return;
 
 	clear_siginfo(&info);
-	info.si_signo = signr;
-	info.si_code = code;
+	info.si_signo = SIGSEGV;
+	info.si_code = SEGV_PKUERR;
 	info.si_addr = (void __user *) addr;
 	info.si_pkey = key;
 
-	force_sig_info(signr, &info, current);
+	force_sig_info(info.si_signo, &info, current);
 }
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a84d06b7d50d..406d0e0ef096 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -152,7 +152,7 @@ static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
 	if (!user_mode(regs))
 		return SIGSEGV;
 
-	_exception_pkey(SIGSEGV, regs, SEGV_PKUERR, address, pkey);
+	_exception_pkey(regs, address, pkey);
 
 	return 0;
 }
-- 
2.17.1
