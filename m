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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B93C74A21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:40:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35A8208C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 15:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLmWIkyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35A8208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kNgS5w10zDqbG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 01:40:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLmWIkyd"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kNH30fbjzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 01:22:54 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id r7so1268057pfl.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GObua8H54fup3mM+gXxoZ439qwDeiSqF74A3rMTO8s0=;
 b=KLmWIkydT8DgUfFZSZQde34O4/Vq68V7cXjBhzyt+6Ojxv/VS12ImwVneZJ7AJEBrT
 KWBn+ZvY9PyEiZamOMu3AWZZtYUumXbUIrbRHuJk1tBl0GRNDR0DyopQRaGyS74jSaVx
 dpKxa+2aYiTr/OMzXgZ50jShnOxBl8aodIBnlziop0VccDCiGpCwLDyWPqQ+WIjbueAZ
 ThN7BsE9Dsll+ZfS3ljoX40g7pBBcIQsgoqECPA7xxRgGqZ855gZtaW65CkN45kjcVMZ
 Wu+SsXBhkCpuYpWcfXk+3XqbKoOGUO3+wQifIoXH1/J4Daz/hYe9dYYe4zP/HkNpzHO7
 iyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GObua8H54fup3mM+gXxoZ439qwDeiSqF74A3rMTO8s0=;
 b=Qx/xzqTjU7+HYSp1bOYhiFBfAXM2FB3Aovz682nGPmZ+BzKH9zU9iHd4o0KYt56+Cx
 rza1hYgWbTFv4tfwJiBJuWnASWbwDYZloLXzq+v05LNJldv5/AddR0vUv6/lvHdx1v6n
 XjHFA6Y9xaRSXMTDmlWxQ5xyj7+vASErzlbSyou4QcDT+QyULfd/AhN1QZeAM0KG80+5
 C9+VRsoiKVzltUV+GsRZ/2A7xMKQfBONzpyLs6DSS6lCo/EXhMROHsmfwNGjzaE9brtl
 uJ6ptSNhlKZ+8/joww4rGrK9XNipkHE5uxqdrhOoeAHOqBFxN/24UK82UqJPJwqdgKUS
 obDg==
X-Gm-Message-State: APjAAAVhx/fsV6n0NU0VforbNi3tSGmPSIUsS++cm9HwmmYAYvozEmAS
 pQt86s44Kho4hhf780yGmu1+ltY517Q=
X-Google-Smtp-Source: APXvYqzUGRFfjoLJv7wNiNBD3Yib06Sey3PtreM+aTUWWZLuZ9n+xZWEY/OjVKqRveQ4qV3xA1UMIA==
X-Received: by 2002:a17:90a:8a17:: with SMTP id
 w23mr7376928pjn.139.1562772171998; 
 Wed, 10 Jul 2019 08:22:51 -0700 (PDT)
Received: from bobo.local0.net (14-203-207-157.tpgi.com.au. [14.203.207.157])
 by smtp.gmail.com with ESMTPSA id
 s22sm2699212pfh.107.2019.07.10.08.22.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 08:22:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/16] powerpc/64s/exception: machine check adjust RFI
 target
Date: Thu, 11 Jul 2019 01:19:38 +1000
Message-Id: <20190710151950.31906-5-npiggin@gmail.com>
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

The host kernel delivery case for powernv does RFI_TO_USER_OR_KERNEL,
but should just use RFI_TO_KERNEL which makes it clear this is not a
user case.

This is not a bug because RFI_TO_USER_OR_KERNEL deals with kernel
returns just fine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5789a00691f9..0186a44bb981 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1184,7 +1184,7 @@ BEGIN_FTR_SECTION
 	 */
 	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
-	RFI_TO_USER_OR_KERNEL
+	RFI_TO_KERNEL
 FTR_SECTION_ELSE
 	/*
 	 * pSeries: Return from MC interrupt. Before that stay on emergency
-- 
2.20.1

