Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426JfK3L2TzF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 23:47:36 +1000 (AEST)
Message-Id: <3fdf75eed98b1fa22da77e675692a86a7a9986a7.1536327756.git.christophe.leroy@c-s.fr>
In-Reply-To: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/process: Constify the number of insns printed
 by show instructions functions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 muriloo@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  7 Sep 2018 13:47:33 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

instructions_to_print var is assigned value 16 and there is no
way to change it.

This patch replaces it by a constant.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: no change
 v2: no change

 arch/powerpc/kernel/process.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2a39f7aca846..7d86b4f7949e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1261,17 +1261,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	return last;
 }
 
-static int instructions_to_print = 16;
+#define NR_INSN_TO_PRINT	16
 
 static void show_instructions(struct pt_regs *regs)
 {
 	int i;
-	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
-			sizeof(int));
+	unsigned long pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	printk("Instruction dump:");
 
-	for (i = 0; i < instructions_to_print; i++) {
+	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
 		int instr;
 
 		if (!(i % 8))
@@ -1304,11 +1303,11 @@ static void show_instructions(struct pt_regs *regs)
 void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
-	int n = instructions_to_print;
+	int n = NR_INSN_TO_PRINT;
 	struct seq_buf s;
 	char buf[96]; /* enough for 8 times 9 + 2 chars */
 
-	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
+	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	seq_buf_init(&s, buf, sizeof(buf));
 
-- 
2.13.3
