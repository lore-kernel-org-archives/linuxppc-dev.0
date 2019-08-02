Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B7C32750
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 11:04:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3BA206A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 11:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMmxuI0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3BA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460PSj25XWzDqbx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 21:04:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMmxuI0D"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460PLq3bZnzDqxL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 20:59:46 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id p184so35857427pfp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2019 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H4cQa0f/z6XY3LRJbi7qRimBKnzqWlLnHo1qlovLaDU=;
 b=EMmxuI0DnDRS0qcM5j6N+00p9Hpru6TBukivCQZy4sxQkojN5JX2k9s4CL7oL7LFKF
 dRiyCLQK+vvGIccPByKHFKG2ybMmiXCz71tHqtjGUvcMfG6jFILlxiof3aboaIYnTKl/
 p6cp0NFviuMKSJkOrU+zrfvZCaR3ilpHgjPJp8ivimeh+VCFvJ/YrEAeKJBMYF8JZgoq
 mBP7tW/nG4U0OEgyGK+5fZ0X7q/zNQgOymkmZhysBXlL3jxBQvnEl4nTK1INvNrbSNNS
 kUy4GbCFSv+CivNFLd1/v1Gb9ChBhAMCnN9xAYxwCTfnS/vPUcH2FuohlnghjruYFMIg
 llug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H4cQa0f/z6XY3LRJbi7qRimBKnzqWlLnHo1qlovLaDU=;
 b=EwBPYalKofojRt4NZIHGIVB/WZKNKkGhVaIk/v/qg4TwdMwCqrtnFA54OVx9wfq1cK
 wHWElzhhY1ApTnMmJS0YGeHOFCffKvsOtwvbisFlskGfIXS6WSEvvbjdp51fsZYBqRo/
 4dMpvLu2kov2UXqyURovD1Ql+Vp+T5BKZY8Y6JPtojIqsUDtj0IXWuofNSy+OVaXPJ+8
 DPIvz1oon+IJix8n0wOY9Gk91gHRWF4U+BF+tE0GAMoRkzciBKpNuvbglfvrB2IzftFZ
 OddoXMK5Q/PD3fOmCYlRGenF4Cd5LCzNVNi6qbKDtvJ1RR8T30kVzY1yWym2et4HEhbz
 2Czg==
X-Gm-Message-State: APjAAAWAqqxcQpzJ0I0670g6+52ejbkWoVVpall3ZeydK1JHauQxAj9F
 exvBMz8aVV/XoxLVcpQYheUXOIJHiFM=
X-Google-Smtp-Source: APXvYqx9U9e2d5baDLBhQYP/4KzOIkyedzrwLNMHHJ1tZtFqO/thLLeX/4H3RpuGhK1Q8+s6PxTqlQ==
X-Received: by 2002:a17:90a:23a4:: with SMTP id
 g33mr3855723pje.115.1564743583819; 
 Fri, 02 Aug 2019 03:59:43 -0700 (PDT)
Received: from bobo.local0.net (193-116-68-11.tpgi.com.au. [193.116.68.11])
 by smtp.gmail.com with ESMTPSA id t96sm7377118pjb.1.2019.08.02.03.59.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 03:59:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/44] powerpc/64s/exception: machine check fwnmi remove HV
 case
Date: Fri,  2 Aug 2019 20:56:26 +1000
Message-Id: <20190802105709.27696-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802105709.27696-1-npiggin@gmail.com>
References: <20190802105709.27696-1-npiggin@gmail.com>
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

fwnmi does not trigger in HV mode, so remove always-true feature test.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index eee5bef736c8..f30eb1df7443 100644
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
2.22.0

