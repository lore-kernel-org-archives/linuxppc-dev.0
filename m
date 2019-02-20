Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37168C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 05:02:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D7020C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 05:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="xJkzQlH7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tsJzWWFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D7020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444579170TzDq9V
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:01:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="xJkzQlH7"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="tsJzWWFT"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44455B52QyzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 16:00:14 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4D9E7233C4;
 Wed, 20 Feb 2019 00:00:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 00:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=gXgDkeEPFTzcMfvLfLYt94lqv/
 ebH4YktjB+j4Q04Ko=; b=xJkzQlH7nvzSCSeet0ixwbSKF3bLH4+pvWeKA7wz1Z
 Z0U2OaLLllif1s/HDFo5sMC5NbxNCx+bLipO1EcYWJXeVvhnxz85U+QpKdeLtwYO
 0eepetBR3GlD5iS0QWG5kFXWnP8t5+S+3zPmKVho0oxfpi1qRUIXzbgxljFRql9S
 UGPaeU8vieQoUpOovTYNOFq3k27c0q70ebNdJSaYSKmOhKPKetRbAaKXcdP2HiBT
 iM6SCsOryf/nqsQbkMTRUH+jwHvKj0jgu3vJvDSWr1mftZAYfX0Z6th/6P3nFXUx
 u2lUYuX4s6aNrJ82aizkmFpCX3Xnsm4oV/wUGpNpH/8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gXgDkeEPFTzcMfvLf
 LYt94lqv/ebH4YktjB+j4Q04Ko=; b=tsJzWWFTgG4CXrHfgU/ZjKvN3JJ6dJe3P
 Z+2LI1qRznkbsIgI+AlAQUWCOhWNAMb1FvVkEg/FvkbYKfcNG95JlSY6jrwQtHG+
 TxMfaxWK19gCi/rGb7vV4oLxQjroXCjRcyDf6z3f98pnAnkRcDOSjk1v1yVpnzvG
 ANUlUvJ3ITSfZ603Fj9Jo5+y8rBDOVA5JsfMD/pU4qrjLWxDfdR/AuJzb93mpgJY
 HfHeeP4tCnZDZScJzqkXsoFAX0pxrpJXmzoUJQnZ8E0ln6hdOCZerlBgcIA2ajS0
 CdEaBkQReKYL4rkJhOgG61seMGzP4YQgiDgVfgqhLVPXxch1STLpg==
X-ME-Sender: <xms:295sXDhpIZANJDzMRSoocwHTyVVWF0WkMyrdJA6hWv7-WZbtINeiMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdehgdektdculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgih
 uceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuffhomhgrihhnpehrmhhhrghnug
 hlvghrshdrshgsnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghi
 lhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiii
 gvpedt
X-ME-Proxy: <xmx:295sXEq-kGcEV6YXFBGr7UHFAZVU1NUe8AI0Wo6hD0GeZJnxmRxVpQ>
 <xmx:295sXLMYYHdLwPLEEhlsEyQtJx1aUfxaBde_wNW71AJ7yZx40mGung>
 <xmx:295sXKZk_HwXpBTpsfd5UdbiTtovKEazbt9hxkGAYOp1vyn8tmB20A>
 <xmx:3N5sXMLlobptOOSRVLHrfVYuz8RGShlVlJGwnlUw606rnvtfvihlgg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 70366E45E2;
 Wed, 20 Feb 2019 00:00:07 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] powerpc/kvm: Save and restore AMR instead of zeroing
Date: Wed, 20 Feb 2019 15:59:58 +1100
Message-Id: <20190220045958.14966-1-ruscur@russell.cc>
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using the hash MMU on P7+, the AMR is used for pkeys.  It's important
that the host and guest never end up with each other's AMR value, since
this could disrupt operations and break things.

The AMR gets correctly restored on context switch, however before this
happens (i.e. in a program like qemu) having the host value of the AMR
be zero would interfere with that program using pkeys.

In addition, the AMR on Radix can control kernel access to userspace
data, which you wouldn't want to be zeroed.

So, just save and restore it like the other registers that get saved and
restored.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I'm not entirely sure the stack frame numbers are correct, I've tested it
and it works but it'd be good if someone could double check this.

 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9b8d50a7cbaf..6291751c4ad9 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -47,7 +47,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define NAPPING_NOVCPU	2
 
 /* Stack frame offsets for kvmppc_hv_entry */
-#define SFS			208
+#define SFS			224		/* must be divisible by 16 */
 #define STACK_SLOT_TRAP		(SFS-4)
 #define STACK_SLOT_SHORT_PATH	(SFS-8)
 #define STACK_SLOT_TID		(SFS-16)
@@ -58,8 +58,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define STACK_SLOT_DAWR		(SFS-56)
 #define STACK_SLOT_DAWRX	(SFS-64)
 #define STACK_SLOT_HFSCR	(SFS-72)
+#define STACK_SLOT_AMR		(SFS-80)
 /* the following is used by the P9 short path */
-#define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
+#define STACK_SLOT_NVGPRS	(SFS-160)	/* 18 gprs */
 
 /*
  * Call kvmppc_hv_entry in real mode.
@@ -743,6 +744,9 @@ BEGIN_FTR_SECTION
 	std	r7, STACK_SLOT_DAWRX(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
+	mfspr	r5, SPRN_AMR
+	std	r5, STACK_SLOT_AMR(r1)
+
 BEGIN_FTR_SECTION
 	/* Set partition DABR */
 	/* Do this before re-enabling PMU to avoid P7 DABR corruption bug */
@@ -1640,13 +1644,14 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 8:
 
-	/* Save and reset AMR and UAMOR before turning on the MMU */
+	/* Save and restore/reset AMR and UAMOR before turning on the MMU */
 	mfspr	r5,SPRN_AMR
 	mfspr	r6,SPRN_UAMOR
 	std	r5,VCPU_AMR(r9)
 	std	r6,VCPU_UAMOR(r9)
+	ld	r5,STACK_SLOT_AMR(r1)
 	li	r6,0
-	mtspr	SPRN_AMR,r6
+	mtspr	SPRN_AMR, r5
 	mtspr	SPRN_UAMOR, r6
 
 	/* Switch DSCR back to host value */
-- 
2.20.1

