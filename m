Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7854C282CC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4443220863
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="lk9OVUVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4vN246+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4443220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wsxG1XdmzDqX1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 22:13:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="lk9OVUVL"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="e4vN246+"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wsvH09zgzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 22:11:38 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id ED2582206A;
 Fri,  8 Feb 2019 06:11:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 08 Feb 2019 06:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=OKWzDgix67djhgSsc9UWkOAtWH
 iFpLZ1KqFQGyLLmqA=; b=lk9OVUVLRdVSvnspzItR4dC/htBOhicMCEO/u4YqL1
 +Fv7gWn73J9+rp9ONH+Hqd/6bL652vBukt88ve/9nPZfTq061+YGKRLhSUxDsuYl
 82skBJDxc5KyYelRbbDpFUJ3cF//EPIi6yAhnYvB9PkEVX/9960gSr5N2h7FVZ5Q
 D/LwEFCkfvFxD/nMDqiY7K0FfRpw4YihyRXVpsgtdi1I5Eq0O1R2exYxCTfMXofc
 veL1N93pPrQMaaD23ZIkMmGEPtoYMDpS7d/1GBCa7dQqCbZ8xJYeRqCWVZuyDuOt
 p875jrOm07db6mkrW29c0Fzf2uM1fIXcV0wiEbsqHgcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OKWzDgix67djhgSsc
 9UWkOAtWHiFpLZ1KqFQGyLLmqA=; b=e4vN246+kL/Ry7AdhpwERJuE21fSZN0wn
 iq1XaIIkZnYCRfhc0dcdnlw310w9Dvstgw/RPAw+ETBx/GgN+HHIb8MXZ1mAx6Sg
 02H+42aMjXW8xWC8CqIs3JE8Hw6OYsHzrnGSo2DvOsU0Q57sp/OrYJS4xY67nu6N
 PoSR9An8jZ/eBs5ddFjudqY54X0nFDPW4QddmxlhFmEZeYI6eRODShSzRVKm8g4+
 TqDhA9C/1nAe0rL7ho/drdRMfIk3h9JXZQT1jsi8KdQna89MCZC9Tv/Dtb4jaYuB
 bqGAm8L0IVQTV6myUoYZegdF7226LKBMnstM2yudxwLSAuKOLPyCQ==
X-ME-Sender: <xms:5WNdXPb-uQbbb-zB1FMVkmctV2gl4P6Qwytj4v0TObZZRk5PXoZDfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledvgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhs
 shgvlhhlrdgttgeqnecuffhomhgrihhnpegsohhokhefshdrshgsnecukfhppeduvddurd
 eghedrvdduledrfeenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhs
 shgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:5WNdXCqIL_itIuFXELliWhgatJ0SXZHpPib1mTx7RPxE5HBjN2R_BA>
 <xmx:5WNdXM-i9RRRJcoCHN9wpZm7o8tFvYUaUTr0rdlV9NIDHueiHntjwQ>
 <xmx:5WNdXJ9Vr0QrGcc6jds2QOgwfxSG3-sec4MFPHXdzSwRy-DQzGNevA>
 <xmx:5WNdXInFh-jwXxIOC-h-rF80xguoMMpVeQ5mZe_PkTSaChCDnLnc1g>
Received: from crackle.ozlabs.ibm.com.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id C2C47E4046;
 Fri,  8 Feb 2019 06:11:31 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/powernv/idle: Restore IAMR after idle
Date: Fri,  8 Feb 2019 22:11:03 +1100
Message-Id: <20190208111103.4901-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
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

Without restoring the IAMR after idle, execution prevention on POWER9
with Radix MMU is overwritten and the kernel can freely execute userspace without
faulting.

This is necessary when returning from any stop state that modifies user
state, as well as hypervisor state.

To test how this fails without this patch, load the lkdtm driver and
do the following:

   echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT

which won't fault, then boot the kernel with powersave=off, where it
will fault.  Applying this patch will fix this.

Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
space")
Cc: <stable@vger.kernel.org>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
Since v1:
      - no longer use paca to save IAMR, instead use _DAR (thanks mpe)
      - remove isync and pnv_wakeup_noloss section (thanks Nick)

 arch/powerpc/kernel/idle_book3s.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 7f5ac2e8581b..551cc4649021 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -200,6 +200,13 @@ pnv_powersave_common:
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
 	SAVE_NVGPRS(r1)
+
+BEGIN_FTR_SECTION
+	/* _DAR is unused here, so (ab)use it to save the IAMR */
+	mfspr	r5,SPRN_IAMR
+	std	r5,_DAR(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	mfcr	r5
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
@@ -924,6 +931,17 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
+
+BEGIN_FTR_SECTION
+	/* IAMR was saved in regs->dar in pnv_powersave_common */
+	ld	r4,_DAR(r1)
+	mtspr	SPRN_IAMR,r4
+	/*
+	 * We don't need an isync here because the upcoming mtmsrd is
+	 * execution synchronizing.
+	 */
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	ld	r4,PACAKMSR(r13)
 	ld	r5,_LINK(r1)
 	ld	r6,_CCR(r1)
-- 
2.20.1

