Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA52C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:42:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BC1208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BC1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bPGf2KNMzF3R8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 20:42:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bPDQ5l88zDqD3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:40:38 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bPDM4XSNz9ttC9;
 Thu, 18 Oct 2018 11:40:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id E-6vqnEbM4Tq; Thu, 18 Oct 2018 11:40:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bPDM43CJz9ttBS;
 Thu, 18 Oct 2018 11:40:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5256C8B8AB;
 Thu, 18 Oct 2018 11:40:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iDwWMkZTfzbD; Thu, 18 Oct 2018 11:40:35 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D08888B8B4;
 Thu, 18 Oct 2018 11:40:34 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9B5906F479; Thu, 18 Oct 2018 09:40:34 +0000 (UTC)
Message-Id: <a56d58b1d98ef47461b72ff94380c4e2dd953fd1.1539855545.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/uaccess: fix warning/error with access_ok()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 18 Oct 2018 09:40:34 +0000 (UTC)
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

With the following peace of code, the following compilation warning
is encountered:

	if (_IOC_DIR(ioc) != _IOC_NONE) {
		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {

drivers/platform/test/dev.c: In function ‘my_ioctl’:
drivers/platform/test/dev.c:219:7: warning: unused variable ‘verify’ [-Wunused-variable]
   int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

This patch fixes it by handing the type to __access_ok(), changing it
to an inline function for PPC64 as already done for PPC32

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: fixed the three direct users of __access_ok()

 arch/powerpc/include/asm/uaccess.h | 13 ++++++++-----
 arch/powerpc/kernel/process.c      |  2 +-
 arch/powerpc/lib/sstep.c           |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 15bea9a0f260..97faf0353919 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -47,13 +47,16 @@ static inline void set_fs(mm_segment_t fs)
  * This check is sufficient because there is a large enough
  * gap between user addresses and the kernel addresses
  */
-#define __access_ok(addr, size, segment)	\
-	(((addr) <= (segment).seg) && ((size) <= (segment).seg))
+static inline int __access_ok(int type, unsigned long addr, unsigned long size,
+			      mm_segment_t seg)
+{
+	return addr <= seg.seg && size <= seg.seg;
+}
 
 #else
 
-static inline int __access_ok(unsigned long addr, unsigned long size,
-			mm_segment_t seg)
+static inline int __access_ok(int type, unsigned long addr, unsigned long size,
+			      mm_segment_t seg)
 {
 	if (addr > seg.seg)
 		return 0;
@@ -64,7 +67,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 
 #define access_ok(type, addr, size)		\
 	(__chk_user_ptr(addr),			\
-	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
+	 __access_ok((type), (__force unsigned long)(addr), (size), get_fs()))
 
 /*
  * These are the main single-value transfer routines.  They automatically
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7ad304a3cc7d..4cc84fe13f9c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1310,7 +1310,7 @@ void show_user_instructions(struct pt_regs *regs)
 	 * Make sure the NIP points at userspace, not kernel text/data or
 	 * elsewhere.
 	 */
-	if (!__access_ok(pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS)) {
+	if (!__access_ok(VERIFY_READ, pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS)) {
 		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
 			current->comm, current->pid);
 		return;
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d81568f783e5..ff117418257c 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -110,9 +110,9 @@ static nokprobe_inline long address_ok(struct pt_regs *regs,
 {
 	if (!user_mode(regs))
 		return 1;
-	if (__access_ok(ea, nb, USER_DS))
+	if (__access_ok(VERIFY_WRITE, ea, nb, USER_DS))
 		return 1;
-	if (__access_ok(ea, 1, USER_DS))
+	if (__access_ok(VERIFY_WRITE, ea, 1, USER_DS))
 		/* Access overlaps the end of the user region */
 		regs->dar = USER_DS.seg;
 	else
-- 
2.13.3

