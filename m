Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC6EC6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:45:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486EE20834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxzZ0Nkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486EE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hDz52cJJzF3G9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 17:45:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxzZ0Nkl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="jxzZ0Nkl"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hDlK4vwtzF1fF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 17:35:41 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 5E07BC03;
 Fri, 26 Oct 2018 02:35:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Oct 2018 02:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=JrpLbsVIdYwVXdtYxEMytstLYsvT3mpZQM0w0N8xZfk=; b=jxzZ0Nkl
 oHgkv/zGz7wWaxrL7hfAuCaUqbi0AaJjoS+O5e2IxgrU2lPk4H75r5NZCVbepg+7
 te8E1eus0A+BXY8RoH77lFRoRfy8yixBzWohZdTrPtiBxt6z1/HRF8sZUT8JeEwi
 m79GT60IudXCXIDxcZc4j2b+LMqz7UXiTSlbtr8q3jx9YF3k4OQvNa8LuhV+Ff73
 wFjyJW3poYJJUxf3o0ifjjjow7uhHCYjnO3fYVESnhZOq+CWAC4T1+eMNNxv28mv
 crdF5BQvA2H2zAyDreayzQLXez5aeMvulKXqS7R+3ukiI4nk0q7H+FgpR4lBVQDi
 VuXgfN1nq30yyw==
X-ME-Sender: <xms:urXSWzxAc8oGSg5gZFzjs6wuSF42AFGZ_CDrKJDqmrpgjn30ysYqfQ>
X-ME-Proxy: <xmx:urXSW-E9Su_jKm9IfPR-bPt7XsLSM8mEydi6vzhAhyPOKCZQ3bCZtw>
 <xmx:urXSW_h06fOdoTFAM2O9ngC_xt1mhX8ljoojLWbyjr8oebW2U3GfKg>
 <xmx:urXSW5_m96X6zNs7cizbuaoVrP9MN7B_Y2RP_FDGNmaCVV9rRUnk4w>
 <xmx:urXSW2qJGsqHx3cw91eMXEOFrNMDRwN0gjerDvwH9ydAY8BZwJLI4Q>
 <xmx:urXSW4-pERwYno2NjzSb-iV_Yhm2Kr3-JaSyJM0UWAVimkSWCAcZjA>
 <xmx:urXSW64W6EqzWBUFGbDaPM0i6BBDYEerU8-AAcz15-Yy2W2e9gcBcA>
Received: from crackle.ozlabs.ibm.com (pa49-195-157-6.pa.nsw.optusnet.com.au
 [49.195.157.6])
 by mail.messagingengine.com (Postfix) with ESMTPA id 67BFF102EE;
 Fri, 26 Oct 2018 02:35:35 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/lib: checksum GUAP support
Date: Fri, 26 Oct 2018 17:35:11 +1100
Message-Id: <20181026063513.30806-4-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026063513.30806-1-ruscur@russell.cc>
References: <20181026063513.30806-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wrap the checksumming code in GUAP locks and unlocks.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/lib/checksum_wrappers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index a0cb63fb76a1..c67db0a6e18b 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -28,6 +28,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 {
 	unsigned int csum;
 
+	unlock_user_access();
 	might_sleep();
 
 	*err_ptr = 0;
@@ -60,6 +61,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	}
 
 out:
+	lock_user_access();
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
@@ -69,6 +71,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 {
 	unsigned int csum;
 
+	unlock_user_access();
 	might_sleep();
 
 	*err_ptr = 0;
@@ -97,6 +100,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 	}
 
 out:
+	lock_user_access();
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
-- 
2.19.1

