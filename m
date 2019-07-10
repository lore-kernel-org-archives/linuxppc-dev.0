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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE0C74A21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:47:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3D52086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIsC27Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3D52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kNq71nx8zDqng
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 01:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIsC27Rs"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kNHB07y5zDqMT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 01:23:02 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id t16so1252053pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQeLG+f8ET5u/YrOrVFZ7LJHLtCq+lw80ktcqY0BsDk=;
 b=aIsC27RsAdCel2lIFbhw1HL/Fr9pjUDnOjrDJjLTsSWJTuDBUqe6XbLj32TaKa9H2S
 VwFCDgmDyogFIF6eScqwGGCz9eDLT/kwt90GxyonAJTyekJL5Xzx0YFIsblfS2lVRM4k
 zM4Y+1nrDfjpIDtbWsJIDw6971Wmy2kDBUYRVkwcfWBnnX4DjRGpiVIqs2+2j+r5uF2F
 ItcDv2hrsctjHjArLUD8KAosA2Ig5LoWX4iVKIQMooV6f3BaEKekAp6TNPSsJbQxlR5/
 nrBiH9AfeyGWJiLguRASkS4TZeYzmn6uWErfOh/YsOEUwDPDy2PUyLykxw0HvJqMotxX
 RaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQeLG+f8ET5u/YrOrVFZ7LJHLtCq+lw80ktcqY0BsDk=;
 b=YbeAwNGJCPcE0boyg5y6IKWZoUWaa8JSc996IF9FZMSQpSWpT6+0cv5ygusxTfQaPW
 ohW3/99dydUjcCox919DPPyEMP/Kz5WdVpJq2jdE1T73rHhZSctxxl+KHr6dNl3F8zm1
 cGrCiuz2yMtg3dO7pBkQnAiB0H2IblKMoYPVuQAvEwh2AFbYMeCXd1BlYGUGPjXENlwZ
 83KbCFQb/OBg3lxAqWv6pO6+wj3q7d3Hja6G1qtmbYRomgHP28eca39H3zZYxvLk6XFA
 Uw0Nr1RlvLi0lFapcdZeERUVrOFJS+6oHdOMZna0CybezJj9BRc9cmqI71rSCP1r0H9X
 bu7w==
X-Gm-Message-State: APjAAAUmGrQRWL9zWIBEmxaaeLvHRwgVcUBFDYsmfHKjZ6sqRPl0mHGJ
 4tddwatXrPJbJXm8EBVh9TNMnhjxNwk=
X-Google-Smtp-Source: APXvYqwhhwyKTp28ERVCzhyQI3QB6NyF48PT3Sp1dFP4MNd+uIlqB8AYdbT5D8bGUfEf5kq56I6OJA==
X-Received: by 2002:a63:c5:: with SMTP id 188mr38134791pga.108.1562772180226; 
 Wed, 10 Jul 2019 08:23:00 -0700 (PDT)
Received: from bobo.local0.net (14-203-207-157.tpgi.com.au. [14.203.207.157])
 by smtp.gmail.com with ESMTPSA id
 s22sm2699212pfh.107.2019.07.10.08.22.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:22:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/16] powerpc/64s/exception: machine check use correct
 cfar for late handler
Date: Thu, 11 Jul 2019 01:19:41 +1000
Message-Id: <20190710151950.31906-8-npiggin@gmail.com>
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

Bare metal machine checks run an "early" handler in real mode before
running the main handler which reports the event.

The main handler runs exactly as a normal interrupt handler, after the
"windup" which sets registers back as they were at interrupt entry.
CFAR does not get restored by the windup code, so that will be wrong
when the handler is run.

Restore the CFAR to the saved value before running the late handler.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 54ca2b189d43..f2c24a4ae723 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1186,6 +1186,10 @@ FTR_SECTION_ELSE
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 9:
 	/* Deliver the machine check to host kernel in V mode. */
+BEGIN_FTR_SECTION
+	ld	r10,ORIG_GPR3(r1)
+	mtspr	SPRN_CFAR,r10
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	MACHINE_CHECK_HANDLER_WINDUP
 	EXCEPTION_PROLOG_0 PACA_EXMC
 	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXMC, 1, 0x200, 1, 1, 0
-- 
2.20.1

