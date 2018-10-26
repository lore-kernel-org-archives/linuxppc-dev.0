Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6FC6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:51:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803CE20834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vj7POfyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803CE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hF5K6TLtzF3GK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 17:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="vj7POfyd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="vj7POfyd"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hDlT137FzF3FX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 17:35:49 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 9B5B8D56;
 Fri, 26 Oct 2018 02:35:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Oct 2018 02:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=lOjV0qCQfAkymINK77lLdjCytp5YLH3pqs/kVkC95wQ=; b=vj7POfyd
 Qo7f7ZjKv+EiQyCvDmhyd90NZK13+QTG9nJy32vH2rxBKjmOl67lGGG26amb6FfJ
 i2M2+SvxuJkqVqXP70DbUmLE2iSS7tsA5v82Kgz6UEHSWJA1AtABDJR5Ks6d+swY
 0G++mqYpcwYMlHG8JU1ues6i0Wsm37rFyhlL3r6bbjyyByYwCfuqmaEeJ7L4JP/8
 MSFj+4XukY9pZE+7WhyLlsfY1N6qd0l2Avw+RfBwVvhpyl/jbbidVOsz+fbsSFmT
 PTS71nZcTFFr2dWnLOrv3Fc6JlC+Z1awdvgQSuLnlnl3PGPERmIJ6OZwmhWj9z+x
 9arvq2/Fn2HzAg==
X-ME-Sender: <xms:wrXSW1tfCqCiVA02kr-olCJ51-cRSgpSKMoziCVXko3YW5y5z0lWPw>
X-ME-Proxy: <xmx:wrXSWx30j4Ba852zQbukny99WPox-5bGLmdd8KjBJr9hqT7VZPH9NQ>
 <xmx:wrXSWysu2cRR5zsPu9tbS4M_0b_C4qwUzuTp6vLDCV6toCQNWyhzbQ>
 <xmx:wrXSW34AOducswoupDtxDa12ykanC19SfHwh8ST4igE19Pu4WMAUBg>
 <xmx:wrXSW-dl5Q6rS7zoLnuDxvYKDiIF_uzzfavQIJMv8YseQl7pjp_Hgg>
 <xmx:wrXSW0zU-SuBdLPtFefMvgKk5rfRGWXZEvidubwcU8tDDigS84HOqw>
 <xmx:wrXSWwaWENHcAGoZmfshhsS0vvIF5uTj1OBQnXAl_JF5OqD6q1fBow>
Received: from crackle.ozlabs.ibm.com (pa49-195-157-6.pa.nsw.optusnet.com.au
 [49.195.157.6])
 by mail.messagingengine.com (Postfix) with ESMTPA id 01259102EE;
 Fri, 26 Oct 2018 02:35:42 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/64s: Document that PPC supports nosmap
Date: Fri, 26 Oct 2018 17:35:13 +1100
Message-Id: <20181026063513.30806-6-ruscur@russell.cc>
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

