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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39629C74A2B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:36:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DC4208C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef28I4m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DC4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kNZP4yKyzDqWN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 01:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ef28I4m+"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kNGx2Bn6zDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 01:22:49 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id q4so1418173pgj.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ee9qLF/RJ+7mXd4GiTRK8Dspx6rtpH65SXbucIncObU=;
 b=ef28I4m++tWh/u+9/jmNG0rcwIUMycIp8OnNLgDbh8qLVEeDzAM55/yN4pkHur3kwh
 mLZgY+kWBoSfZcw2acZKKPDDMx7YyDgMTPEs0+nhOGlAC5nlBRcCB1S0SgfHoc6xyPQo
 NGy9tJ4Kuw2+zNSnhI5yy2RMTpfOZ402EeV9f1dlxdOXwekVrBoJbM080aZivwujAHha
 IJX4Uh/lOyy/qzK1f3ljvOpFLsD1mVwm9sJJN1bPqeTtZSsI911PZpuvF2YIupCM/sdS
 xfbO3yK69qXHL/sgWhTBUPflbtcqOniFHnmdJ0fu8Z1SKi0My8T+CnMuFueBtYiW6gbf
 6XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ee9qLF/RJ+7mXd4GiTRK8Dspx6rtpH65SXbucIncObU=;
 b=P46R3Q0K0N+9jrFrzxRIkzK7VrtMbIam7K1U6km/FJxmEAStjNWffpyATIGe6GVhTr
 3sFx/vWVMGrtOg9aO3NtgiTOvKqWms4YrHIbuB9CwZyOPmvMzgGzWY3rXWBIVxUM6QxA
 a5eYeW8PZfPU4NGMy8xljHsoz/0xXqdSLRn8czxnBdo86l6yG184OCyjPmJr9AtDBYqk
 MCdLNy6z2F1Tx2OmeZtt1uQNcPOWFJtvVqSSX9/z0bqpMM3LFgDZZhz6jt38g0DCdGpB
 nTZJTNkC4UZzFTziwoywlcbyIyEprjScmEAWyxe0Ty2ktZX4uhjRj4Ris8jBNqZYgy8/
 VY7w==
X-Gm-Message-State: APjAAAU2EuRRvOkXbO1GlCXeooTcQn1n6cjamep6MXZeV+ubidheLXKD
 Bfkh8vVLuHKdYSPg4gSPF0XMQ2G1exI=
X-Google-Smtp-Source: APXvYqzDZ5sBuxWekyJ+dj2iShMykAd2Fzua5kH/jnYpa0AMOiadI/noAn+D4ZzD0ARIrzcEURrvWA==
X-Received: by 2002:a17:90a:8c92:: with SMTP id
 b18mr7433696pjo.97.1562772166431; 
 Wed, 10 Jul 2019 08:22:46 -0700 (PDT)
Received: from bobo.local0.net (14-203-207-157.tpgi.com.au. [14.203.207.157])
 by smtp.gmail.com with ESMTPSA id
 s22sm2699212pfh.107.2019.07.10.08.22.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:22:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/16] powerpc/64s/exception: machine check remove
 bitrotted comment
Date: Thu, 11 Jul 2019 01:19:36 +1000
Message-Id: <20190710151950.31906-3-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index db7ef8c8566f..e8734a1dfdb9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -933,10 +933,6 @@ EXC_COMMON_BEGIN(system_reset_common)
 
 
 EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
-	/* This is moved out of line as it can be patched by FW, but
-	 * some code path might still want to branch into the original
-	 * vector
-	 */
 	EXCEPTION_PROLOG_0 PACA_EXMC
 BEGIN_FTR_SECTION
 	b	machine_check_common_early
-- 
2.20.1

