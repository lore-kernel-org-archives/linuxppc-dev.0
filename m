Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819EC677E8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 16:59:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DBC2089D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 16:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DBC2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42SCX76wyqzF3Qn
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Oct 2018 03:59:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42SCLv0HZGzF3KC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Oct 2018 03:51:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42SCLf4QVCz9ttCB;
 Sat,  6 Oct 2018 18:51:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8v7ZINekMdD8; Sat,  6 Oct 2018 18:51:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42SCLf3pSgz9ttC7;
 Sat,  6 Oct 2018 18:51:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F2AB8B793;
 Sat,  6 Oct 2018 18:51:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dFL4D4wFWV9n; Sat,  6 Oct 2018 18:51:13 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AFC2E8B74B;
 Sat,  6 Oct 2018 18:51:12 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 5BAAB6F2BA; Sat,  6 Oct 2018 16:51:12 +0000 (UTC)
Message-Id: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/3] powerpc/process: fix casting and missing header
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 muriloo@linux.ibm.com
Date: Sat,  6 Oct 2018 16:51:12 +0000 (UTC)
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

This patch fixes the following warnings. The first ones are leftovers
from when __get_user() was replaced by probe_kernel_address().

The last one is from when show_user_instructions() was added.

arch/powerpc/kernel/process.c:1287:22: warning: incorrect type in argument 2 (different address spaces)
arch/powerpc/kernel/process.c:1287:22:    expected void const *src
arch/powerpc/kernel/process.c:1287:22:    got unsigned int [noderef] <asn:1>*<noident>
arch/powerpc/kernel/process.c:1319:21: warning: incorrect type in argument 2 (different address spaces)
arch/powerpc/kernel/process.c:1319:21:    expected void const *src
arch/powerpc/kernel/process.c:1319:21:    got unsigned int [noderef] <asn:1>*<noident>
arch/powerpc/kernel/process.c:1302:6: warning: symbol 'show_user_instructions' was not declared. Should it be static?

Fixes: 7b051f665c32d ("powerpc: Use probe_kernel_address in show_instructions")
Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: no change. Serie rebased on top of latest powerpc/merge (87dbfc1308ee)
 v3: new in v3 to fix sparse warnings reported by snowpatch on the serie

 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d9d4eb2ea6c9..3396c419abf2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/stacktrace.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -1281,7 +1282,7 @@ static void show_instructions(struct pt_regs *regs)
 #endif
 
 		if (!__kernel_text_address(pc) ||
-		     probe_kernel_address((unsigned int __user *)pc, instr)) {
+		    probe_kernel_address((const void *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
@@ -1323,7 +1324,7 @@ void show_user_instructions(struct pt_regs *regs)
 			pr_info("%s[%d]: code: ", current->comm, current->pid);
 		}
 
-		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
+		if (probe_kernel_address((const void *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-- 
2.13.3

