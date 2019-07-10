Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E5C74A21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:33:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A2A20844
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvPiNB6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A2A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kNWS2FB9zDqWH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 01:33:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvPiNB6r"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kNGt3CYCzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 01:22:46 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id z75so1424935pgz.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gJqecc7z/Wt3DHiADBssOtE0uLDjQM8bKcxpApRr0MA=;
 b=PvPiNB6rjy3aZD8s7Sb0ZMZ30jvW8oeBmdItAGSUJtwavhzBpkquU4g1VS5SM6QBN8
 okh2/AQNlQhOiEGncwFUcWfbpGOnipBMNwX9Oe1QrlF4o9cKVZcfAYfgbxpcJX3SlyOp
 GM8NMch77Jzn8cIfUKvgXuEahpbTWUK7vtVExthL/wiRSnQJVNnzNBtPRq/QApyOJEGa
 j3cP4Z03wkZJMOniBKLYAkWrl9dkBuKzHSQinCDVoXqL+ntnRTygy5TyVl8WbtYX78xE
 /mGhUXjFCKYh/VfMgJw9kqN41NDhl2+LSmDFuNuTKJ8z3Jb0iJ1UP1I9tKs0fTvM1EeO
 uswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gJqecc7z/Wt3DHiADBssOtE0uLDjQM8bKcxpApRr0MA=;
 b=XOcNKPSUB8UC9HelbGCXw9J1j5xNl9h43afKBeg3fbIgP8EVyKh59gCQALyLuMO08p
 X+sT+75Wbl84rNUiN5lhCPVCvzApQd101ICYJjQkaINhDwXP/HR2cY3QhLclX+7gibss
 NlynmZ/sNWtdRUMACnbx8aYD7C/ndmxN/yZLGKsf+aOGlQfkcRrH1FSP+t+lE4vOR67R
 M6mE7fF6OPr2tvj/vgVuhOtjVxLc6Kaj1m2SzoI7/wJJZ3tggMSkZzbmN0LtT/5lfZrc
 DGkO4r16GWNFHVW+10XV9QTaIAe0Xunk0AsZIT+F2t/yrg3aj21LHo16CSgS1kovgoeO
 duAA==
X-Gm-Message-State: APjAAAX7UPFQPOE/6ZIvXZ0ZHb2CsFFLEA4guz2QIP57To0Z8JfCMeRP
 tjLwE646Gcm5dWNlFfdLoPzd7tP6atE=
X-Google-Smtp-Source: APXvYqy0/0kX4gBIYsU/Z8E4kI3BNj857OKv6jLStnU6p1x++HyW8IKNFHs9khxLPBSQlx1J1Lp/Tg==
X-Received: by 2002:a63:7114:: with SMTP id m20mr2251920pgc.439.1562772163429; 
 Wed, 10 Jul 2019 08:22:43 -0700 (PDT)
Received: from bobo.local0.net (14-203-207-157.tpgi.com.au. [14.203.207.157])
 by smtp.gmail.com with ESMTPSA id
 s22sm2699212pfh.107.2019.07.10.08.22.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:22:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/16] powerpc/64s/exception: machine check fwnmi remove HV
 case
Date: Thu, 11 Jul 2019 01:19:35 +1000
Message-Id: <20190710151950.31906-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710151950.31906-1-npiggin@gmail.com>
References: <20190710151950.31906-1-npiggin@gmail.com>
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

fwnmi does not trigger in HV mode, so remove always-true feature test.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 53c1b0a2ebce..db7ef8c8566f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1026,9 +1026,8 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
 	EXCEPTION_PROLOG_0 PACA_EXMC
-BEGIN_FTR_SECTION
 	b	machine_check_common_early
-END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
+
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 1, 1, 0
 	/*
-- 
2.20.1

