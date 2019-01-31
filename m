Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:00:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1475620B1F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meqkKuw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1475620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rCLx05BdzDqf0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 08:00:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="meqkKuw5"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rCJw0vSHzDqch
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 07:59:08 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id 96so4879688wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mXS9NP/b2sVyiEffkEe4Yvs/buL9inT0kUkRToanbOI=;
 b=meqkKuw54v3jW4zw+cMVF0M0GI9ePiiS8A0xw38rysonJT5rtFthxtTM0DAkJrYdBB
 Mki0t2gwBUH1ZMfRSJMjERSEC+vJakOzpxSBBELpw7+kV/dZOq1cgMlXIAISEj/XRdWz
 4FWG+9HY23skHwhIwtfLEcGyVCMV65KRmerhnzit6qBHtb3aOxoqiVPEPhdyPyzPCZrf
 c+RPJE7LFsPzLuODkrZ7qr5IK2RuD0lSnfbWnvVgDbO1K1mE9FzK99/ZyYExNedM8kIZ
 2wEAbxddLvwvJjhmAj4Kf2M6GyrXdn0ToBnWuJSJ47aqLLSFIXrA5Bvg1lfRCmL75oE3
 nv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mXS9NP/b2sVyiEffkEe4Yvs/buL9inT0kUkRToanbOI=;
 b=tYCFJdAkdNUdXoAvZLxaa3nOc16Y9LrmDY7UVreqmCXuVB7OX8RNY2aCETWcNvxBAu
 WBan9rVG8tLJUfpICI+ePk+F8eVO3i5YBYNRV7z0JUjXTzq/NVmvFZf+FOpIeLe52A4A
 A7XYBMN34JYqUoOtWppJ/lVkm80mOUI7CqL6gJSd61cWnBVfEaSZMW8wBdGbTDiQ2jqQ
 3QVeBKwv1G26154zHCICk9NAo5gYyrseUmxgCZT0OOZMqaAA/xZxJUYmTdJSRUC08c6Y
 INSKQiaMUURzJrhsyEiRAkKqANPe/Amg95WCbyHVD0twkO1DfF+WhpZp36TPxs6WoQx/
 mRCA==
X-Gm-Message-State: AJcUukdZT104icE2WrlDIYtSnq45+Fljil+vch2hZe4bkXyGeuw8JzsS
 gQ07hS0DqI5QHFBTf6rBODoVNAzw
X-Google-Smtp-Source: ALg8bN4pvEjFDXdRNpN8w5zA14ETH+SGl/8Smi/8KQoc/tDyAckPvEwuQKrSubqGpMLLApcK8Y3RtQ==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr37749241wrr.39.1548968345776; 
 Thu, 31 Jan 2019 12:59:05 -0800 (PST)
Received: from debian64.daheim (p4FD09B65.dip0.t-ipconnect.de.
 [79.208.155.101])
 by smtp.gmail.com with ESMTPSA id q3sm9191947wrn.84.2019.01.31.12.59.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:59:04 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.92-RC4)
 (envelope-from <chunkeey@gmail.com>)
 id 1gpJQO-0006BN-3b; Thu, 31 Jan 2019 21:59:04 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Enable kernel XZ compression option on 44x
Date: Thu, 31 Jan 2019 21:59:04 +0100
Message-Id: <20190131205904.23723-1-chunkeey@gmail.com>
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
Cc: Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Enable kernel XZ compression option on 44x.
Tested on a Western Digital - MyBook Live NAS.
It takes 22 seconds for the 800 MHz CPU to decompress
and boot a 2.63 MiB XZ-compressed kernel simpleImage.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..58b6ad3555e0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -201,7 +201,7 @@ config PPC
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_XZ			if PPC_BOOK3S
+	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
-- 
2.20.1

