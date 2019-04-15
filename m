Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBCCC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 05:13:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1628206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 05:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtnBpAba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1628206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jGqD1cTvzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 15:13:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gtnBpAba"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jGnZ2DnCzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 15:11:46 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id cv12so7959000plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oSGneWDwqPcQ/1uKUvy/mAJTAal0mUhqOrAC2vJDI+0=;
 b=gtnBpAba0JO8gShgvZL97bEzqeIryR6W73+YSHNVQkoJ7UK56dvp72s4TJGuU+iW/M
 k1xJa20SHZscXdSEzLIV7Re26sc6pDW4Bw1PC08S4Fp9o8QtvmuopyVwj1wQCcnIX/1z
 ya6G4TgnM2T0KJgWpT1rikceMrD0T21JVg+TO/lTJmo+AO6X0Zo/D5Wv9jyx0X+is8Er
 7WROL5jOutW3NPR7jnaQ6y/ax0Xf4WG3PewnvhmOTqcraESoPnCOamwBJRK88FveyHuU
 nIIq9gh/LXUO88rNaaZ244I2j5TRJ+qlrjtoHB/IGDIZgS5uWrSmpOh5sTL3IrqcKIDr
 1APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oSGneWDwqPcQ/1uKUvy/mAJTAal0mUhqOrAC2vJDI+0=;
 b=k9ihwR2YGLODdj3c8usiPd8SX0gRrj/GcDtxarC0emPCxkuHVLMIeVQzC6Mt1QtGlF
 cU2nkyx8HUggt8QZnZNZZ0wLPyOO4JCQV/XASbx5A0UQH43gfSw/cL+eO4DlWkHyt+2N
 EPnm81IBrZFl6cGiGWhENFHvQ/uxfSFSpZmvorCCnIp6qGxKnbzMSdOHqNC7FVXNJFAP
 IiItCXNWcPGcxKsPpYlUbdPv/nUsDaWmolkzKlZnBtEXB43b59VFnHREzEl6HWl5goY3
 k+FzB4f8HFopA1vidYfjQbLqoVEwRoY9oDSIAMJ0qSvfK05qAXNKF7DViUGTqWPaIhIy
 j4UA==
X-Gm-Message-State: APjAAAUoIsFMzABxDYVwQ9PD2bfHA9/Eo5T8siLm4Z4X4wq8uKu1pxfy
 xT3AiN6VuPnhe1dzjgV+9fEBI5dC
X-Google-Smtp-Source: APXvYqwPaYo8cTN1izSR6AZoVx/c2RLRSLsz+WDHa+rfe0oJmp01UMAv3+dIJpw9Vx+m3XcrusBdHQ==
X-Received: by 2002:a17:902:bd92:: with SMTP id
 q18mr73085126pls.136.1555305102640; 
 Sun, 14 Apr 2019 22:11:42 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id k14sm110404418pfb.125.2019.04.14.22.11.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 14 Apr 2019 22:11:42 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Remove ifdef
Date: Mon, 15 Apr 2019 15:11:21 +1000
Message-Id: <20190415051121.8859-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The PowerNV platform depends on CONFIG_PPC64 so this #ifdef in the middle
of platforms/powernv/pci.c really doesn't need to be there.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index d235c2c..a5b2c7b 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1039,7 +1039,6 @@ int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
 }
 EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
 
-#ifdef CONFIG_PPC64	/* for thread.tidr */
 int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
 			       u32 *tid)
 {
@@ -1060,7 +1059,6 @@ int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pnv_pci_get_as_notify_info);
-#endif
 
 void pnv_pci_shutdown(void)
 {
-- 
2.9.4

