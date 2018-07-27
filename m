Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cXD80mqrzF0tD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:59:03 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6REs698049046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:01 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3qudc45-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:01 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 27 Jul 2018 10:59:00 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/10] powerpc/traps: Return early in show_signal_msg()
Date: Fri, 27 Jul 2018 11:58:03 -0300
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180727145811.12334-3-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify the logic of show_signal_msg() to return early, if possible.
Replace printk_ratelimited() by printk() and a default rate limit burst to
limit displaying unhandled signals messages.

Mainly reason of this change is to improve readability of the function.
The conditions to display the message were coupled together in one single
`if` statement.

Splitting out the rate limit check outside show_signal_msg() makes it
easier to the caller decide if it wants to respect a printk rate limit or
not.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index cbd3dc365193..4faab4705774 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -301,6 +301,13 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+static bool show_unhandled_signals_ratelimited(void)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	return show_unhandled_signals && __ratelimit(&rs);
+}
+
 static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 			    unsigned long addr)
 {
@@ -309,11 +316,12 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
 		"at %016lx nip %016lx lr %016lx code %x\n";
 
-	if (show_unhandled_signals && unhandled_signal(current, signr)) {
-		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   current->comm, current->pid, signr,
-				   addr, regs->nip, regs->link, code);
-	}
+	if (!unhandled_signal(current, signr))
+		return;
+
+	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
+	       current->comm, current->pid, signr,
+	       addr, regs->nip, regs->link, code);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
@@ -326,7 +334,8 @@ void _exception_pkey(int signr, struct pt_regs *regs, int code,
 		return;
 	}
 
-	show_signal_msg(signr, regs, code, addr);
+	if (show_unhandled_signals_ratelimited())
+		show_signal_msg(signr, regs, code, addr);
 
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
 		local_irq_enable();
-- 
2.17.1
