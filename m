Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C78C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:35:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D759206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="XojPTsPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D759206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PcXb0xkzzF36T
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:35:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="XojPTsPP";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSB2QQFzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="XojPTsPP"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSB0ltzz9sj0; Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcS9481jz9srY;
 Tue,  2 Oct 2018 21:31:53 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479913; bh=8V2j3xr2NE1HoPovoklhtLDx3tkVyeAgWcOstUXWzys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XojPTsPP+qz5/tYkGAVhFwJablUcadhinK3y5N9ObYQv1QXQTYj8a9TbEt8GdEL9j
 WXnV1d8sMVhIpIkRHHIi8BsaI5JeUEM9VBzxcc68+aIxLbehLJbf6Bgn/0BIXDB+Qk
 JTVR8zcpoaUuhO6wRwy3YLW9ut8PlC17tOKVhAGm9jPZf33L01tJVleq1ZYXduUJwq
 6Hasbh1tL4AdYI1/Q/e3894/mv4t6wUzyI43YDMHjBjo/gOYz2ydz2+oaxns26thCb
 Ad/stkDEcv+dkLxms0xuuhcuvat4qW/7HUfg6xSVTbl57Ftm3G6cLcw4h9biOt6tnb
 Y6jTSp7Ij35TA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 01/33] powerpc: Turn off CPU_FTR_P9_TM_HV_ASSIST in
 non-hypervisor mode
Date: Tue,  2 Oct 2018 21:31:00 +1000
Message-Id: <1538479892-14835-2-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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

