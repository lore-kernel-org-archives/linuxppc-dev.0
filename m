Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04ECC2BA16
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 04:16:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E9720769
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 04:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClGlRFG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E9720769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48xDc347LbzDr10
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ClGlRFG6; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48xDZ973vfzDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 14:14:23 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id b72so192783pfb.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zgDFMy/Gv8ep/+c/TvkBZMzuYiPjCgcXqQOMU35HMgI=;
 b=ClGlRFG66OGaEzj5EAVUohYZiuw6uV+KLw6RmsTNaPzdye9RNVZPBN+7JA0H1yU3mB
 8ilH3GJGJY9NRc5wwI/IgaKmYixSqVbX3KWkdxfT+BWnqXMDtDy/IH27KDRiCaSlvrF4
 t61wPeRtLUT9YY7FxptK8WyS3tIcuiSpOEFjLnlM3sa2GrAKEoV+++xEau01Iki93n43
 OkrsuALN+wbHb6UvJCD8oKT+LNdLymGKhEV+Cth7EUP4w8GE79wKbdeVOqt391vVdP5s
 Lryp+tEJ1BSmCnFV1R3SHdJ8HhK1QinT9tKXwp6zuFkcANjqsHWfWzULvvEU4sonPmvX
 LugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zgDFMy/Gv8ep/+c/TvkBZMzuYiPjCgcXqQOMU35HMgI=;
 b=OgYNt1iCbovp5pbQIfbBKGtRrojX+xJhdqc2qbqgmM+wCmTXphW9I8v09SxBul8a7y
 NhYkjivDtQdHY7eY/IL4rHe2u5IIBdjJgzHXTmPTTaM21gs1SaS9TMCjNztQ80PePMCE
 COqF1vO0e/aZYcEfRLyQrlJ+iD5146W0kMaUnfVoL/rHwaqOI1JzaRglba8k75K5ENZI
 oHKhTKBuWeytwfZyFIIQdsrhSrsNyJTw0YTdUL8IoJPkavvXj2joClVKJ6Mpr4DK6YxW
 kqOEvoTDhfwD/DV1Pa/4E/x/Q2I040KZ/wHzutd1hLKQkjVEN2sbUtO9N3I1YiQNAd0H
 0sDg==
X-Gm-Message-State: AGi0PuZwfcVnwvfOQutbN7+qETixYTWrUPnL0p0nsSreHsoXj5HAG+3I
 vQLpjLe+ON3X4xPiPBhZd7T8d+Y9
X-Google-Smtp-Source: APiQypIR6hLsuzrHbeT8uvES0AOdiWFHoHd7zQMO/Pe46yWv0fE7TUpOfYObk8KkcFXGPCp12Li12A==
X-Received: by 2002:a65:670e:: with SMTP id u14mr162428pgf.264.1586232859965; 
 Mon, 06 Apr 2020 21:14:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id t1sm350321pjf.26.2020.04.06.21.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 21:14:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/uaccess: evaluate macro arguments once,
 before user access is allowed
Date: Tue,  7 Apr 2020 14:12:45 +1000
Message-Id: <20200407041245.600651-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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

get/put_user can be called with nontrivial arguments. fs/proc/page.c
has a good example:

    if (put_user(stable_page_flags(ppage), out)) {

stable_page_flags is quite a lot of code, including spin locks in the
page allocator.

Ensure these arguments are evaluated before user access is allowed.
This improves security by reducing code with access to userspace, but
it also fixes a PREEMPT bug with KUAP on powerpc/64s:
stable_page_flags is currently called with AMR set to allow writes,
it ends up calling spin_unlock(), which can call preempt_schedule. But
the task switch code can not be called with AMR set (it relies on
interrupts saving the register), so this blows up.

It's fine if the code inside allow_user_access is preemptible, because
a timer or IPI will save the AMR, but it's not okay to explicitly
cause a reschedule.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I took this patch out of the series because there is some discussion
about the other patches, and if we enable KUAP over probe_kernel_*
functions then it's technically a change of behaviour so I'm happy to
wait until next merge window or this discussion resolves itself.

This patch should fix the bugs and cause for security concern of running
arbitrary argument evaluation with user access allowed.

 arch/powerpc/include/asm/uaccess.h | 49 +++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 2f500debae21..0969285996cb 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -166,13 +166,17 @@ do {								\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
+	__typeof__(*(ptr)) __pu_val = (x);			\
+	__typeof__(size) __pu_size = (size);			\
+								\
 	if (!is_kernel_addr((unsigned long)__pu_addr))		\
 		might_fault();					\
-	__chk_user_ptr(ptr);					\
+	__chk_user_ptr(__pu_addr);				\
 	if (do_allow)								\
-		__put_user_size((x), __pu_addr, (size), __pu_err);		\
+		__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err);	\
 	else									\
-		__put_user_size_allowed((x), __pu_addr, (size), __pu_err);	\
+		__put_user_size_allowed(__pu_val, __pu_addr, __pu_size, __pu_err); \
+								\
 	__pu_err;						\
 })
 
@@ -180,9 +184,13 @@ do {								\
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	__typeof__(size) __pu_size = (size);				\
+									\
 	might_fault();							\
-	if (access_ok(__pu_addr, size))			\
-		__put_user_size((x), __pu_addr, (size), __pu_err);	\
+	if (access_ok(__pu_addr, __pu_size))				\
+		__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
+									\
 	__pu_err;							\
 })
 
@@ -190,8 +198,12 @@ do {								\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
-	__chk_user_ptr(ptr);					\
-	__put_user_size((x), __pu_addr, (size), __pu_err);	\
+	__typeof__(*(ptr)) __pu_val = (x);			\
+	__typeof__(size) __pu_size = (size);			\
+								\
+	__chk_user_ptr(__pu_addr);				\
+	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
+								\
 	__pu_err;						\
 })
 
@@ -283,15 +295,18 @@ do {								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
-	__chk_user_ptr(ptr);					\
+	__typeof__(size) __gu_size = (size);			\
+								\
+	__chk_user_ptr(__gu_addr);				\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
 	barrier_nospec();					\
 	if (do_allow)								\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);		\
+		__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
 	else									\
-		__get_user_size_allowed(__gu_val, __gu_addr, (size), __gu_err);	\
+		__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
+								\
 	__gu_err;						\
 })
 
@@ -300,12 +315,15 @@ do {								\
 	long __gu_err = -EFAULT;					\
 	__long_type(*(ptr)) __gu_val = 0;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	__typeof__(size) __gu_size = (size);				\
+									\
 	might_fault();							\
-	if (access_ok(__gu_addr, (size))) {		\
+	if (access_ok(__gu_addr, __gu_size)) {				\
 		barrier_nospec();					\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+		__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
+									\
 	__gu_err;							\
 })
 
@@ -314,10 +332,13 @@ do {								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
-	__chk_user_ptr(ptr);					\
+	__typeof__(size) __gu_size = (size);			\
+								\
+	__chk_user_ptr(__gu_addr);				\
 	barrier_nospec();					\
-	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+								\
 	__gu_err;						\
 })
 
-- 
2.23.0

