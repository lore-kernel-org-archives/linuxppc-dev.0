Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E68C433FF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A9A20578
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF3s8ISh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A9A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45y2Ph3Q20zDqFF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 00:39:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EF3s8ISh"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45y1rN3nQVzDq96
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 00:13:39 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id 4so20580981pld.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AZTrJ75fwiSKeqtskzr4XIpVQCwpd4JHPmIVa+6R3Ls=;
 b=EF3s8IShvEp0jpuIEnSCFD/PBnkFkVka6xmsO/YBfoniarOUoHKPoM6gVKjJ05McvQ
 N28A1uIRzQnRPHRR0WqDSLgn2V9H2nrxnbWJlhuFCpf/3/LbsZXAxafQm4awVZxy+fad
 +1+vsHMRe67nvVuK9wynvrBMfG1BkmvPCoA41LRo6KmOOsEANy7dEnfkjj7q2devjibq
 nNwWEgMIjlVwf9365N5Et13gczBMgMQ6r6frGxPdYpcjnx3uPbfzYErsrw9mv4/hrLX6
 zm+CEN01/ajSYz7bpY4i2n5w6S0pEGk/0ZO2wFvcbGZ9FK9UCw23/Kp3RZFIENOn58AF
 v1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AZTrJ75fwiSKeqtskzr4XIpVQCwpd4JHPmIVa+6R3Ls=;
 b=KidCEiVNzx8+DouMs0H9Mw1PdhHlHZJFtl20JoB01FjQfNaBsgHAsEUOf3fuf2uJhZ
 5LZLollYyv6L8E6CxYZfyh7rRsPf/8SHCwqtDQhyLJUUTg9jmzIwujwFR4JadOP9pAr/
 Qq0m+yDPHQHe9A1PG/mcQd7qGnKUNAnKiGRqvG4G5EgtLnqdQynbHU6zqWEBJNSp5egc
 PbXKgKTgjfSVFUrZnMkpWkvbnbsIcPXfi8On962ZdiVn67H/moPl2PjBn/z2Wa4cRFP7
 WsP2Ch5DsHe8r9G4zFTwaiT6hRQ1FbMf0GH0jsVotnDf8MxcU/nSfa0ONZyM2trhaoVF
 HGFQ==
X-Gm-Message-State: APjAAAXdPFk6lGD+GQ2azJjbJKYL4NKdpoGQBLS9pry8r8c/e4T73oWr
 IFlX3NhRWQuLI0VGVdv7o0SfxPhjp+s=
X-Google-Smtp-Source: APXvYqzn1mExoKIf2CUjg3Gke91Ma9FvDpH88VEMLNVe471ukEDkaBbmQhmBaTPDGxfIcvRZX/FNDw==
X-Received: by 2002:a17:902:76c6:: with SMTP id
 j6mr110086938plt.102.1564409617004; 
 Mon, 29 Jul 2019 07:13:37 -0700 (PDT)
Received: from bobo.local0.net (61-68-184-39.tpgi.com.au. [61.68.184.39])
 by smtp.gmail.com with ESMTPSA id u7sm53960083pfm.96.2019.07.29.07.13.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 07:13:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/18] powerpc/64s/exception: Fix performance monitor virt
 handler
Date: Tue, 30 Jul 2019 00:12:33 +1000
Message-Id: <20190729141247.26762-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729141247.26762-1-npiggin@gmail.com>
References: <20190729141247.26762-1-npiggin@gmail.com>
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

The perf virt handler uses EXCEPTION_PROLOG_2_REAL rather than _VIRT.
In practice this is okay because the _REAL variant is usable by virt
mode interrupts, but should be fixed (and is a performance win).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 60969992e9e0..723c37f3da17 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -750,7 +750,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, realvec, 0, 0, bitmask ; \
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD
 
 #define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
-- 
2.22.0

