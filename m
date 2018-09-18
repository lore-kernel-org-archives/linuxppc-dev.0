Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9kj6QsvzF3Hs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:00:13 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:49 +0200
Message-Id: <20180918175850.4437-8-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 8/9] signal/powerpc: Simplify _exception_pkey by using
 force_sig_pkuerr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call force_sig_pkuerr directly instead of rolling it by hand
in _exception_pkey.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/traps.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e5ea69222459..ab1bd06d7c44 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -364,18 +364,10 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 
 void _exception_pkey(struct pt_regs *regs, unsigned long addr, int key)
 {
-	siginfo_t info;
-
 	if (!exception_common(SIGSEGV, regs, SEGV_PKUERR, addr))
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_code = SEGV_PKUERR;
-	info.si_addr = (void __user *) addr;
-	info.si_pkey = key;
-
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_pkuerr((void __user *) addr, key);
 }
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
-- 
2.17.1
