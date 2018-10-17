Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E9ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:04:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD6E2148D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QosqBfsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD6E2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zjpm1V0LzF3Xf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 18:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QosqBfsL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="QosqBfsL"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZjY12WwgzF3J2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:52:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 7996CC13;
 Wed, 17 Oct 2018 02:44:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 02:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=bplNJQefl6J6fctYabjbENmmxSGt1qT9P8rzG8qQtaE=; b=QosqBfsL
 QFR30/ok2d4F4vy/BQNCd+tGNZRtrKez9Y0IHgCcL7K+t2IAxujBO7LFt8nx4GIL
 hjMkAq3LkaT2ZebI1tkVJ5eQLK8S3ljW9+Iou1I0pA6vIXZlI+V1X0na5nmfNgdg
 zVCIb15/nDQev8SbAxlnj4OI+US7XXLUwut85j1UykXW1zHmzPJI9cRYNQ0snh8B
 V8Xexbh0yJvMquXWJLnJi+koXryn+XzNLUUcy5NL++hTthEMRdBkWTHlylR+IYea
 WJEU2TIiKRqNDWEAU5fv2URrzD+slnom+AHtNNJ3DuRyZgbnK40kqZ8ZVQKZC7UW
 9WSx/cS27KlCxQ==
X-ME-Sender: <xms:YdrGW-6-71IVJFTSQ_ExKcOE5-E2CqqMPvLgsloGyc4rotEeNeAZrg>
X-ME-Proxy: <xmx:YtrGW3E8YoPQH1V7u3HSLj4ZnDEkfa_pI74OY4s1m8p_Pp6LosLcwg>
 <xmx:YtrGW6232dqHUFOObNaGniLkS-L4roRDGryLJeYPa38QtcoALy4ddg>
 <xmx:YtrGW8VDMYIQLzWmIZBusvn_ClnebhYSQM3e1ZyOvyTimr4agtbMSA>
 <xmx:YtrGW_Ft2T-zwdE11xlVoiOEx_8s_35yue0BM1xe-dNJzx_WsZCSfQ>
 <xmx:YtrGW2mOd3z9dNLNqCH0sI4lh2wXniY8OZleyjtauSucQuUfpAKIrA>
 <xmx:YtrGW4AkluQaECGIbUBEUcxNGtcGKAckRkEo3OJQe2ucO70dVRMUpA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id D77CD102DE;
 Wed, 17 Oct 2018 02:44:47 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/lib: checksum KHRAP support
Date: Wed, 17 Oct 2018 17:44:21 +1100
Message-Id: <20181017064422.26119-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017064422.26119-1-ruscur@russell.cc>
References: <20181017064422.26119-1-ruscur@russell.cc>
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
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wrap the checksumming code in KHRAP locks and unlocks.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/lib/checksum_wrappers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index a0cb63fb76a1..695460a29c9f 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -26,7 +26,7 @@
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 			       int len, __wsum sum, int *err_ptr)
 {
-	unsigned int csum;
+	unsigned int csum, amr = unlock_user_access();
 
 	might_sleep();
 
@@ -60,6 +60,7 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	}
 
 out:
+	lock_user_access(amr);
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
@@ -67,7 +68,7 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
 __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 			     __wsum sum, int *err_ptr)
 {
-	unsigned int csum;
+	unsigned int csum, amr = unlock_user_access();
 
 	might_sleep();
 
@@ -97,6 +98,7 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 	}
 
 out:
+	lock_user_access(amr);
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
-- 
2.19.1

