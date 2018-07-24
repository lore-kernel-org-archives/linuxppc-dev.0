Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZpL53fNjzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 05:28:13 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6OJNdvF019762
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ke8xh3yqg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:11 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 24 Jul 2018 15:28:10 -0400
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
Subject: [PATCH 4/7] powerpc/traps: Use REG_FMT in show_signal_msg()
Date: Tue, 24 Jul 2018 16:27:17 -0300
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180724192720.32417-5-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify the message format by using REG_FMT as the register format.  This
avoids having two different formats and avoids checking for MSR_64BIT.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4faab4705774..047d980ac776 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void)
 static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 			    unsigned long addr)
 {
-	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-		"at %08lx nip %08lx lr %08lx code %x\n";
-	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
-		"at %016lx nip %016lx lr %016lx code %x\n";
-
 	if (!unhandled_signal(current, signr))
 		return;
 
-	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-	       current->comm, current->pid, signr,
-	       addr, regs->nip, regs->link, code);
+	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
+		" nip "REG_FMT" lr "REG_FMT" code %x\n",
+		current->comm, current->pid, signr, addr,
+		regs->nip, regs->link, code);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1
