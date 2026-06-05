Return-Path: <linuxppc-dev+bounces-22135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD27CD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlZ2V92z3btJ;
	Sat, 06 Jun 2026 08:02:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696922;
	cv=none; b=h02vmruwbhKAFoPStmVXkTHRBRXV7IscduOE7F+eZbH3tRYa15g4oTFVR/adkm80R0sQhT91gkklgTu7WQ2VrmT5QtpyOSJ5Fu1BMdJoDfoOEBe36ZezDuJ70wcFwif3svmA1jKSUqsaGno1zZXbUNuYo86+XloqW+vGczG8+Zm8mGmQ3gpo6RCwoWOJXK6swvZi/+OmQmbognLI1YU1ZKuEoSFNFpSVlNckR1Vx2kpSnUAGlNA7vHmkIiaDLkS9F0/bfuV2rG4vni5zXYuAd3xPATJfZtmwcDb7FYXJ3H4cpxQ9TOENWnAxnu1topK3mJ12LFZhjbOAXYy1I9baag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696922; c=relaxed/relaxed;
	bh=5sz7+xisuSM5PYR/do66zevMAZphs/3eVGB3/an7yPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcADc+vB5TeBT/RYfY7lmZLa/PkcBt3xOr4zMYR5jTESZS5IMRMPO7hTsmkoXDwrQ9PzNpk/cCqPHNlZZ0nWEVyfgdU7kMfHv0lqciqkPLKiokY6kLbVPo7UWWpjFhTqNP2URmeJmdbHsLZRAa3wS86MZYgcBAu4SbLgIHilUl8FTDkBy5BsUWIm/nFhzqxS0pFOrWcwkvfRUURLSu8tJ+hwggmAV88cM67MHWjCis1gCPccCFFdJO+eTtEar+NUOs8GWHcTcfHu4je3s+2ZpTFqXD+6W29EnLTLn25Q2idNfpmrrtCpFWc+VHVrP3u559vJXLIfRWcM6Kwvg/csKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SBIlRSq0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SBIlRSq0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlY2gpxz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:02:01 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8423f52af13so1719446b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696919; x=1781301719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sz7+xisuSM5PYR/do66zevMAZphs/3eVGB3/an7yPc=;
        b=SBIlRSq00/rvXQk7AsxWmMTez4e+4FAsfBWwKWg/w3w9jyEVdyrZ8MZR08bYE3aeFD
         yAKdeCiQ81YjjgfWJqaN1rDFJ4PlncRxzzh+NreWtM2n9/R3ACVhEYKq9A81XHRi2QX5
         vCPxZGplTLRB5TjPCmx9zlY3UIfhpRa49xUrEWK53Ij0IFXibALfW6yNQl5f6p1GCDkm
         81maxPcUKXdH51lN7zJcenHLwa0pjs5Ek/rlm9GtUZZSPSpxYk0G2sezkKxrSxex1xQd
         SBmG3lAjwIUTQaA9sPCYUC+VPKhPBgulX6wH+/U33pTbnFZaqKZWPDLqUimFg6H27q1M
         d3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696919; x=1781301719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sz7+xisuSM5PYR/do66zevMAZphs/3eVGB3/an7yPc=;
        b=KbcpkOgeVAjY4YpgCx7GYqGDupahYGZe7HArDn/6L+00dm/p7qSovgK5WT5xeNRa/p
         04xfTISRv9y3n38+FF9ougsAVuOHuELpKIXU/ggmhDaw6sfRua15sEoP92kj7bSlnLJR
         2ksEabpoGaTxLTC/fcHTgVjQzmf7UvuWNWR6yg9QMDqkmwtf3aAuW4Ohbwbghyb7rnmq
         hPzHMp4/fHReCXLKwHvXy1atXThUNbUVgLS7+2HgRuZiusuo662OVMUSwPRtX/2FJLWJ
         r/wEeRzV96NZkmexinrMW8qIfGceSDE5E56lWhiVn8S4zc/ASmejTV6drdke3Fu/SDDh
         ZLGA==
X-Forwarded-Encrypted: i=1; AFNElJ8vYxx7A4I4LGDIaHVCG0Zzj12W4hrEb5JyViASCYGBlCtCKJEqRHCbIhSXkLVrKVhtxqJ/BrOd9x4Tn/4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypsyLmRyrsYuWdEhhAActtF/PZA7xvlMGIHPA81NC0XK4duo0X
	/wnVPiLp1DhqRlJcFN2j5sGwg/k1wwKnup3d1o5fo7FgZH/H/spihwxO
X-Gm-Gg: Acq92OH50kRl0jN+t1BIjtPADtDhF090sHh2oFbKVWC4O03lBjiPFcDIInIBfUyaltl
	vOkBKIj/avhOXVPAyjjaGLtjK4XwRw9D1tpbpYS6KZGFHpuAlgh6WQ28ne06y7xDmF5e7burZRC
	TD2yuEsVpK9xt917Ae8YCLW229Qq00AgIVoBGx9mLAnsEpTTT+Akeexs1N6vT98Oeszes5XWodC
	mWx8KHI7Fl5nVCK1oyJ2KpLB+k7YFOZjXcPEwkLNuTChcRbgiHqXMrgtkDiQZdhk0CAQqZtNX5H
	vEL4F3Dtjcmpb1KXvD91xeqMNEX42MYBMtItaP+5OoNoYPU7JeUIg2cS/8Jj/9vgICkOZvwTY1+
	60fxKZGRYp99lbhIbOGCnSvS1pQc2QFFADTlZSqKPwZ/ISTzAxs8wbkamxATURKElv+bLZyPzT1
	g1jo9E4F9cA6gkLLT0/taKInhvBKY0ht2/1NuOmIugCzIN/afe0yiCINVgziOoUHH/6btO0mkvz
	UefXzEU6LoppJVxre7aZ5BDG90Ty/RvbuE9Z2kvPKSwrzsyETy9IYp1
X-Received: by 2002:a05:6a00:21cf:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-842b0e1e1f7mr5458741b3a.7.1780696919249;
        Fri, 05 Jun 2026 15:01:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH 04/10] dmaengine: fsldma: convert to devm_kzalloc and fix error path
Date: Fri,  5 Jun 2026 15:01:28 -0700
Message-ID: <20260605220134.43295-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
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

Convert fdev allocation from kzalloc_obj to devm_kzalloc to simplify
the probe error and remove paths by dropping the explicit kfree.

While at it, fix a goto target mismatch introduced in the recent
platform_get_irq_optional() conversion: goto err_iounmap should
be goto out_iounmap.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0d28f8299bf8..2efa16d12679 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1213,18 +1213,17 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 static int fsldma_of_probe(struct platform_device *op)
 {
+	struct device *dev = &op->dev;
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
 	int err;
 
-	fdev = kzalloc_obj(*fdev);
-	if (!fdev) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
 
-	fdev->dev = &op->dev;
+	fdev->dev = dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
 	/* The DMA address bits supported for this device. */
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
@@ -1233,8 +1232,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->regs = of_iomap(op->dev.of_node, 0);
 	if (!fdev->regs) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
@@ -1313,9 +1311,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1335,7 +1330,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


