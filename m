Return-Path: <SRS0=bRvR=GM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8759C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 03:37:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F04623998
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 03:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F04623998
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCQdC4PFnzDqyX
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 14:37:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=131.153.2.45;
 helo=h4.fbrelay.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=codefail.de
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com
 [131.153.2.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DCQTx0QWjzDqw0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2021 14:30:44 +1100 (AEDT)
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com
 [198.54.127.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 60588809C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2021 22:26:16 -0500 (EST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 268396009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2021 22:26:05 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.217])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id EAD71600C8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2021 03:26:04 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/8] powerpc/uaccess: Add unsafe_copy_from_user
Date: Fri,  8 Jan 2021 21:25:50 -0600
Message-Id: <20210109032557.13831-2-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210109032557.13831-1-cmr@codefail.de>
References: <20210109032557.13831-1-cmr@codefail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implement raw_copy_from_user_allowed() which assumes that userspace read
access is open. Use this new function to implement raw_copy_from_user().
Finally, wrap the new function to follow the usual "unsafe_" convention
of taking a label argument.

The new raw_copy_from_user_allowed() calls non-inline __copy_tofrom_user()
internally. This is still safe to call inside user access blocks formed
with user_*_access_begin()/user_*_access_end() since asm functions are not
instrumented for tracing.

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
---
 arch/powerpc/include/asm/uaccess.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 501c9a79038c..698f3a6d6ae5 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -403,38 +403,45 @@ raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
 }
 #endif /* __powerpc64__ */
 
-static inline unsigned long raw_copy_from_user(void *to,
-		const void __user *from, unsigned long n)
+static inline unsigned long
+raw_copy_from_user_allowed(void *to, const void __user *from, unsigned long n)
 {
-	unsigned long ret;
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		ret = 1;
+		unsigned long ret = 1;
 
 		switch (n) {
 		case 1:
 			barrier_nospec();
-			__get_user_size(*(u8 *)to, from, 1, ret);
+			__get_user_size_allowed(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
 			barrier_nospec();
-			__get_user_size(*(u16 *)to, from, 2, ret);
+			__get_user_size_allowed(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
 			barrier_nospec();
-			__get_user_size(*(u32 *)to, from, 4, ret);
+			__get_user_size_allowed(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
 			barrier_nospec();
-			__get_user_size(*(u64 *)to, from, 8, ret);
+			__get_user_size_allowed(*(u64 *)to, from, 8, ret);
 			break;
 		}
 		if (ret == 0)
 			return 0;
 	}
 
+	return __copy_tofrom_user((__force void __user *)to, from, n);
+}
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+
 	barrier_nospec();
 	allow_read_from_user(from, n);
-	ret = __copy_tofrom_user((__force void __user *)to, from, n);
+	ret = raw_copy_from_user_allowed(to, from, n);
 	prevent_read_from_user(from, n);
 	return ret;
 }
@@ -542,6 +549,9 @@ user_write_access_begin(const void __user *ptr, size_t len)
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
 #define unsafe_put_user(x, p, e) __put_user_goto(x, p, e)
 
+#define unsafe_copy_from_user(d, s, l, e) \
+	unsafe_op_wrap(raw_copy_from_user_allowed(d, s, l), e)
+
 #define unsafe_copy_to_user(d, s, l, e) \
 do {									\
 	u8 __user *_dst = (u8 __user *)(d);				\
-- 
2.26.1

