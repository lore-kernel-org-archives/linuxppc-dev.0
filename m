Return-Path: <SRS0=ha2k=HV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87859C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 06:36:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ED864EC7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 06:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ED864EC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dhhgc1pYPz3cGL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 17:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=IfVW3ZfB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e;
 helo=mail-pg1-x52e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=IfVW3ZfB; dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dhhfg0Vctz30NT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2021 17:35:54 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id p21so3028306pgl.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2021 22:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PrFlMcs7Ybnsn02EnHS92bPPaWqalxkG7oX5C7Pez8g=;
 b=IfVW3ZfBDzz55MElYRD11Rr20onopgcWUSLxiyFBb+3qfeQiP4cVeU8WTZvUL13TUQ
 YK/K6NwXaegOFe26eMIAobzMcEFYLq6iAh+n/7//xmEXoRhHcqROTNkmjr5xQJavRdog
 BJSFLudpscWm+skO4D/vDbQpRQDbmjN6XygEPZIiSPV0XDOVKt2soTGWLV1JOxn5YhJ4
 5zYJzHdT+24WqFSQa8t/ofgiSXjiMi5TuWzBpkGa6o5XbSw1wWU/o5dB3SA5k3ZJYynQ
 tEqfnSdpj+HsE/uVhxgt9vkWrM2rHanyyqoHxPmdQ+B5ufIIWZmOuyUwUc7T5wuoWitU
 AQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PrFlMcs7Ybnsn02EnHS92bPPaWqalxkG7oX5C7Pez8g=;
 b=JRYklIMpZTUJix+I3FtpJGO4/sU6nc4+B/4kIw5rfhQHKgFdu5SLDjbVYD0SKZXO68
 NpvlwFlngP6AXEZfS5LHkH3XLWgidwujpXf0s3sXRvyCDcXKgGGBEWuXS+y6TgIifVii
 w6vZlg1pUPPzJOu6yOneL7Jyv65rWtjByHMsOlpP5lTKgwzVusrHGHTbqs7DNPED57Zs
 w1gQv9AuZ5utDrePHgSgyxUccvn3dWWG4z8iKjY+pr1gZCHEybutZY2lo84iQPliIUQG
 NSonom+91dWYcP82IaxHSHfuZpJrCo/jRSV9tsp6MI2buu6EUkREQvmWUKMM2+A/z0/w
 3uXw==
X-Gm-Message-State: AOAM532SoHRAV3I4Pq9LumqOGCGJqM4uMld/ALoiImLGVbYsFHunFA57
 Bn0ARv0GXTxk89VYpp8sDFA=
X-Google-Smtp-Source: ABdhPJxZnk4f0418KNqQnX3lXby2C82pRAFFA5vIDjprt2dOjZxUCuS3S/9M+qNXQYf3inmOYUKcSw==
X-Received: by 2002:a63:155b:: with SMTP id 27mr7092919pgv.269.1613716552746; 
 Thu, 18 Feb 2021 22:35:52 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (14-201-150-91.tpgi.com.au. [14.201.150.91])
 by smtp.gmail.com with ESMTPSA id v16sm7813099pfu.76.2021.02.18.22.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 22:35:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/13] powerpc/64s: Remove KVM handler support from CBE_RAS
 interrupts
Date: Fri, 19 Feb 2021 16:35:30 +1000
Message-Id: <20210219063542.1425130-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210219063542.1425130-1-npiggin@gmail.com>
References: <20210219063542.1425130-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cell does not support KVM.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 39cbea495154..5d0ad3b38e90 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2574,8 +2574,6 @@ EXC_VIRT_NONE(0x5100, 0x100)
 INT_DEFINE_BEGIN(cbe_system_error)
 	IVEC=0x1200
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_system_error)
 
 EXC_REAL_BEGIN(cbe_system_error, 0x1200, 0x100)
@@ -2745,8 +2743,6 @@ EXC_COMMON_BEGIN(denorm_exception_common)
 INT_DEFINE_BEGIN(cbe_maintenance)
 	IVEC=0x1600
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_maintenance)
 
 EXC_REAL_BEGIN(cbe_maintenance, 0x1600, 0x100)
@@ -2798,8 +2794,6 @@ EXC_COMMON_BEGIN(altivec_assist_common)
 INT_DEFINE_BEGIN(cbe_thermal)
 	IVEC=0x1800
 	IHSRR=1
-	IKVM_SKIP=1
-	IKVM_REAL=1
 INT_DEFINE_END(cbe_thermal)
 
 EXC_REAL_BEGIN(cbe_thermal, 0x1800, 0x100)
-- 
2.23.0

