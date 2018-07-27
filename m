Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cXD124n9zF0q0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:58:56 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6REs8eQ077958
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:58:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kg3p7nh1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:58:53 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 27 Jul 2018 10:58:52 -0400
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
Subject: [PATCH v2 01/10] powerpc/traps: Print unhandled signals in a separate
 function
Date: Fri, 27 Jul 2018 11:58:02 -0300
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180727145811.12334-2-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Isolate the logic of printing unhandled signals out of _exception_pkey().
No functional change, only code rearrangement.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..cbd3dc365193 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -301,26 +301,32 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+static void show_signal_msg(int signr, struct pt_regs *regs, int code,
+			    unsigned long addr)
+{
+	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+		"at %08lx nip %08lx lr %08lx code %x\n";
+	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
+		"at %016lx nip %016lx lr %016lx code %x\n";
+
+	if (show_unhandled_signals && unhandled_signal(current, signr)) {
+		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
+				   current->comm, current->pid, signr,
+				   addr, regs->nip, regs->link, code);
+	}
+}
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-		unsigned long addr, int key)
+		     unsigned long addr, int key)
 {
 	siginfo_t info;
-	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %08lx nip %08lx lr %08lx code %x\n";
-	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-			"at %016lx nip %016lx lr %016lx code %x\n";
 
 	if (!user_mode(regs)) {
 		die("Exception in kernel mode", regs, signr);
 		return;
 	}
 
-	if (show_unhandled_signals && unhandled_signal(current, signr)) {
-		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   current->comm, current->pid, signr,
-				   addr, regs->nip, regs->link, code);
-	}
+	show_signal_msg(signr, regs, code, addr);
 
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
 		local_irq_enable();
-- 
2.17.1
