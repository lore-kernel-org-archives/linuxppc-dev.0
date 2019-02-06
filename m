Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E7C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 06:39:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4F72175B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 06:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="iwgCmD7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkZax93Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4F72175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vWxj0NGHzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 17:39:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="iwgCmD7g"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="HkZax93Z"; dkim-atps=neutral
X-Greylist: delayed 497 seconds by postgrey-1.36 at bilbo;
 Wed, 06 Feb 2019 17:37:34 AEDT
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vWvy1sNGzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 17:37:33 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4E2C821F26;
 Wed,  6 Feb 2019 01:29:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 06 Feb 2019 01:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=DvB4NkafIWFYaaslKMOvtAB0aK
 mWHFxWBaby6aGlaaw=; b=iwgCmD7gyi9O4/QtJj+1UCUBFpgjcWdvif2TnoGwD1
 ZYwpwOTOSEqwuudoymITQU/V6LAEe70N/RYOpgZs+nRxAurgR1w5SU3WClQTGdUC
 vXCQg2sur4jEmW38OpWQa4euyMv/uPKrxp0zB1jDmwaUeG3WHCe/yxbaHBRNq5ad
 ozHQn0OGtHTW6oUK1sPyqq69sNfScxZRVqou1lUTh04WY09o5URZg+TYhEkuHYWH
 e/CUbilbcJkssceZaJxOB6Fqrvexsi5FZ84RVEVCtOILeKXd6QogzfR80OXP9tMk
 h6NJuA1njiiNQMsBMlTZpW8byvEnO8ybylzfDnc2mm7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DvB4NkafIWFYaaslK
 MOvtAB0aKmWHFxWBaby6aGlaaw=; b=HkZax93ZEJOcUxkmUCzl7mZYzmJN0tQ30
 mU+Qc4A4e2IeRYzQOTypkaGQdD9RG/1LwwjGoUr4tfI706q2tSqlDqll+I6geMkR
 yffw01gGcdWNtU5xTBhss0h6E0777+FwXCqDZdCmdQ1pk7JHZefnGlLQKAly+ngT
 Lru6B+Og6cvnbbd5jw60ha4nVmipRC9GYVaiWSFppfB/2aQoRTIH9YGrz86RFAnT
 w7klYAQtvj3J3n/VjyYYJe4hcs9YHj2yoc+MLpQeuRMrSiz0qN0ywz/DQTNX7zS8
 epedU7RmmYUsZiQefe1piuYo8X29OAbvMQBaAtCagLAzLOEvDwnBQ==
X-ME-Sender: <xms:tX5aXGuIgC3ERiWFMGxt0QlJzBpqOw5LJ2OhhEkoptc4tON0LRp0SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeejgdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhs
 shgvlhhlrdgttgeqnecuffhomhgrihhnpegsohhokhefshdrshgsnecukfhppeduvddvrd
 elledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhs
 shgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:tX5aXPJ4X16qHjYoAcOemAYcfd9iZ2MK4PRc2sakzPDmIDnCkk-xxQ>
 <xmx:tX5aXLlFK5lIb7ORs9etx18dRzsPI_FQ7XIyWFnzdXni0BnB1AjMaw>
 <xmx:tX5aXIJVirCtTCCt4GGmsPpyP8LVU1XM8AKnYnGTzBL_PA12kW-zrQ>
 <xmx:tn5aXJwjfE9jsjlIz00valWlAUkDpYnOJeutDMBQfuokxAbHPlYCyA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1D586E4314;
 Wed,  6 Feb 2019 01:29:07 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
Date: Wed,  6 Feb 2019 17:28:37 +1100
Message-Id: <20190206062837.26917-1-ruscur@russell.cc>
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
 arch/powerpc/include/asm/cpuidle.h |  1 +
 arch/powerpc/kernel/asm-offsets.c  |  1 +
 arch/powerpc/kernel/idle_book3s.S  | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 43e5f31fe64d..ad67dbe59498 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -77,6 +77,7 @@ struct stop_sprs {
 	u64 mmcr1;
 	u64 mmcr2;
 	u64 mmcra;
+	u64 iamr;
 };
 
 #define PNV_IDLE_NAME_LEN    16
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..10e0314c2b0d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -774,6 +774,7 @@ int main(void)
 	STOP_SPR(STOP_MMCR1, mmcr1);
 	STOP_SPR(STOP_MMCR2, mmcr2);
 	STOP_SPR(STOP_MMCRA, mmcra);
+	STOP_SPR(STOP_IAMR, iamr);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 7f5ac2e8581b..bb4f552f6c7e 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -200,6 +200,12 @@ pnv_powersave_common:
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
 	SAVE_NVGPRS(r1)
+
+BEGIN_FTR_SECTION
+	mfspr	r5, SPRN_IAMR
+	std	r5, STOP_IAMR(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	mfcr	r5
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
@@ -924,6 +930,13 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
+
+BEGIN_FTR_SECTION
+	ld	r4, STOP_IAMR(r13)
+	mtspr	SPRN_IAMR, r4
+	isync
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	ld	r4,PACAKMSR(r13)
 	ld	r5,_LINK(r1)
 	ld	r6,_CCR(r1)
@@ -946,6 +959,13 @@ pnv_wakeup_noloss:
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
+BEGIN_FTR_SECTION
+	ld	r4, STOP_IAMR(r13)
+	mtspr	SPRN_IAMR, r4
+	isync
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
 	ld	r4,PACAKMSR(r13)
 	ld	r5,_NIP(r1)
 	ld	r6,_CCR(r1)
-- 
2.20.1

