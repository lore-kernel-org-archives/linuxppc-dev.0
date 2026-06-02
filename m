Return-Path: <linuxppc-dev+bounces-21862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94F9CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fl3DJnz2yrt;
	Tue, 02 Jun 2026 18:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390027;
	cv=none; b=CkfkjBZkEhHrs9OjMHaytLyUyIcrEQiKWTWd7JQlIKW7cHaWE1w90BwkEi1BWltd9Lb01h4f5AMXMsRenYqt5e8kDs5r6JFRJrtvPTxp7IMTPwRukQKkpt79ITbum3C82G+qED4RygEHPHh7B4SV+xRGwBYnnPkGDJp9lVMU9FWDvl+3TSVHalsIJ6eBSM36Q0bixTOwgd0Ow7zG52ApZ9846MP4YZomNWi9tSPM2YgLJiKkfHii4CYDMVpHSgDttE9KImvxZwVhlqF0hh58Vi5QqCRyM5s1jSNB60PFYYse2GharY2QpKZYtOefLfedlkBEO7TDSHYE73GsmTe6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390027; c=relaxed/relaxed;
	bh=qIFh0EHf36xuaiQUrsEboCGTYqr33D+g0zvT7LVweRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuT0GjDs+wQVAbPcCT/1flS1fbjgqZUHvlnfvMh79A6HGisuRusECYjgayGePDpTjlTtnkJfJTwxB+OJ4SEreNcsk/q8dntjin+d3hC7BsJp7HWL2/1Xky+8XY8FwlUr5Hb0l8ojKPQ5aXJnfuHtm5X+fKHJd4GGs5i4t5dujWnLNwqyE8fC7VYdFnFKv/2Z4vOQTLQypgzMFqjeQ5bbr5HmiJ9pF1dunCWjNRZpOXuVX8Rd/ElQBB57F1wHd0xJJUe/W7P2Ya9NV+ok8ZOFyC63/ZKmPz0GfFjprgG1IWgFF9U9eO6Y+3IWF9sQrpwFj82u4tYOWoLsev+mArzGGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3yh+9ql; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3yh+9ql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Fk4S60z3btR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:47:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C276A60098;
	Tue,  2 Jun 2026 08:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98DB1F00898;
	Tue,  2 Jun 2026 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390024;
	bh=qIFh0EHf36xuaiQUrsEboCGTYqr33D+g0zvT7LVweRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3yh+9qljNOGvMJg2vjR4qqPnlP9WDre9stzGTtmF/drPyf1BBSbJ0/CfzvDlDBv0
	 wR0Jk0sSLAsz4Os1NthdWFpgQvCaE3kGcv7mRLyPPD1krz5P5SO+BLo/gHi+6N/SAx
	 xxUk3pNiLi5dhp1UqIewE2g0mDkfNrMmCQqteAFeCP1NrxixFdO8tmQlY8W3zjKZo8
	 USPQYbrIyrjBy3yj4N1RwnQfmNCyKqjUNNrAAEufVD4xWSt/SRc7vakmEzryWGsboa
	 lm5YamYmdrkgnOy3Ig2SUZZ6+vHKjjz9RMyoF5HAOB3l0RAxF7XZB+tyOw0HKrIAOi
	 YKahPcXI6EY5Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/8] signal: Add unsafe_copy_siginfo_to_user()
Date: Tue,  2 Jun 2026 10:46:35 +0200
Message-ID: <026832f540ef269cf8693e3c3b58c759d0f63544.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
References: <cover.1780389863.git.chleroy@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=chleroy@kernel.org; h=from:subject:message-id; bh=CxukwNaaHfPCgLLuHd8f2xWMx67xuC8tWT39iKS4wZo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcjb+N5K92ag76ubrK0FRWzqipmM7zaLRT7+ZRnF3 z0p4G17RykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIDk9GhoMJ3Y/YzIMiPt/d LnpFrevwgd2HlvZOnRbR3Mc4Q4pFRJGRYYHZzE+JjnyFOk6Kv3g6HzFuXJMhVmC06QfnAvErHoH fmQA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

In the same spirit as commit fb05121fd6a2 ("signal: Add
unsafe_get_compat_sigset()"), implement an 'unsafe' version of
copy_siginfo_to_user() in order to use it within user access blocks.

For that, also add an 'unsafe' version of clear_user().

This commit adds the generic fallback for unsafe_clear_user().
Architectures wanting to use unsafe_copy_siginfo_to_user() within a
user_access_begin() section have to make sure they have their
own unsafe_clear_user().

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/signal.h  | 15 +++++++++++++++
 include/linux/uaccess.h |  1 +
 kernel/signal.c         |  5 -----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..3ee6c9463f8b 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -36,6 +36,21 @@ static inline void copy_siginfo_to_external(siginfo_t *to,
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from);
 int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from);
 
+static __always_inline char __user *si_expansion(const siginfo_t __user *info)
+{
+	return ((char __user *)info) + sizeof(struct kernel_siginfo);
+}
+
+#define unsafe_copy_siginfo_to_user(to, from, label) do {		\
+	siginfo_t __user *__ucs_to = to;				\
+	const kernel_siginfo_t *__ucs_from = from;			\
+	char __user *__ucs_expansion = si_expansion(__ucs_to);		\
+									\
+	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
+			    sizeof(struct kernel_siginfo), label);	\
+	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
+} while (0)
+
 enum siginfo_layout {
 	SIL_KILL,
 	SIL_TIMER,
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 56328601218c..43e573b172a2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -636,6 +636,7 @@ do {							\
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
 #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
 #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
+#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif /* !user_access_begin */
diff --git a/kernel/signal.c b/kernel/signal.c
index 2d102e025883..2c5eb741fe8c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3493,11 +3493,6 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 	return layout;
 }
 
-static inline char __user *si_expansion(const siginfo_t __user *info)
-{
-	return ((char __user *)info) + sizeof(struct kernel_siginfo);
-}
-
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from)
 {
 	char __user *expansion = si_expansion(to);
-- 
2.54.0


