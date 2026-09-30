Return-Path: <linuxppc-dev+bounces-28621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444FCA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 23:52:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwBgX4FPCz2xrC;
	Thu, 01 Oct 2026 09:52:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790812376;
	cv=none; b=IiTbDn4pSq3T/2jt1wmVif9S9blwNLZ8tohMSB4yeEHjvdxFZkBKz50nyQuabIEVf8QZBjgM/6SOPPfKHBstquCTxTwoZaYLSPWDL+6oWi16suxk3vQYfbr5OFGjsU4AWzyBd2UOuWfMTGBzK3HbXl4yrnyfEOBSHEBTKVOfCBoMrWPVBT3wVsN+SbqRoeTmDTJu5pLY7lf+7qZ0FI383PBh1XwHITvaEWfaB6/3DPz1gA2LQodjUOWbuewa+IZjepHGWBbfDPqb/bJM85OE5fop4sDtk/KDfo3IB68JhTaE7czsuMAweecQUo+uJe6/R+TEz+i7OdBqO2AcWhN5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790812376; c=relaxed/relaxed;
	bh=fnir0UfbY9fTB7q6F0wLenGmJSxBViPfzZ07mhGO01w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIap0fHWYYWlHfcp4qxKdwW74DzkrHE0QGgWxTeaFBHE5motEn17Up26Xu/pOSZ9fvp8VcDz9Jsv48GQMhWt5hcvJMe2B71hHDDf6GP0rsQvQSzZg2nMmgJ/obf48P7moF89/UYDL/hV3PPcea0orA44j5IUo8w4MA6y1Qoym+911pfP4/eXK6hnFR4X5pMWXJAku+2rVrJ01a0k6q2GwYGqDhwxTZ03Wck6PUlKv7JnkPT8XOyjNeredRSRGpx9aPLJh6LwmiFGoyYWArmMEC3YNFJHpJ8aJq1x60GJ3Jvx5TPSNzZg2g1yxCMcT8FeMfFnSVbVzkhXuPcNaw6p/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXjDpTIS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXjDpTIS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwBgV6P4sz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 09:52:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3FA7044773;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E16C1F0089F;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=fnir0UfbY9fTB7q6F0wLenGmJSxBViPfzZ07mhGO01w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXjDpTIS/H2BjiV8CVHN1bPjTNueAWwdoQwFipOwHT8LRX87hfM9F9uaeJ5UwArQW
	 C9J0+6DC3/UoPFelLQO8dATeVAf8Hk8uy7d6WKfhjWDv7pwDvc5UcAORFbChNCIV3M
	 yLCbKfRR2DPtlQPfGH/hIG9fdDQ2bKIkEyEzajnDh/TNGVynCweaA8m8XS4HKcAZs6
	 4M8ZqNP2bsesmBdu9q6+GWxI7a3EAnQNdD3rXDFbiOhqRtxzCEVIG822lPKI4kT5QD
	 I8tgRRNE1tHDilVLLCHhdnBk9tdE/twrHO9qQ7LL7Ac0W92WubhEOI5jo6OZ+n6NH+
	 a48MorAppU7Xg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 09/11] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Wed, 30 Sep 2026 16:52:37 -0700
Message-Id: <20260930235247.157921-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=kees@kernel.org; h=from:subject; bh=qTdDoPd0Ksi1U8I5fG05y9W5Ggvnl1eHPIzcw+f38s8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxxjdhP1OyM2dz9nNEdZap913693nZret7Q/3l+f/ I9h2T/XjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImcPMfwh7M0ZHFBXuPsrx+d 73puX5b2renq9ofVZ/7I6UYZHWKVM2H4zaLZLc3ulXfkSmUdj1F02qtVD2ZvO7dvwtVr23meGXc JsAIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.1.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..b03cfd8528f5 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
 	if (seq_buf_used(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.34.1


