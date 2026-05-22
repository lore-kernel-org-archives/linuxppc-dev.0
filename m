Return-Path: <linuxppc-dev+bounces-21383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BABACD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKN6TRxz3bps;
	Fri, 22 May 2026 19:56:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443816;
	cv=none; b=W1e4U0bWHTI50GMjJSsBq8+mRvuvvgPFtjg+N6Br5C/Mhc80i5JqHWBfzX3d98mF+YGrKsaAWAJPR5shJiYOQ+qTQIg7aqfFxVCAreowN1fzuZZFNtlLjfpvI4CebfS79AK4Lrn3Sa7MeYFRuIcqYM/DnV7JFmJQyiAB119Bb4iPv4tcq0YqWpoQE20X3V5DsoDv4LjsoJxCl8XNMejwbw3wDRvE9XE2Xbe1R3dL0ksmfqmY4l8OCrQM065t8SjA9jVTkj5pLGQXM3uMI35K4onOJ34rGA25jsZCZNcVUreY1TJ917+i8c/xtKek4HY+f6vWeiWD5TXqDRDL3/IlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443816; c=relaxed/relaxed;
	bh=qIFh0EHf36xuaiQUrsEboCGTYqr33D+g0zvT7LVweRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2NCcbBdh8/xjSnhsm4yg6wcFaFCyLkBjczI8MO357q20q8JCqe7AtTOIkdX8aVUktQ5FXRGVcHxHkE0ewgzo3rQTgVdNLst7iCOujoV/tjMBk6bOTf+5wEsS668GCAsHjWThveVqLMGmR4O8R0OUJ649Mx48xiER0+dREpPwZ9F6fvTgxhDxCK0g+w4vtyTXw0pM7LNQll9AjJXvb8N5qGZC/ovMhmbq/sdcKt4VBqtff/9w/4OfxrtAhH0spgcRr5V8hrd+WnkLyd2y169dyIjdTTsVr2P4F8kTcW8P0lx78+BBtkzY/l1W4JWDqDTIaFzcR9W3gMilIYONCLpwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK/+SCV1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK/+SCV1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKM6JNzz3bwF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CF7D0405D5;
	Fri, 22 May 2026 09:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B38C1F00A3D;
	Fri, 22 May 2026 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443813;
	bh=qIFh0EHf36xuaiQUrsEboCGTYqr33D+g0zvT7LVweRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GK/+SCV19DAEftkWYjgk7KGHdZ26g54nGTimIvMTlmEhHFo2m7E4L3ZMiSkWmRjl9
	 LebQlYbpBMcDeyeowHBXdMpuNXCgGi4Eu4FKT+FdkFj2VbOtkr//nZPpuy6dbGOb5A
	 9Bx6QOLPalVGAj6A/SQG2+vTL8jBZ31/LtTA6ckpnSa2ubouz+qeLakiQfrYUoOxBf
	 3WkL6+qAS/KaszDC/ZXhZcajoroGm3oXukSR8XAd0S9lC5TsvARsLcu3+wFeV0lgxk
	 HBCfvARIHuN9Zmhq96C2HqgJr6tJk/oGBWQUVy0IYQ9lH76UBLqERH6lKnBmBgQA+w
	 Id6FLoY1W/yug==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 6/8] signal: Add unsafe_copy_siginfo_to_user()
Date: Fri, 22 May 2026 11:56:06 +0200
Message-ID: <07697a42c8ac6ea6ac600cbf0dabbdcbf814da31.1779441786.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779441786.git.chleroy@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=chleroy@kernel.org; h=from:subject:message-id; bh=CxukwNaaHfPCgLLuHd8f2xWMx67xuC8tWT39iKS4wZo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNhfqth079aduR3nLp8+V6t/eN3eGzvOZTu0qwbf/ XhckW9vREcpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYSNghRoaOKz3vFjPEsF7s ey3xdqeW1IL3oUHBYvVCQidv75VJXsbDyPAp4sfTzolvkqRnxjd/neo2u6hi+odXVcmaO4rd2hK Dq/kA
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


