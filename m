Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75429C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 03:38:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C442075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 03:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="NGX44SfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lry47j3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TYc63s1qzDqQW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 14:37:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.27; helo=out3-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="NGX44SfZ"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="lry47j3Q"; dkim-atps=neutral
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TYZH5FJ7zDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 14:36:22 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id EBF5621D8B;
 Tue, 26 Mar 2019 23:36:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 26 Mar 2019 23:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=NMcQeoraUCvV/OCXw9iC9TjFZd
 Yxy0Jtr66rCdJazDQ=; b=NGX44SfZSueZ0ULyFpi/ZR8IJ90nzNdgeSLjeEh145
 nEiOHiwNHq9yhh5ciX9QpgsfU+Vt3l81SF2sA8Nrsb/7IJyLTe9LQJgZs1aue7G7
 MqqiTOq5oKW8e9ye+2CRk8kpwd915D8KdESOgag/v2HL2d8NvRrI1j6cZw6dqO8V
 1rVI4rRobYpxOvow2Px2uLg1cy//B3tARaWKUHkOABhYELLktiucvUvmz1zjSBOj
 bKzQZzP06YvYVCQQRf3dhVn4aNdjqj2KsSvgpOCGyFu9Juncqcy6jmryOTBBbfHs
 l9gvF2me4krGqs3Lf4/i+kuFfKUYNTXOsuW8PCoLHZ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NMcQeoraUCvV/OCXw
 9iC9TjFZdYxy0Jtr66rCdJazDQ=; b=lry47j3QSZjK+Gi8NVDRZCCEB6qO2yzlk
 NZToowx9+iPT0B5JxLUPrJgLsz9ahxCCTg7+WW3rkbHuzNTYFRwVd5AdMPNwc6PP
 viLwMmEqVgBnION8HJEFcGmnILSQju5nFpsgj8nEjeNbGVPcRR0XPFSxk6YKL8j9
 0iBigy16qAQL3Hd7XHlPh5RaM7xF+PXANinPG2HG/1ZBoOoPnrXgShn1EleH3FEg
 Yc/PzZ2nQByM2+qRbfBHf8bO7FJu5Q9+sty/aXt4IYZwJ+kCSv3sHwpCI31TgHaP
 KpH+29kTINJlVFifjFEkp4LILCSEbbiC0m9xTv4SptM1zlw2EDiXA==
X-ME-Sender: <xms:su-aXGvITdWKE8hbJWkt2OGogIEdQbRz8hnNP5T1J9eLPKrfoTuiSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicu
 oehruhhstghurhesrhhushhsvghllhdrtggtqeenucffohhmrghinhepieegrdhssgenuc
 fkphepuddvvddrleelrdekvddruddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhs
 tghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:su-aXHY2F4opy0mksA5BgceYl2OnPKBIxf28dH2ClNbOVMi8UAO2zg>
 <xmx:su-aXH7QefK2Ja_pvbyuu3x5AvFmFJ0dGHRhpNRzsriaYV_uFo3dLA>
 <xmx:su-aXHnS_Emvpuz52zfmZobjar6kTCP2aPZ4rQ1NrzDmpLMgtQlxJg>
 <xmx:su-aXPIkdOS_9xsxUa0wQqzbL9yxeuesIQdmsllLbs7JMkfT0tXvxw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2275E100E5;
 Tue, 26 Mar 2019 23:36:16 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Fix booting large kernels with STRICT_KERNEL_RWX
Date: Wed, 27 Mar 2019 14:35:54 +1100
Message-Id: <20190327033554.4926-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.21.0
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
Cc: Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With STRICT_KERNEL_RWX enabled anything marked __init is placed at a 16M
boundary.  This is necessary so that it can be repurposed later with
different permissions.  However, in kernels with text larger than 16M,
this pushes early_setup past 32M, incapable of being reached by the
branch instruction.

Fix this by setting the CTR and branching there instead.

Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/head_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3fad8d499767..c2b53febadd9 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -968,7 +968,9 @@ start_here_multiplatform:
 
 	/* Restore parameters passed from prom_init/kexec */
 	mr	r3,r31
-	bl	early_setup		/* also sets r13 and SPRG_PACA */
+	LOAD_REG_ADDR(r12, early_setup)
+	mtctr	r12
+	bctrl		/* also sets r13 and SPRG_PACA */
 
 	LOAD_REG_ADDR(r3, start_here_common)
 	ld	r4,PACAKMSR(r13)
-- 
2.21.0

