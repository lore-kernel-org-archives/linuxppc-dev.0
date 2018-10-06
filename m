Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B33C677E8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 16:55:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201852089D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201852089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42SCRW123SzDr6B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 03:55:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42SCLv0HZnzF3KN
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Oct 2018 03:51:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42SCLh26NXz9ttCD;
 Sat,  6 Oct 2018 18:51:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hqZtd1JjuDVF; Sat,  6 Oct 2018 18:51:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42SCLh1XQzz9ttC7;
 Sat,  6 Oct 2018 18:51:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CCB2E8B793;
 Sat,  6 Oct 2018 18:51:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id g2s5KcAkNGx8; Sat,  6 Oct 2018 18:51:14 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 776C08B74B;
 Sat,  6 Oct 2018 18:51:14 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 54E226F2BA; Sat,  6 Oct 2018 16:51:14 +0000 (UTC)
Message-Id: <03e8adf83ce1ef097fba634899307f58f6bf0e01.1538789120.git.christophe.leroy@c-s.fr>
In-Reply-To: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
References: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/3] powerpc/process: fix interleaved output in
 show_user_instructions()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 muriloo@linux.ibm.com
Date: Sat,  6 Oct 2018 16:51:14 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When two processes crash at the same time, we sometimes encounter
interleaving in the middle of a line:

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
Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: rebased
 v3: no change
 v2: Using seq_buf and reworked the loop to avoid redundant prints.

 arch/powerpc/kernel/process.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3396c419abf2..8dabf656d924 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/elf-randomize.h>
 #include <linux/pkeys.h>
+#include <linux/seq_buf.h>
 
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -1300,7 +1301,9 @@ static void show_instructions(struct pt_regs *regs)
 void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
-	int i;
+	int n = instructions_to_print;
+	struct seq_buf s;
+	char buf[96]; /* enough for 8 times 9 + 2 chars */
 
 	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
 
@@ -1314,29 +1317,27 @@ void show_user_instructions(struct pt_regs *regs)
 		return;
 	}
 
-	pr_info("%s[%d]: code: ", current->comm, current->pid);
+	seq_buf_init(&s, buf, sizeof(buf));
 
-	for (i = 0; i < instructions_to_print; i++) {
-		int instr;
+	while (n) {
+		int i;
 
-		if (!(i % 8) && (i > 0)) {
-			pr_cont("\n");
-			pr_info("%s[%d]: code: ", current->comm, current->pid);
-		}
+		seq_buf_clear(&s);
 
-		if (probe_kernel_address((const void *)pc, instr)) {
-			pr_cont("XXXXXXXX ");
-		} else {
-			if (regs->nip == pc)
-				pr_cont("<%08x> ", instr);
-			else
-				pr_cont("%08x ", instr);
+		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
+			int instr;
+
+			if (probe_kernel_address((const void *)pc, instr)) {
+				seq_buf_puts(&s, "XXXXXXXX ");
+				continue;
+			}
+			seq_buf_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
 		}
 
-		pc += sizeof(int);
+		if (!seq_buf_has_overflowed(&s))
+			pr_info("%s[%d]: code: %s\n", current->comm,
+				current->pid, s.buffer);
 	}
-
-	pr_cont("\n");
 }
 
 struct regbit {
-- 
2.13.3

