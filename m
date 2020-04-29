Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1436C83004
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 07:03:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831892073E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 07:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxve3lif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831892073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BqGk3ClqzDr08
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 17:03:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cxve3lif; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Bq7t5CGfzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 16:57:14 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 145so633540pfw.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=douANWoQAY+53LUd2V4eLmMeLibzct7GCFfJaY1Bwtw=;
 b=cxve3lifFyH5eYEa0a4/SLfAa0uwzKMJ4m1NcDm+Mjzb84bGw3omUZQ/8BzpLsPLLq
 JPXjUIXM9l3W0d7mz69L7K6rVdu8jD3GP6lClC1Ddund/loukHu7fdTYqgnhk5NnruFn
 Qu/7Klhgw5ly3XxaugTUScYK+H9FnPb9N6jI7eYeSg/GTXFn8/psN7GV9E/zy56/UM+j
 yJ0K9SkWuHV/bdaBHLquxjnHxi4xHyWXCCHc223Pq/ttEJZu/6eeAlj/Fc4m7Nf3th4U
 igRkVQOVcgY3+Mk+rPSb85tgVcz04FqRTJV7FkvDLcY8DPNgzboDJDXJEirzraKQMC8v
 IzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=douANWoQAY+53LUd2V4eLmMeLibzct7GCFfJaY1Bwtw=;
 b=lIyXST3bu1NdrB7eEqRoxinYnyQoYA+Psb6CVprwpBW7uTfw2ofR/xY/EQKH5mZmba
 U3zxyiLW1nnEZlc/IJfVJSkSrWwtZ66FlLZdTfg9p+36kKvXiFedw4IHgKSGhWHeL8a9
 rfLxM9ROQGeYOvbOLi03sfpY52S44vcJy7yz2ECyeJXxHjcBKAG3dj5JblRnVBd7cLun
 y3kb7AwE8wO9GXyVKASZrOvE8+oSIDvu0PSgCZvfY7bwbJNLqGnqwKUtyJ9lWVIPSq31
 PMN2TIDJi8VPidJFAhu7DuK/qzQTfM11tctu/Kua6lwI9PtFmMSA+s9P+A5fqMQE9+fI
 GtPQ==
X-Gm-Message-State: AGi0PuZh88Kr27J0TZv3Ff/p7SUNiceNZPPWDbjrgErxIs1QEurCdCLV
 L0wydJkYXj63wZjO1/lRZ07Fd34J
X-Google-Smtp-Source: APiQypJH3+XRFNlTzoqS9bb6IJqYbupqWcJhLQq+D+SldMNfgcEVfR1kVRV7+DZBirrItqFdoxNrRA==
X-Received: by 2002:a62:2544:: with SMTP id l65mr15926537pfl.288.1588143432096; 
 Tue, 28 Apr 2020 23:57:12 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.220.177.17])
 by smtp.gmail.com with ESMTPSA id a26sm254660pgd.68.2020.04.28.23.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 23:57:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc/64s/kuap: kuap_restore missing isync
Date: Wed, 29 Apr 2020 16:56:50 +1000
Message-Id: <20200429065654.1677541-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200429065654.1677541-1-npiggin@gmail.com>
References: <20200429065654.1677541-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Writing the AMR register is documented to require context synchronizing
operations before and after, for it to take effect as expected. The kuap
restore at interrupt exit time deliberately avoids the isync after the
AMR update because it only needs to take effect after the context
synchronizing rfid that soon follows. Add a comment for this.

The missing isync before the update doesn't have an obvious
justification, and seems it could theorietically allow a rogue user
access to leak past the AMR update. Add isyncs for these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index 3bcef989a35d..8dc5f292b806 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -16,7 +16,9 @@
 #ifdef CONFIG_PPC_KUAP
 	BEGIN_MMU_FTR_SECTION_NESTED(67)
 	ld	\gpr, STACK_REGS_KUAP(r1)
+	isync
 	mtspr	SPRN_AMR, \gpr
+	/* No isync required, see kuap_restore_amr() */
 	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
 #endif
 .endm
@@ -62,8 +64,15 @@
 
 static inline void kuap_restore_amr(struct pt_regs *regs)
 {
-	if (mmu_has_feature(MMU_FTR_RADIX_KUAP))
+	if (mmu_has_feature(MMU_FTR_RADIX_KUAP)) {
+		isync();
 		mtspr(SPRN_AMR, regs->kuap);
+		/*
+		 * No isync required here because we are about to rfi
+		 * back to previous context before any user accesses
+		 * would be made, which is a CSI.
+		 */
+	}
 }
 
 static inline void kuap_check_amr(void)
-- 
2.23.0

