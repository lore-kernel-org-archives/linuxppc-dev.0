Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D90C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:28:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA242173C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DnApBmxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA242173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44X1Cf4vVxzDqTR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 14:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=5.45.198.251; helo=forward501j.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="DnApBmxI"; 
 dkim-atps=neutral
X-Greylist: delayed 361 seconds by postgrey-1.36 at bilbo;
 Sun, 31 Mar 2019 03:44:04 AEDT
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net
 [5.45.198.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Wkvm486HzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 03:44:04 +1100 (AEDT)
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::94])
 by forward501j.mail.yandex.net (Yandex) with ESMTP id 02BEF33800D6;
 Sat, 30 Mar 2019 19:44:01 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jkS9SZAv9F-hrEetawC;
 Sat, 30 Mar 2019 19:44:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1553964240; bh=ekrJJPkvvc2IIUgqhYsDD1G/Ckjf+XccsQQiJwR67Z8=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=DnApBmxIFOz4WPtDyKFku2DHBCTBllcg3nquqyW5gX9yoWPHjzirhQIFjjO90Mwe/
 Xp52jhwwjF+brDPqgA6bBwXXaI1dnNEU72Y6thZh46Owy41mFJ0yJNLA4+O4PWCLaH
 XIiOPJDaBosaoEXc5tZXNo3wn0HzUyrg/I46T+Qo=
Authentication-Results: mxback18j.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt4-c0b480c282c8.qloud-c.yandex.net with HTTP;
 Sat, 30 Mar 2019 19:43:53 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: "vgupta@synopsys.com" <vgupta@synopsys.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "mark@fasheh.com" <mark@fasheh.com>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>,
 "richard@nod.at" <richard@nod.at>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
 Dave Chinner <dchinner@redhat.com>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 George Spelvin <lkml@sdf.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Subject: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the
 swap function
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 30 Mar 2019 19:43:53 +0300
Message-Id: <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 31 Mar 2019 14:25:40 +1100
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
Cc: "mhocko@suse.com" <mhocko@suse.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>,
 "piaojun@huawei.com" <piaojun@huawei.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
 "jslaby@suse.cz" <jslaby@suse.cz>,
 "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
 "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "jannh@google.com" <jannh@google.com>,
 "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "lchen@suse.com" <lchen@suse.com>, "malat@debian.org" <malat@debian.org>,
 Morton Andrew <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace int type with size_t type of the size argument
in the swap function, also affect all its dependencies.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 include/linux/sort.h         | 2 +-
 kernel/jump_label.c          | 2 +-
 lib/extable.c                | 2 +-
 lib/sort.c                   | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 89be1be1790c..1078c287198c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -176,7 +176,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_ftrace_find(ip);
 }
 
-static void orc_sort_swap(void *_a, void *_b, int size)
+static void orc_sort_swap(void *_a, void *_b, size_t size)
 {
 	struct orc_entry *orc_a, *orc_b;
 	struct orc_entry orc_tmp;
diff --git a/include/linux/sort.h b/include/linux/sort.h
index 2b99a5dd073d..aea39d552ff7 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -6,6 +6,6 @@
 
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
-	  void (*swap)(void *, void *, int));
+	  void (*swap)(void *, void *, size_t));
 
 #endif
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bad96b476eb6..340b788571fb 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -45,7 +45,7 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static void jump_label_swap(void *a, void *b, int size)
+static void jump_label_swap(void *a, void *b, size_t size)
 {
 	long delta = (unsigned long)a - (unsigned long)b;
 	struct jump_entry *jea = a;
diff --git a/lib/extable.c b/lib/extable.c
index f54996fdd0b8..db2888342cd7 100644
--- a/lib/extable.c
+++ b/lib/extable.c
@@ -28,7 +28,7 @@ static inline unsigned long ex_to_insn(const struct exception_table_entry *x)
 #ifndef ARCH_HAS_RELATIVE_EXTABLE
 #define swap_ex		NULL
 #else
-static void swap_ex(void *a, void *b, int size)
+static void swap_ex(void *a, void *b, size_t size)
 {
 	struct exception_table_entry *x = a, *y = b, tmp;
 	int delta = b - a;
diff --git a/lib/sort.c b/lib/sort.c
index 50855ea8c262..60fbbc29104a 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -114,7 +114,7 @@ static void swap_bytes(void *a, void *b, size_t n)
 	} while (n);
 }
 
-typedef void (*swap_func_t)(void *a, void *b, int size);
+typedef void (*swap_func_t)(void *a, void *b, size_t size);
 
 /*
  * The values are arbitrary as long as they can't be confused with
@@ -138,7 +138,7 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
 	else if (swap_func == SWAP_BYTES)
 		swap_bytes(a, b, size);
 	else
-		swap_func(a, b, (int)size);
+		swap_func(a, b, size);
 }
 
 /**
@@ -187,7 +187,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  */
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp_func)(const void *, const void *),
-	  void (*swap_func)(void *, void *, int size))
+	  void (*swap_func)(void *, void *, size_t size))
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
-- 
2.21.0


