Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC807C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 20:36:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E4721726
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 20:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NwZy5mf6zDqKS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 06:36:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cyphar.com
 (client-ip=2001:67c:2050:104:0:2:25:2; helo=mx2.mailbox.org;
 envelope-from=cyphar@cyphar.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=cyphar.com
Received: from mx2.mailbox.org (mx2a.mailbox.org
 [IPv6:2001:67c:2050:104:0:2:25:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NwFZ60DZzDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 06:21:22 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mx2.mailbox.org (Postfix) with ESMTPS id 41E63A0195;
 Wed,  4 Sep 2019 22:21:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de
 [80.241.56.125]) (amavisd-new, port 10030)
 with ESMTP id zRSgFI6ciWwx; Wed,  4 Sep 2019 22:21:15 +0200 (CEST)
From: Aleksa Sarai <cyphar@cyphar.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
 "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>,
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Christian Brauner <christian@brauner.io>
Subject: [PATCH v12 04/12] perf_event_open: switch to copy_struct_from_user()
Date: Thu,  5 Sep 2019 06:19:25 +1000
Message-Id: <20190904201933.10736-5-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-1-cyphar@cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 Jiri Olsa <jolsa@redhat.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
 Aleksa Sarai <asarai@suse.de>, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, linuxppc-dev@lists.ozlabs.org,
 Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, David Drysdale <drysdale@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-api@vger.kernel.org,
 Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 containers@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The change is very straightforward, and takes advantage of the (very
minor) efficiency improvements in copy_struct_from_user() -- that the
memchr_inv() check is done on a buffer instead of one-at-at-time with
get_user().

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/events/core.c | 45 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151bae..fe5f58443ba6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10498,55 +10498,26 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	u32 size;
 	int ret;
 
-	if (!access_ok(uattr, PERF_ATTR_SIZE_VER0))
-		return -EFAULT;
-
-	/*
-	 * zero the full structure, so that a short copy will be nice.
-	 */
+	/* Zero the full structure, so that a short copy will be nice. */
 	memset(attr, 0, sizeof(*attr));
 
 	ret = get_user(size, &uattr->size);
 	if (ret)
 		return ret;
 
-	if (size > PAGE_SIZE)	/* silly large */
-		goto err_size;
-
-	if (!size)		/* abi compat */
+	/* ABI compatibility quirk: */
+	if (!size)
 		size = PERF_ATTR_SIZE_VER0;
-
 	if (size < PERF_ATTR_SIZE_VER0)
 		goto err_size;
 
-	/*
-	 * If we're handed a bigger struct than we know of,
-	 * ensure all the unknown bits are 0 - i.e. new
-	 * user-space does not rely on any kernel feature
-	 * extensions we dont know about yet.
-	 */
-	if (size > sizeof(*attr)) {
-		unsigned char __user *addr;
-		unsigned char __user *end;
-		unsigned char val;
-
-		addr = (void __user *)uattr + sizeof(*attr);
-		end  = (void __user *)uattr + size;
-
-		for (; addr < end; addr++) {
-			ret = get_user(val, addr);
-			if (ret)
-				return ret;
-			if (val)
-				goto err_size;
-		}
-		size = sizeof(*attr);
+	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
+	if (ret) {
+		if (ret == -E2BIG)
+			goto err_size;
+		return ret;
 	}
 
-	ret = copy_from_user(attr, uattr, size);
-	if (ret)
-		return -EFAULT;
-
 	attr->size = size;
 
 	if (attr->__reserved_1)
-- 
2.23.0

