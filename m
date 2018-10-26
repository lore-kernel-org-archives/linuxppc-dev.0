Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D58C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:48:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E4220834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTrucS2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E4220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hF2S0xnnzDrNS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 17:48:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTrucS2k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="XTrucS2k"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hDlP39hYzF3G3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 17:35:45 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 23F29B64;
 Fri, 26 Oct 2018 02:35:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Oct 2018 02:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=OaG9flm6THUx8KzpU5DIrxABEc00tTkUvovifPQ+rsg=; b=XTrucS2k
 aJHS5AGOV28XnADRBXPL993/bdKM1ad0ybLDcz68j/ULWXBmfayhBxj3aXcODzRl
 l+6vX5t/KMsLIzPfP0MFR7IyKq+fIbKj/E0ki8qNTqOgHgdYHoO78FRSSQIQc9iE
 j+MxpS6IE/zXzcgsJLFCBf8Hp0nXqyOf8B3hRhgVVSGTe7vdsu0GmY5BCfYwkkgs
 XdFUJH2Rfbv0D9uyAoTi0PRbZVFFlCEBUd9zgGBsixft/7HAr53APtIieE23rq6s
 ZfoUtOFcbkMNiiBVfTfuj9ylaxSSVOYxzGEaCK9nmRdgMLVgcMJ0YlLKB1XdaJDN
 78iiPzX+BCeJjw==
X-ME-Sender: <xms:vrXSW-ccCZxj-N4TShLqF1SsVCB1Fe4s64ohFXJ3JC3yuPJnVU5CFA>
X-ME-Proxy: <xmx:vrXSWzxaheFxbiRB6sOWOxTKu2Q9tsvdoRLKPLrM4KBw_AIHo-BOXw>
 <xmx:vrXSW7dJckBIyfhKMadV2z76r98-nqe4TZk6hsATcE2EVssXACPfkg>
 <xmx:vrXSW_IVcu1cjbDC695TBjhB6oqr0ixKgQMRr7_n64ZuS7owK89-XA>
 <xmx:vrXSW8FBKZqGDkbT0xXTCSmszu8Y3oVbVSAZ5XZgNlD_Ql7ny6awtw>
 <xmx:vrXSW5pQKE4I_mW5x1qG1_umSU5r8SgjgS8vgKOB8UXTgrBvwDHugw>
 <xmx:vrXSWxl0Kssukn8BMi4YVq6BwRxNU_ILxIg8NPrTovdmCdwn142qrQ>
Received: from crackle.ozlabs.ibm.com (pa49-195-157-6.pa.nsw.optusnet.com.au
 [49.195.157.6])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4E949102E0;
 Fri, 26 Oct 2018 02:35:38 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/64s: Disable GUAP with nosmap option
Date: Fri, 26 Oct 2018 17:35:12 +1100
Message-Id: <20181026063513.30806-5-ruscur@russell.cc>
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

GUAP is similar to SMAP on x86 platforms, so implement support for
the same kernel parameter.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/init_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7a9886f98b0c..b26641df36f2 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -312,6 +312,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static bool disable_radix = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
+static bool disable_guap = !IS_ENABLED(CONFIG_PPC_RADIX_GUAP);
 
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
+	disable_guap = true;
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
+	if (disable_radix || disable_guap)
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX_GUAP;
 
 	/*
 	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
-- 
2.19.1

