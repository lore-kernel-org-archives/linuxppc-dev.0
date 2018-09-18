Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F9k811hDzF3HH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 03:59:43 +1000 (AEST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:46 +0200
Message-Id: <20180918175850.4437-5-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 5/9] signal/powerpc: Factor the common exception code
 into exception_common
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is brittle and wrong to populate si_pkey when there was not a pkey
exception.  The field does not exist for all si_codes and in some
cases another field exists in the same memory location.

So factor out the code that all exceptions handlers must run
into exception_common, leaving the individual exception handlers
to generate the signals themselves.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/traps.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f651fa91cdc9..f6c778b5144f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -338,14 +338,12 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	show_user_instructions(regs);
 }
 
-void _exception_pkey(int signr, struct pt_regs *regs, int code,
-		     unsigned long addr, int key)
+static bool exception_common(int signr, struct pt_regs *regs, int code,
+			      unsigned long addr)
 {
-	siginfo_t info;
-
 	if (!user_mode(regs)) {
 		die("Exception in kernel mode", regs, signr);
-		return;
+		return false;
 	}
 
 	show_signal_msg(signr, regs, code, addr);
@@ -361,6 +359,16 @@ void _exception_pkey(int signr, struct pt_regs *regs, int code,
 	 */
 	thread_pkey_regs_save(&current->thread);
 
+	return true;
+}
+
+void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long addr, int key)
+{
+	siginfo_t info;
+
+	if (!exception_common(signr, regs, code, addr))
+		return;
+
 	clear_siginfo(&info);
 	info.si_signo = signr;
 	info.si_code = code;
-- 
2.17.1
