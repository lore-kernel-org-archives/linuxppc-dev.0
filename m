Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D0CC43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4BF20721
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPXA/tff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4BF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tw5L4CTgzDqRK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 20:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PPXA/tff; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tvtt4GXTzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 20:35:50 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id b72so3213224pfb.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2020 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nDDlzkA7TMDvDw8f+yAOsZJ0rrP1wVb2+bqJUcdDBPc=;
 b=PPXA/tffRhEPdKy1z7qrlZkN7EQL4xFDyDqMEBXWyjy824D+DqyzKjhqwf72qHPZCd
 CYI+0WRn9QL021m8tCXttpwOpDbLC5WrRiVOtA9eL16wDvBElEFptzERapPT38pXxmb7
 iQX71p22ALRBqobeM+oZ6iQfjNjQgSi1LalCXTMt+//md46zhe3S9vkcLWF9YTUo+3RJ
 /Rj4bk3yLN0tJvN91mXNSFxh9LhI1kWYFzbqOUYxtcCwNAC+6Pvlu3gzLS2Ez7MR1r8W
 gzQ8YfEokuJjYWYQCgkAd6MDJj7xoW+44kJMC3wcDOg32MAn6RVtiRcwvVsMuI3LLYcJ
 FZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nDDlzkA7TMDvDw8f+yAOsZJ0rrP1wVb2+bqJUcdDBPc=;
 b=MpQic4FEW+yGUh+590jJkSu8dBmdVKM0Z75sXtzO2FA1uXpVMkpzcReghsylVyHfdF
 7Y16TJdPhlBPWjFBeKQaZQ7OCZs5pWQGw3Md4GlrmPWK9e5HOmNp01VTDsORIMAZnjim
 d5TtYKXq8fIa1MnfuV7kEXbkjpaJSsXJCSGCy65ufYl72Yd3h0BFjkRVL7y9dYxgZB0E
 fgmE+Q6jXMs/1eY4y2rS1LPfQzI6p8RHzLuTRumRXLlabVKSb7K/wbYauSMTgdgpVdjJ
 0qbUu4JzBmFIlWZv0if3quoyc9NTDLHXEw5dOt6jpgU/+W+1IHRrnz5Fe8EZFOhP7e70
 1YrA==
X-Gm-Message-State: AGi0PuaaH5I0zCE5N7T15FBLZuVRrMnG3VtHwNa9BlkaTeVYLvRaOFmS
 5eZl+G65ZlugfKURi5/y/wUKJlbr
X-Google-Smtp-Source: APiQypKtWURs+BqDkoeUjkTN9utpxwLdDTM45jmXJnFa9rMGDf99GgjbslpaVu0aPvigg9lZAKpMQQ==
X-Received: by 2002:a63:2014:: with SMTP id g20mr6670477pgg.180.1585906547500; 
 Fri, 03 Apr 2020 02:35:47 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id i7sm5502677pfq.217.2020.04.03.02.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 02:35:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] powerpc/uaccess: add more __builtin_expect annotations
Date: Fri,  3 Apr 2020 19:35:29 +1000
Message-Id: <20200403093529.43587-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200403093529.43587-1-npiggin@gmail.com>
References: <20200403093529.43587-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/uaccess.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 144d01645d68..c6b0203c3750 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -48,16 +48,16 @@ static inline void set_fs(mm_segment_t fs)
  * gap between user addresses and the kernel addresses
  */
 #define __access_ok(addr, size, segment)	\
-	(((addr) <= (segment).seg) && ((size) <= (segment).seg))
+	likely(((addr) <= (segment).seg) && ((size) <= (segment).seg))
 
 #else
 
 static inline int __access_ok(unsigned long addr, unsigned long size,
 			mm_segment_t seg)
 {
-	if (addr > seg.seg)
+	if (unlikely(addr > seg.seg))
 		return 0;
-	return (size == 0 || size - 1 <= seg.seg - addr);
+	return likely(size == 0 || size - 1 <= seg.seg - addr);
 }
 
 #endif
@@ -177,7 +177,7 @@ do {								\
 	else									\
 		__put_user_size_allowed(__pu_val, __pu_addr, __pu_size, __pu_err); \
 								\
-	__pu_err;						\
+	__builtin_expect(__pu_err, 0);				\
 })
 
 #define __put_user_check(x, ptr, size)					\
@@ -192,6 +192,7 @@ do {								\
 		__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
 									\
 	__pu_err;							\
+	__builtin_expect(__pu_err, 0);					\
 })
 
 #define __put_user_nosleep(x, ptr, size)			\
@@ -204,7 +205,7 @@ do {								\
 	__chk_user_ptr(__pu_addr);				\
 	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
 								\
-	__pu_err;						\
+	__builtin_expect(__pu_err, 0);				\
 })
 
 
@@ -307,7 +308,7 @@ do {								\
 		__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 								\
-	__gu_err;						\
+	__builtin_expect(__gu_err, 0);				\
 })
 
 #define __get_user_check(x, ptr, size)					\
@@ -325,6 +326,7 @@ do {								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 									\
 	__gu_err;							\
+	__builtin_expect(__gu_err, 0);					\
 })
 
 #define __get_user_nosleep(x, ptr, size)			\
@@ -339,7 +341,7 @@ do {								\
 	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 								\
-	__gu_err;						\
+	__builtin_expect(__gu_err, 0);				\
 })
 
 
-- 
2.23.0

