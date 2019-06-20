Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7719C43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:44:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB28208CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 05:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrZ9ZMTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB28208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TrP625HwzDqB3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 15:44:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HrZ9ZMTj"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TqlQ3kTZzDqvD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 15:15:30 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id i2so894862plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 22:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QZtiq0xzSO/nneKBRAdea4fFenHZ7fAXwIvhc3wDuhc=;
 b=HrZ9ZMTjIfNjeBGqflRtUMwG7onxLCcZvIeKPQTnlsB0Nzk1NpBGsgDa7Pt2v7aakM
 l5iDFiNuUQQ8kJzHWx51s+B1ZZB+EYei4Ts3OTWgF6EDRyZWjw7mYzXHCjOxCzfff896
 vw3DwE2L+uqRJuPiZ4deJUjCRx8Yta3bZhIWunXtUhXmzjhq6hoXOBbH6PXxMOkvSJsw
 YBpXXonkNGNYb72ZxzkmpzeULjCdkZd79/CZNfBt0emsufif5MnkcwsC0mfsLc65bfZX
 o+IxGBOGe/X29JkXymkFKcaZZB5C0n/+YxQOdzF77JvOfSWvA9BSnRUfhKON8CS671mf
 VgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QZtiq0xzSO/nneKBRAdea4fFenHZ7fAXwIvhc3wDuhc=;
 b=cGfq+RwuT/SHiaD44aC/Na2bxxvdey6ZZ5/mIaf2qXggaDe2hhMf2p+HcI60DPEZoA
 eMtY2A/NPPFTMTD4LfwGo2CGCIF+eei0losMCbg0KbRhrUBu9JMOhMbd/EexmPSf/cBM
 QwnuEHAWIu1iLySB4Eo8YLUFDaiawl0V/GhUxVy1LjlG5iIMU2tuDIIAPSjf3UhBWHXr
 ZA06ul6wIDuXHBdLOl7jwPRtZPU6aTDHxfRN+PcGCF+CIshqzWo2yE0RkYPeZNW7/HzY
 cpWQBlbtOChWnoZez4IPHCuIH/7vhtEOnEYhHaGKY9FSaWdVyPAGrSBHhXvLt2lUZIJz
 ougg==
X-Gm-Message-State: APjAAAWfXHu2td+MnPKiULGaS9ELsXhMSdpy1adTDZMYKNstAx2H5IRK
 0/Yw2WMiRzWMHBlhkaIkII+roCkx
X-Google-Smtp-Source: APXvYqykAp6PKBkKlZ6m+Nv3C6g0qDiY4mUkd0cwn5XpGGp9yf3GizzqsHhUNvdiwVTvDYMJmBOaJQ==
X-Received: by 2002:a17:902:205:: with SMTP id
 5mr114951449plc.165.1561007728760; 
 Wed, 19 Jun 2019 22:15:28 -0700 (PDT)
Received: from bobo.local0.net (193-116-72-140.tpgi.com.au. [193.116.72.140])
 by smtp.gmail.com with ESMTPSA id
 h12sm8235847pje.12.2019.06.19.22.15.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 22:15:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 14/52] powerpc/64s/exception: improve 0x500 handler code
Date: Thu, 20 Jun 2019 15:14:21 +1000
Message-Id: <20190620051459.29573-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051459.29573-1-npiggin@gmail.com>
References: <20190620051459.29573-1-npiggin@gmail.com>
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

After the previous cleanup, it becomes possible to consolidate some
common code outside the runtime alternate patching. Also remove
unused labels.

This results in some code change, but unchanged runtime instruction
sequence.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5828d440da49..d35a9fa4651e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -746,32 +746,24 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
-	.globl hardware_interrupt_hv
-hardware_interrupt_hv:
+	SET_SCRATCH0(r13)	/* save r13 */
+	EXCEPTION_PROLOG_0 PACA_EXGEN
 	BEGIN_FTR_SECTION
-		SET_SCRATCH0(r13)	/* save r13 */
-		EXCEPTION_PROLOG_0 PACA_EXGEN
 		EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, 0x500, IRQS_DISABLED
 		EXCEPTION_PROLOG_2_REAL hardware_interrupt_common, EXC_HV, 1
 	FTR_SECTION_ELSE
-		SET_SCRATCH0(r13)	/* save r13 */
-		EXCEPTION_PROLOG_0 PACA_EXGEN
 		EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, 0x500, IRQS_DISABLED
 		EXCEPTION_PROLOG_2_REAL hardware_interrupt_common, EXC_STD, 1
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
 
 EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
-	.globl hardware_interrupt_relon_hv
-hardware_interrupt_relon_hv:
+	SET_SCRATCH0(r13)	/* save r13 */
+	EXCEPTION_PROLOG_0 PACA_EXGEN
 	BEGIN_FTR_SECTION
-		SET_SCRATCH0(r13)	/* save r13 */
-		EXCEPTION_PROLOG_0 PACA_EXGEN
 		EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, 0x500, IRQS_DISABLED
 		EXCEPTION_PROLOG_2_VIRT hardware_interrupt_common, EXC_HV
 	FTR_SECTION_ELSE
-		SET_SCRATCH0(r13)	/* save r13 */
-		EXCEPTION_PROLOG_0 PACA_EXGEN
 		EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, 0x500, IRQS_DISABLED
 		EXCEPTION_PROLOG_2_VIRT hardware_interrupt_common, EXC_STD
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-- 
2.20.1

