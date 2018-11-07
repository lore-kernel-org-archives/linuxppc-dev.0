Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B6CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235B22081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235B22081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qyNz6HGWzF38T
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 07:16:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qyLH33XczF36C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 07:14:14 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qyL81wKVz9ttSR;
 Wed,  7 Nov 2018 21:14:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id pQAdwXAlLRnJ; Wed,  7 Nov 2018 21:14:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qyL81JkKz9ttSH;
 Wed,  7 Nov 2018 21:14:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AD01C8B81F;
 Wed,  7 Nov 2018 21:14:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id YZm2Rmr25aWE; Wed,  7 Nov 2018 21:14:10 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BC308B814;
 Wed,  7 Nov 2018 21:14:10 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3E5EB69970; Wed,  7 Nov 2018 20:14:10 +0000 (UTC)
Message-Id: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lkdtm: print real addresses
To: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed,  7 Nov 2018 20:14:10 +0000 (UTC)
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

Today, when doing a lkdtm test before the readiness of the
random generator, (ptrval) is printed instead of the address
at which it perform the fault:

[ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
[ 1597.337142] lkdtm: attempting ok execution at (ptrval)
[ 1597.337398] lkdtm: attempting bad execution at (ptrval)
[ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
[ 1597.344769] Unable to handle kernel paging request for instruction fetch
[ 1597.351392] Faulting instruction address: 0x77858000
[ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]

If the lkdtm test is done later on, it prints an hashed address.

In both cases this is pointless. The purpose of the test is to
ensure the kernel generates an Oops at the expected address,
so real addresses needs to be printed. This patch fixes that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/misc/lkdtm/perms.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 53b85c9d16b8..fa54add6375a 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -47,7 +47,7 @@ static noinline void execute_location(void *dst, bool write)
 {
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %p\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
@@ -55,7 +55,7 @@ static noinline void execute_location(void *dst, bool write)
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
-	pr_info("attempting bad execution at %p\n", func);
+	pr_info("attempting bad execution at %px\n", func);
 	func();
 }
 
@@ -66,14 +66,14 @@ static void execute_user_location(void *dst)
 	/* Intentionally crossing kernel/user memory boundary. */
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %p\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing);
 	do_nothing();
 
 	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
 				   EXEC_SIZE, FOLL_WRITE);
 	if (copied < EXEC_SIZE)
 		return;
-	pr_info("attempting bad execution at %p\n", func);
+	pr_info("attempting bad execution at %px\n", func);
 	func();
 }
 
@@ -82,7 +82,7 @@ void lkdtm_WRITE_RO(void)
 	/* Explicitly cast away "const" for the test. */
 	unsigned long *ptr = (unsigned long *)&rodata;
 
-	pr_info("attempting bad rodata write at %p\n", ptr);
+	pr_info("attempting bad rodata write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
 }
 
@@ -100,7 +100,7 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 		return;
 	}
 
-	pr_info("attempting bad ro_after_init write at %p\n", ptr);
+	pr_info("attempting bad ro_after_init write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
 }
 
@@ -112,7 +112,7 @@ void lkdtm_WRITE_KERN(void)
 	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
 	ptr = (unsigned char *)do_overwritten;
 
-	pr_info("attempting bad %zu byte write at %p\n", size, ptr);
+	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
 	memcpy(ptr, (unsigned char *)do_nothing, size);
 	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
 
@@ -185,11 +185,11 @@ void lkdtm_ACCESS_USERSPACE(void)
 
 	ptr = (unsigned long *)user_addr;
 
-	pr_info("attempting bad read at %p\n", ptr);
+	pr_info("attempting bad read at %px\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
 
-	pr_info("attempting bad write at %p\n", ptr);
+	pr_info("attempting bad write at %px\n", ptr);
 	*ptr = tmp;
 
 	vm_munmap(user_addr, PAGE_SIZE);
-- 
2.13.3

