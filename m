Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3DECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:57:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D59214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 06:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZWbW84w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D59214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zjfc5NDqzF3PJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 17:57:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZWbW84w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="lZWbW84w"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZjY13kr6zF3WD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 17:52:37 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id EF3D5C19;
 Wed, 17 Oct 2018 02:44:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Oct 2018 02:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=LzAzogtkuUTJP/AQhqASQ9BZCLBbzAkcpG7zLgMIneA=; b=lZWbW84w
 5JRRAX4pIhgKnkQ/ZAsVtXLcvUH3rOJumJfTFfhNsWLXeMUQGQgnQJUX9EF1/hGJ
 4wbHAmFGTdcoFzZuYd848VKBPVxvfqv/cJ4b1t/dG+0XaqxTh67RNRIxUdsWsJ6r
 OGdchfynr5BXuvzvOnGSbsj1sssi2EPLFcOdnHPQqRapwuOKLSBQrh2g1gYCMtSS
 zLTt+p8sp6ACSKbod8APzMLzzlxxuNAf9VaBEhNMxCtGyJwCyFJLVZbBEr0KcM4c
 oKGgrDEg7tsta0sJyoAp+V6Rewb/pnwcd6T22cPTMIFCbRirYICQghQBX9Yw5Nl6
 sliUOxQBmvdBGw==
X-ME-Sender: <xms:ZNrGW8twZTnwuuYejA4H5cVjj2jrGv2ubRgWMTZztkk7tcbUP4q_ZA>
X-ME-Proxy: <xmx:ZNrGWzpN0GqK3FMRX3GGVAbg2rI1LVshqpBNqH2IkqWfJIDLYrCA-Q>
 <xmx:ZNrGW4xg9aTbvxzixDi-ftPpW2Bax1YMdvjzW-wmA5rMeIJz81T4ig>
 <xmx:ZNrGW_knIW_RGW3y1Ts9x1gshpwHuD-S2zuM5C57NPEWxRCLfdBbEQ>
 <xmx:ZNrGW2KpJdmMRxIgCF4mPoH3O-o8sH94B2HS8JxR1PsgQGz3IcCH-A>
 <xmx:ZNrGW5vUxns8bM6m0mHWXbnWDkv3Hz0hRz5AFHDk31GCCUKWwMtlJw>
 <xmx:ZNrGW9wUiHkpFYZb50a-nWDwWwHByPRrvaCuinSRODGY8qVWkyf4Ww>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 67723102EA;
 Wed, 17 Oct 2018 02:44:50 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/64s: Disable KHRAP with nosmap option
Date: Wed, 17 Oct 2018 17:44:22 +1100
Message-Id: <20181017064422.26119-4-ruscur@russell.cc>
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

KHRAP is similar to SMAP on x86 platforms, so implement support for
the same kernel parameter.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/init_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7a9886f98b0c..10182ce3b94f 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -312,6 +312,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static bool disable_radix = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
+static bool disable_khrap = !IS_ENABLED(CONFIG_PPC_RADIX_KHRAP);
 
 static int __init parse_disable_radix(char *p)
 {
@@ -328,6 +329,18 @@ static int __init parse_disable_radix(char *p)
 }
 early_param("disable_radix", parse_disable_radix);
 
+static int __init parse_nosmap(char *p)
+{
+	/*
+	 * nosmap is an existing option on x86 where it doesn't return -EINVAL
+	 * if the parameter is set to something, so even though it's different
+	 * to disable_radix, don't return an error for compatibility.
+	 */
+	disable_khrap = true;
+	return 0;
+}
+early_param("nosmap", parse_nosmap);
+
 /*
  * If we're running under a hypervisor, we need to check the contents of
  * /chosen/ibm,architecture-vec-5 to see if the hypervisor is willing to do
@@ -381,6 +394,8 @@ void __init mmu_early_init_devtree(void)
 	/* Disable radix mode based on kernel command line. */
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
+	if (disable_radix || disable_khrap)
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX_KHRAP;
 
 	/*
 	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
-- 
2.19.1

