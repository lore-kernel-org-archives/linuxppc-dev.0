Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qRNs5KfDzF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 18:59:22 +1000 (AEST)
Message-Id: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/process: fix nested output in
 show_user_instructions()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 muriloo@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Aug 2018 08:59:18 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When two processes crash at the same time, we sometimes encounter
nesting in the middle of a line:

[    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
[    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
[    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
[    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79

This patch fixes it by preparing complete lines in a buffer and
printing it at once.

Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/process.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..c722ce4ca1c0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1303,32 +1303,33 @@ void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
 	int i;
+	char buf[96]; /* enough for 8 times 9 + 2 chars */
+	int l = 0;
 
 	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
 
-	pr_info("%s[%d]: code: ", current->comm, current->pid);
-
 	for (i = 0; i < instructions_to_print; i++) {
 		int instr;
 
 		if (!(i % 8) && (i > 0)) {
-			pr_cont("\n");
-			pr_info("%s[%d]: code: ", current->comm, current->pid);
+			pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
+			l = 0;
 		}
 
 		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
-			pr_cont("XXXXXXXX ");
+			l += sprintf(buf + l, "XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-				pr_cont("<%08x> ", instr);
+				l += sprintf(buf + l, "<%08x> ", instr);
 			else
-				pr_cont("%08x ", instr);
+				l += sprintf(buf + l, "%08x ", instr);
 		}
 
 		pc += sizeof(int);
 	}
 
-	pr_cont("\n");
+	if (l)
+		pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
 }
 
 struct regbit {
-- 
2.13.3
