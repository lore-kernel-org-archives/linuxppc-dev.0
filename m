Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5832ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:02:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FE62148D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clkoYGm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FE62148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zjlt0sJMzF3Jt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 18:02:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="clkoYGm5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="clkoYGm5"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZjY12HRKzF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:52:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 908E6951;
 Wed, 17 Oct 2018 02:44:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 02:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=lOjV0qCQfAkymINK77lLdjCytp5YLH3pqs/kVkC95wQ=; b=clkoYGm5
 qieRwlQLJ+HWk410D4pUv23iudR2+Fjz00OfeZVyI9xS5aajM4EowVG3cBXlgRJt
 FVN5mSazTIE7Q1Mm0yszTxBnM2HEiqexd8CQamYsK7FX2Hdz/ZEdmJIEeDM+KFVe
 Ks0A4PagJdnJSOVfNzUs1NizuqrwfkTN2fEAqdLbRek1+/T1al8faZBwWJJValMi
 bRKp2awIg/6rRJDgVBRbCen6Vh+9GI03qu0VHbuLplYELqQY4FVS0JccbtpIvxzb
 4it2P19KeSKIqQeFRUPBJKmvmm5X9EOSex7MkzwEa8dEyTkzdNg8ul1WDQbLLftD
 9aTOJgxmMX79VQ==
X-ME-Sender: <xms:Z9rGW-oZzOeOwTt-pomAMB4AmZ8_kAVMYMfQahrBymSuiIWyg0-czg>
X-ME-Proxy: <xmx:Z9rGWxiih8cQG39_P7fm8YoV7ZLK9mNVR_6HocOnuv-5QU_eCmFeoA>
 <xmx:Z9rGWxL99FItpYbrDYqx500HYqpLFym0KRoNmgW4aInLL6hTlAfGSg>
 <xmx:Z9rGW3eT8-gLjyXgft5ECYYDd7ywlWf6a75H1-0j-Gp8rlzlOvBzJQ>
 <xmx:Z9rGWxOkeWxgtshSr5YFfWhWMT8pLx1Fu3wGfMKny-3jqiJiXl6EKA>
 <xmx:Z9rGWxIjaAijoQKXgQM0qmQIoWA2z0FkQKG-zhxBHg7Zp0t7JBQ2bg>
 <xmx:Z9rGWyw5NKvuxaG0bGHeW3N-G5S-MEUqW0NzBgeYEeuacqBC-30UDw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id ED9A6102DE;
 Wed, 17 Oct 2018 02:44:52 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/64s: Document that PPC supports nosmap
Date: Wed, 17 Oct 2018 17:44:23 +1100
Message-Id: <20181017064422.26119-5-ruscur@russell.cc>
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

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a5ad67d5cb16..8f78e75965f0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2764,7 +2764,7 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmap		[X86]
+	nosmap		[X86,PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-- 
2.19.1

