Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:59:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0720739
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0gNcx9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0TJR286RzDqBm
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 11:59:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=D0gNcx9X; dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0Sq25fjbzDqWg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 11:37:02 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id f7so36122662wrw.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tK2OKYTdoNgaZIMKtk4yQ/mFGs11a9/b8EH7Vf/oM2o=;
 b=D0gNcx9XkyM9RZr2hAT8h1ZTL7OW7CFdRwqhUuOjigschxYGJawBsikLSAvReCRCq3
 B479QRVO6ZgHoWmy7hPp7uvCwkoEFkT660NSnjKu7HlluYB9PZ/FPx8+SPSyyoaM/kSu
 ngLfLr/i0HYyHTD2sviW/Ci867O0pvjUC38E7RPBtDVsI9r+bLX0OCrBRXYLRySINsCG
 +O3p5TgD6XyHeENsrUi6d8EFowVLvo1cVYh1aiWIrGlUa+GADfRSF2VX9z2y+gyLOmFX
 7WOEQd5eW8ol/4Ot76XyAkpqKZL50VFXJZQCDXkDe9UcqiC4Z1m54H+YSCencHCkTMm2
 ioTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tK2OKYTdoNgaZIMKtk4yQ/mFGs11a9/b8EH7Vf/oM2o=;
 b=KJ2d93iNXLF7aklcJtNC/O00OKyhffMcoe3z7ACQMWAaPo6o9BU0DHnkchFALYqJun
 1Fc8Sz56roTLzNxpByPh8zh8gomD/4gQrr2Cu1vPYL+KguolxiL392ncfT2E/D9ogXxu
 mvHPoca7a3ws2mhUoQoTcZkqeLUpWXH6bfqLng/Mw1htNUBqtfVF7GU+JqKn/oWSaFAh
 RCAxX29qj2kJ8FMl8bVhU4Ke2LhtZlheGQrOfWc/a/5XwHPw4sKrzvAl/l7CZN2mKiSr
 XoeyDIRscYnnjgyuUSndmqdwZQ+bEzIMaTzqW/4q9U1OPDTX7ARg0abmHc8nKymD2ZVP
 sAJQ==
X-Gm-Message-State: AOAM531YLBWX6c65EtzWw2FCzavylEywlzMmFBfBmwfNof9zceospogP
 uNIvMWh1LjgMoF3UN6QHLzcalQECAXI=
X-Google-Smtp-Source: ABdhPJzrQuVtwvK8unKlZ3LKzH8GRaI91xClEYf070XpY4b7Kguak1OaPGP3eeu7wqyAEn7RidhyYA==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr45951058wrl.7.1593999418863;
 Sun, 05 Jul 2020 18:36:58 -0700 (PDT)
Received: from 192-168-1-18.tpgi.com.au (59-102-73-59.tpgi.com.au.
 [59.102.73.59])
 by smtp.gmail.com with ESMTPSA id v6sm9533392wrr.85.2020.07.05.18.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 18:36:58 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/14] powerpc/eeh: Pass eeh_dev to eeh_ops->resume_notify()
Date: Mon,  6 Jul 2020 11:36:13 +1000
Message-Id: <20200706013619.459420-9-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706013619.459420-1-oohall@gmail.com>
References: <20200706013619.459420-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mechanical conversion of the eeh_ops interfaces to use eeh_dev to reference
a specific device rather than pci_dn. No functional changes.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h               | 2 +-
 arch/powerpc/kernel/eeh_driver.c             | 4 ++--
 arch/powerpc/kernel/eeh_sysfs.c              | 2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 4 +---
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3eeaa5ef852f..2728a3790f6c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -230,7 +230,7 @@ struct eeh_ops {
 	int (*write_config)(struct pci_dn *pdn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
 	int (*restore_config)(struct eeh_dev *edev);
-	int (*notify_resume)(struct pci_dn *pdn);
+	int (*notify_resume)(struct eeh_dev *edev);
 };
 
 extern int eeh_subsystem_flags;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b70b9273f45a..b84d3cb2532e 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -425,8 +425,8 @@ static enum pci_ers_result eeh_report_resume(struct eeh_dev *edev,
 
 	pci_uevent_ers(edev->pdev, PCI_ERS_RESULT_RECOVERED);
 #ifdef CONFIG_PCI_IOV
-	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
-		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
+	if (eeh_ops->notify_resume)
+		eeh_ops->notify_resume(edev);
 #endif
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 4fb0f1e1017a..429620da73ba 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -99,7 +99,7 @@ static ssize_t eeh_notify_resume_store(struct device *dev,
 	if (!edev || !edev->pe || !eeh_ops->notify_resume)
 		return -ENODEV;
 
-	if (eeh_ops->notify_resume(pci_get_pdn(pdev)))
+	if (eeh_ops->notify_resume(edev))
 		return -EIO;
 
 	return count;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 83122bf65a8c..7a4c7a373241 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -793,10 +793,8 @@ static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 	return rc;
 }
 
-static int pseries_notify_resume(struct pci_dn *pdn)
+static int pseries_notify_resume(struct eeh_dev *edev)
 {
-	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
-
 	if (!edev)
 		return -EEXIST;
 
-- 
2.26.2

