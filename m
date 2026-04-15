Return-Path: <linuxppc-dev+bounces-19776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32AEF43824
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:37:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwkHz6jgmz2yvh;
	Thu, 16 Apr 2026 00:37:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776263839;
	cv=none; b=EyRaLFAFWA0hT7RFII4yaOzTbs2S8+bCk5FNVLK5kfsbk+5JZAG33VmKPPTrT/4KmCTFwlixvX+lkTMGSaj1T+E3e36D4c+Ok52Sh6n1KV+GE5aqVmpVkF19xyF7+zhvEBTWbCCL50RRCVUjVk88D9xo3uAm++0nhZgn/UTI33U8qLsgj/9NT2fLDsj76fV1x2dEYSXc5SgdN9EueARZ9hBOIhnSPFYXOQheQzXWQtZ+XXMTeFoORqP22RlqJCc0m2HXamG2qITcHCQ7pJndOs20VYT4eR6wGplvTX7gbcsU1djCx+2Xx3Ksi91XzleSYZqtHVHSxGytaK8+4s+Xvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776263839; c=relaxed/relaxed;
	bh=98VPopI4qbGCT1pqdO2A1z/c8E+zsHJEMVeJSMI3VR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haXkgFzy8dUT6+I371RlcpDBUNA5QKohaRKcLuweq7qhK46du0nJJVPX5xuyxYVeHSLXkOuN9nnAXGL0pLkxw3wdhAqLJiC32kXb5cMTYSGkm7X982zaGoZGPlTZ4c7hWC91CmqxGnJg/3z/bvdtC8+Qar8Er+RLKG25RJBw98gDgiWKaxN+XIPBe72mWu/Q7oi6GXZYMafQgMvWmfjbM9Fu0v6pmwvlg+TOJfjsMcqIrmI+b+T9NlGNpIAVCGhZC+stN528TgOXYt+ssagqoZghF+bIkANS/+6pB6vV3UFBLPaWMKc+I29WoJ1WAlBsZCL3LKP90tM/5ahitQRr0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sRk1jAZM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sRk1jAZM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwkHy0BmNz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 00:37:17 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ad4d639db3so35900385ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776263834; x=1776868634; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98VPopI4qbGCT1pqdO2A1z/c8E+zsHJEMVeJSMI3VR8=;
        b=sRk1jAZMXS/fWC4tO0SOXnhYQuHtkj8iYnWLFKgVEzmP3bD0x7n7M+8aDxDkjwNDNf
         VbiLiC8NTo9fGgtGKwWMeB1kifKzKlOquFKUOdI0qDJJydEx7o5jRir/3YibAlnT5jfs
         +g9uUB7Pjzfbgey6uR/j/kpuU5DkAh26eu/glTts7Kn2NFXl5/O0ISQIS6x80m06nknl
         f5jOshFBkY7g9fiqDVvcSoT8otFsYeW8f2CV9vKciHB+c2qGKLjDvDDGRSW+OmT9xyuv
         gtedrFtt2fkPKW2m/JaWMfmNw+zpgwdTAbcS8no7D8dVOdC1k3xD5bideuJwkau+E46f
         ueAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263834; x=1776868634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98VPopI4qbGCT1pqdO2A1z/c8E+zsHJEMVeJSMI3VR8=;
        b=kNXYAD+zmHUt4FSryfNIr/5UGIB8tVoYKV/w5gcIUGZVqTVNfvoz6JJPRa6dk28PqN
         ZXA45vNpcMbSVM+lbhZnWX4xhHwvBUEk7n0k+f+BcXTGMDVUdczdJRI0VnsK7tUdFzl2
         Bile1K1eGG0oC45JzmoV3VUmMCPxbWAxSmGSpmtqCdtifu0JYk1AuX1G0T9dtki2VWRS
         ptaEDxP2DDOFmaa9KPBTf0zncteecDVB73F0d+KQ2IDvAPkoDjmmNISD5vSRyw4NfMLl
         zU3P/xb02YjxT9vpd4xOTUzW/o1yDWJJi+ZOPO1yic42B0gzxx8laaTXIOOHpfEj28B+
         udRg==
X-Forwarded-Encrypted: i=1; AFNElJ93Z5UYcZ5bYwjSuQjhIliFYUTq3OMaTh8A2nflwOLCktY5NNlWtflR3IeEoYX+9y8txAYOGJPTb658XvY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YympXq+RiVfJFvFoDme92qrZzAZp1GqagNCFDQtaFqQ4ktIazOp
	mUB3TjW3xJUaOncz8frmjpsDAxH7TRQQ+yg5+UYT/zA0K4Q2fLQPkBQ8
X-Gm-Gg: AeBDieswlPFE2DabjP10Uxzf7p8N8Fr5I9fkodCOWbnXyl2kE9+1Efk1RtZElJR7Wjc
	Miecxdb9PNGrv2LTOuqb/GbZArMEwh8P6dUFZTmKLfwS//1SncZ9WLHLuVBHOW0En7le3/ISc8e
	C4lW2eXVSX8vQge03l/lbB1VwYkdWLAQ2mi1k8a9fyX+LiUHD6vMHeaYLh0nMOPq6/YYbPhkq0h
	JwMTAz5uBtsAOWKucVTvy0drN3Lf9zOttnl5Tyu/zGISvGq7uFUe/VfbJFaUcian//kkKCLPOpQ
	msFZ3dOvJPpcjd63WxBZ+HioCPo6tj8aMNyEzfwzdXqMB/arrd5mFu0coXbC7maMn00q3MmKVuB
	F3oIjbijA9KHgvzhmtsn5829cGh08FVqnWVJ8p21USaWrkfodEJ/SCaojIn8/jACCJD7QBCMg11
	jndQu7c6HIeUvw8Tymfpt3v3/X/B4DBguq
X-Received: by 2002:a17:902:9308:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2b2d59b9facmr176124965ad.11.1776263833795;
        Wed, 15 Apr 2026 07:37:13 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478142565sm22902665ad.37.2026.04.15.07.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:37:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: adb: fix reference leak on failed platform device registration
Date: Wed, 15 Apr 2026 22:37:01 +0800
Message-ID: <20260415143701.3309681-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in adbdev_init(), the embedded
struct device in adb_pfdev has already been initialized by
device_initialize(), but the failure path does not drop the device
reference for the current platform device:

  adbdev_init()
    platform_device_register(&adb_pfdev)
      device_initialize(&adb_pfdev.dev)
      setup_pdev_dma_masks(&adb_pfdev)
      return platform_device_add(&adb_pfdev)

As documented in platform_device_register(), the caller must use
platform_device_put() to give up the reference initialized in this
function when registration fails.

This leads to a reference leak when platform_device_register() fails.
Fix this by checking the return value and calling platform_device_put().

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c9f6d3d5c6d4f ("[POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/adb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index fe150125e099..eff06f78aa80 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -883,6 +883,8 @@ adb_dummy_probe(struct platform_device *dev)
 static void __init
 adbdev_init(void)
 {
+	int err;
+
 	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
 		pr_err("adb: unable to get major %d\n", ADB_MAJOR);
 		return;
@@ -893,6 +895,9 @@ adbdev_init(void)
 
 	device_create(&adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 
-	platform_device_register(&adb_pfdev);
+	err = platform_device_register(&adb_pfdev);
+	if (err)
+		platform_device_put(&adb_pfdev);
+
 	platform_driver_probe(&adb_pfdrv, adb_dummy_probe);
 }
-- 
2.43.0


