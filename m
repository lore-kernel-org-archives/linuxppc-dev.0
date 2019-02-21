Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C541C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:45:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8C820880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="SLo9XSjW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7ESvZkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8C820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qMm3Y20zDqQV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="SLo9XSjW"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Y7ESvZkQ"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9f4lNbzDqPY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:38 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 6FD2D220D7;
 Thu, 21 Feb 2019 04:36:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=BR4nmlG38Vcfk
 JEZ7L+GC7sDOM8u+gc3unYkKg7uXUE=; b=SLo9XSjWMEjj3DF4Hye2wp9JbawlD
 UvhVhu/Rjvdohb0NPPAiCKYo6RX/sGCv7VQkPnsBsyqKhW21XQrd3lrHCh0RCwR6
 GpGB3hus3U1U4QNh0qpoKGld6pRvJYQzny78biWw47WpnTkhDkQiIdFLp4lOhS7C
 b3ilzY0Q9X+kZaaKvrYZXx2eiGC5/K7ntJvbqEy2HXhNW9Ie4KI0qaxbxkPI0xCO
 GvoQfcLevJJyBHCN4UZRLQZCPTyL5p0n9RWCGKBzrf2PGvy3h32nvtN2wdg5zLXB
 sbUR79MR6sPrDd5RWLPWDCvhUzf2cC/xhjT8vN+sTqvpi3Y+2Uo5OmpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=BR4nmlG38VcfkJEZ7L+GC7sDOM8u+gc3unYkKg7uXUE=; b=Y7ESvZkQ
 B6GNLB+PH4njI7EE5xcvOV5r1lOtZWjpFp8qgnaEzmBtC7nm3Az+dnEweTyIi0DX
 kwuwrDKo/kUmsYxhu8gU7veZjD6bRR9HfUrBhiz/yCbiEAbarptUQDuXg+Ude7zi
 1x7AgmxBG8mz8cHPi6t5HWq1rf7tQKLxcT5XhA/mNz6lUt0PSYcg4ftde7g9+cTA
 OzCBrJt74iOiuZwY8YI0fq8iqXU6vI8WuZStMGEM3GsRKr3g9pxDVIY3hBj+HYaH
 fuA1ISMYm5nHKtLruhfvwUMz/YYgLNBOQiwkokSS2IdBmCtwgThRidLh2UcjQ6Cq
 VBGHZPahAEo9OQ==
X-ME-Sender: <xms:JHFuXDPQZj8pp8Lhco2mVGRImHB2wu5IbIgWvyl4liLCYV1OPSMWZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:JHFuXKN4I_Yrmymn76Ddt99YACU6HizYQQCuDC7ZbPEsc1W1yaea8w>
 <xmx:JHFuXL5XqVcRH1GAKmygaiaVLjhPAshJOR-GwV6sk9dSjmmkQ3QX7w>
 <xmx:JHFuXIBBNpItHJnTavVD6OcniUMR1ALZACSqsxoULHTxdVibvvtlUg>
 <xmx:JHFuXKigRLKNO4AF6spU4Uib_tV_kT6mdGPPBwop_rs0_pKmZj8ClA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id E17D210312;
 Thu, 21 Feb 2019 04:36:33 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/7] powerpc/64: Setup KUP on secondary CPUs
Date: Thu, 21 Feb 2019 20:35:58 +1100
Message-Id: <20190221093601.27920-5-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some platforms (i.e. Radix MMU) need per-CPU initialisation for KUP.

Any platforms that only want to do KUP initialisation once
globally can just check to see if they're running on the boot CPU, or
check if whatever setup they need has already been performed.

Note that this is only for 64-bit.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/setup_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 771f280a6bf6..17921ee7f3a0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -390,6 +390,9 @@ void early_setup_secondary(void)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
 
+	/* Perform any KUP setup that is per-cpu */
+	setup_kup();
+
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
-- 
2.20.1

