Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB184C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 07:44:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1502173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 07:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+tln/dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1502173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vtzp6L6TzDqTs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 18:44:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="q+tln/dz"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vty82VwJzDq83
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 18:43:11 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id g37so631804plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9B6C4Fr3f7ZIhra2/vMOkAqKYKeA5EviZAXmdxyQmg4=;
 b=q+tln/dzdIVQ+BBw7cp3eZHuEIC6NiZ1RZK6xu1FFF3HMWBjcmPrpRonIIOFgiZJQJ
 bBOp9k+txH4G7ulds5cihN8FquNS2BBUtIraGGoVMExcP80YDfUiB8IS/0hmGtRNnUv7
 8qGQQilV9Y+aBgGkLoK+CH2PWt2Mhn0heC7HgRyJfT0pB/Yu7Z4JGKdsINXY8no/TidH
 2ioPsCP0CZ8z1OH1FblgiTKEE/KCd1uqTCBb6cZqVs6x76M4nUfTu1+9L6O5qThRI+9x
 ku2Rjbvrj0rmwqOcaVzCLI5smHwcJzcbaqclj72s7Yxh9TKKX5Ehgh8nlXAbcHc6aFo1
 GpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9B6C4Fr3f7ZIhra2/vMOkAqKYKeA5EviZAXmdxyQmg4=;
 b=GBRGv/EKh42o4psjPpiR2rGMgcmlZneJb6tWzZQy3exVAhog/guYekb/juRuZLaNvF
 sEU1/IaYxbF2afrnAn2ARWPeJ6JI5sHjnZfuRjkgeNhUZftXyXvChrzVmvmKyqDifByc
 DvR86tIySlbSlnH/9qSTeR2UvGsflGJz6EDQ4mW5r+hdESUkj0o5FMmn1oRIprCgVj/N
 tnAPZKY+yFaYjUPYqoi4cWEcU6Dq3v7EA+Frg3y2j+qUHDzu82E9iikmwok/A18omWhW
 1qFcfHHQSH6DCPUQUSLkxQ6HSNjyllsQkEd47EhtIFWGil0wf24l1/24r4JXHfdnI8nA
 B7Hg==
X-Gm-Message-State: APjAAAVgdoNTXL6LVOvNa146bEhA4oIrjHCncRajYKHp/D+LSlcelYwn
 RL8MIGYn2sOCZ7S/RdG/jSDOQVVe
X-Google-Smtp-Source: APXvYqxNHDcbbtCJc0ZOgLu0xVK3L5uJfObE9wxXoadhMm1AVJKWHznz0HoXNTJefNkMuVMSGGuXkw==
X-Received: by 2002:a17:902:2963:: with SMTP id
 g90mr47808054plb.182.1553845388633; 
 Fri, 29 Mar 2019 00:43:08 -0700 (PDT)
Received: from bobo.local0.net ([58.84.105.43])
 by smtp.gmail.com with ESMTPSA id z6sm2212138pfz.65.2019.03.29.00.43.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Mar 2019 00:43:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/radix: Fix radix segment exception handling
Date: Fri, 29 Mar 2019 17:42:57 +1000
Message-Id: <20190329074257.14428-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
broke the radix-mode segment exception handler. In radix mode, this is
exception is not an SLB miss, rather it signals that the EA is outside
the range translated by any page table.

The commit lost the radix feature alternate code patch, which can
cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!

The original radix code would send faults to slb_miss_large_addr,
which would end up faulting due to slb_addr_limit being 0. This patch
sends radix directly to do_bad_slb_fault, which is a bit clearer.

Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a5b8fbae56a0..9481a117e242 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -656,11 +656,17 @@ EXC_COMMON_BEGIN(data_access_slb_common)
 	ld	r4,PACA_EXSLB+EX_DAR(r13)
 	std	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -705,11 +711,17 @@ EXC_COMMON_BEGIN(instruction_access_slb_common)
 	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
 	ld	r4,_NIP(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
-- 
2.20.1

