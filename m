Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B904C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:07:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12F820684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZATTgMps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12F820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qs8W70T1zF3KW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 22:07:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZATTgMps";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QrvS51NTzF3Jm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZATTgMps"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QrvS46CQz9sBj; Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42QrvS2XL4z9sB5;
 Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654180; bh=8V2j3xr2NE1HoPovoklhtLDx3tkVyeAgWcOstUXWzys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZATTgMpsfCC5WZ4rbcsVgJu/FMycPCVLzwIlbBXwxxDORyBFELC4AqLOSjMAj04YF
 QaZeFKkT1tb7LCgB5uc/46ryNc/tadKJflEChOaJ1Yn8v1cKFmBA7Lqo4J6yJs5ls+
 Y+9fNsD4O6dkmC4at1WI+l8xdLpsV9j3lLp20VBHHnGd3v4JeIJlwDWwmee01lb63D
 G2huIn097ueqqonQPGdDueUW/IKmGl6gDlbJp92LI4QREOP9EFnWPGoL2E8ZniAyH2
 k23Vq4UGXTg/wRNygd6Pw8SrTLW6AFJs8PKBi7hV4jLsElY8ng6U7ImxwbRrZNnPaO
 7KeIts641Z/ww==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 01/32] powerpc: Turn off CPU_FTR_P9_TM_HV_ASSIST in
 non-hypervisor mode
Date: Thu,  4 Oct 2018 21:55:38 +1000
Message-Id: <1538654169-15602-2-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When doing nested virtualization, it is only necessary to do the
transactional memory hypervisor assist at level 0, that is, when
we are in hypervisor mode.  Nested hypervisors can just use the TM
facilities as architected.  Therefore we should clear the
CPU_FTR_P9_TM_HV_ASSIST bit when we are not in hypervisor mode,
along with the CPU_FTR_HVMODE bit.

Doing this will not change anything at this stage because the only
code that tests CPU_FTR_P9_TM_HV_ASSIST is in HV KVM, which currently
can only be used when when CPU_FTR_HVMODE is set.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/cpu_setup_power.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 458b928..c317080 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -147,8 +147,8 @@ __init_hvmode_206:
 	rldicl.	r0,r3,4,63
 	bnelr
 	ld	r5,CPU_SPEC_FEATURES(r4)
-	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE)
-	xor	r5,r5,r6
+	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE | CPU_FTR_P9_TM_HV_ASSIST)
+	andc	r5,r5,r6
 	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
 
-- 
2.7.4

