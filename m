Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B47C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:13:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184D3206B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFxDIoDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4311dY0jZczDqP5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 01:13:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFxDIoDl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=wout2-smtp.messagingengine.com (client-ip=64.147.123.25;
 helo=wout2-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="NFxDIoDl"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4311QW1v65zDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 01:04:18 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id B3A389B0;
 Thu, 22 Nov 2018 09:04:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 22 Nov 2018 09:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=qdi+0bS4linqvTXoN6BDMEcE4Kx/v77WVn28gx/bGHU=; b=NFxDIoDl
 +37anZXVD3bR/BfYxL9I4Ii73CxWvUro2WQ6RIZjHVX40Oj8S8vyvKQWuOH+y4n0
 wk1NdHcTB3Ybhg+hyRcAQJUa5EXpK+oP0jJDO6cdue4G6TQiYAhsX9RY8AqDfp/L
 lAcDDPBSq8GUjGHrRj+CLC3OX/hgQ2XVryn71zYVWqqxRnAL6k9OdPDh05c6KhzL
 eCzFh5T3/2TJafgXV/rWctkubU5r0PtVZN3aOM+JFI09curX9daintauhz/DRC9P
 t7QwbE1OKaHXLmqTmOlpHEk8zJS1iIn4oWDROHAn1Tz65pb/PLRYbUCuD8S+QZae
 deovfkzroXRnBA==
X-ME-Sender: <xms:X7f2W6qW99N1xT6gEUlfw9K7RnDJQdPkuGLjd9pBtSWIAxO-VmoOAg>
X-ME-Proxy: <xmx:X7f2W8rdZM6lid6T8GcRqn3UwDuRdYZwRAoIeuKcGGamyV2CCpaQGA>
 <xmx:X7f2Wwk0SEr6T7-9ORKXMBHNYmg7jXAKkHyizqF_9aFihTldc7k00g>
 <xmx:X7f2W4y7kC85Y39VfFTq3v6AX4lFucgK4f5pwOylUI3QkN9FEQ7Qdg>
 <xmx:X7f2WwmOxzNTSk8Olw42Q4-gLG_RyApaRaJ06iUEAQW_PMcKv-EogA>
 <xmx:X7f2W5dCdO-iFa5hRLYBV017GSt854WUbdpgahPLpq7KctTElW_9Pg>
 <xmx:X7f2W6rApl2XgdZNXLWUg939P5CUODgxmYM4tP0pOpjM-F4Q2rfSmw>
Received: from crackle.ozlabs.ibm.com.com (124-171-154-44.dyn.iinet.net.au
 [124.171.154.44])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2F0F9102E4;
 Thu, 22 Nov 2018 09:04:11 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/64: Setup KUP before feature fixups
Date: Fri, 23 Nov 2018 01:04:14 +1100
Message-Id: <20181122140416.3447-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140416.3447-1-ruscur@russell.cc>
References: <20181122140416.3447-1-ruscur@russell.cc>
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
Cc: kernel-hardening@lists.openwall.com, Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The subsequent implementation of KUAP for radix makes use of a MMU
feature in order to patch out assembly when KUAP is disabled or
unsupported.  This won't work unless there's an entry point for
KUP support before the feature magic happens, so relocate
setup_kup() earlier in setup.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/setup_64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 0f4e06ab70a5..cc20dc3e7b69 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -331,6 +331,12 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	configure_exceptions();
 
+	/*
+	 * Configure Kernel Userspace Protection. This needs to happen before
+	 * feature fixups for platforms that implement this using features.
+	 */
+	setup_kup();
+
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
 	setup_feature_keys();
@@ -372,7 +378,6 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	btext_map();
 #endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
-	setup_kup();
 }
 
 #ifdef CONFIG_SMP
-- 
2.19.1

