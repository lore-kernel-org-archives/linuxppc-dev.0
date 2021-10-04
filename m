Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0055C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 22:25:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC2F61528
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Oct 2021 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDC2F61528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HNZzh4F5pz3dqk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Oct 2021 09:25:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WEUa66Fd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=naveennaidu479@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=WEUa66Fd; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HNMyc48nyz2yJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Oct 2021 01:08:56 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 cs11-20020a17090af50b00b0019fe3df3dddso69357pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Oct 2021 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
 b=WEUa66Fd7WtoDf/7Q8UM0ovCljnLKeI51nGJW39td75KXO3U8ACM8fup/QKb83eEnY
 5We5vSmFdYsjyhUd+BXEy6X5npUgLcRVji1T8id5/IdsPYDffHPrdeaJG0vcp92GFYgi
 /6cPJrhvm3IRtDg+CimNj7eF2wU/5hwajfSjBiZFgJUU2FKT/HNmgWrawEp913St+qtS
 /UehFaW02zzrxLTQPZT3rPz0B/JK9PUF3MRNhNTHfHAXJCZIMrSKgiNUCGjl/4AKrB2a
 uvfiedlgTlMHTIz3lNS7YMTHLlXplBBRz1W+93YjBV8x+zquGy421afJsMPsjOnaue6V
 ZNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
 b=Fie3lQX7e++CGumrUaDNJMZnYJ4YcfL2hY2GUv+nSy1bgrctMuAX6TtnHuAjKnuy90
 1e5v5fz8B7W7FDlskRf4+8GimuiZOs1KKUFCZreLKbjRSPlEs9ynJheXm72p/C9iFaM3
 rMD+MsjHUVI1tG4fVbbOfjCHmlYAcA+dIj0EypNq34WMYU1QFK0oj4zOsf3dYMNsikAf
 6jq8G+/+TTjj184a4gmj+nbSFR/IO9ISx9jbRuYBqO+ZL2lkGsdi6krmLibWXVogM8yL
 JOQADnICLdvbR8hR2DypNJKlbhm2AL3DApuhgPITXBruBS+fXfptBz/69BKs3WCfw2Zl
 XVJw==
X-Gm-Message-State: AOAM531I+dOzGo9IqdW6AM7SnIs7kymp/4FMOcodcYjf12+K/twPUX2N
 PorOwlfQsOP2kztibEEU6RI=
X-Google-Smtp-Source: ABdhPJxiXt3ftOJK3flYITskQM3Ai/Q5NEFZd6Kg0s9wJr1Y2Z0LU5DHKJF6ULES21X3Rgeej6QwzQ==
X-Received: by 2002:a17:903:246:b0:13a:22d1:88b with SMTP id
 j6-20020a170903024600b0013a22d1088bmr23318540plh.16.1633356534168; 
 Mon, 04 Oct 2021 07:08:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
 by smtp.gmail.com with ESMTPSA id
 p2sm15274135pgd.84.2021.10.04.07.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 07:08:53 -0700 (PDT)
From: Naveen Naidu <naveennaidu479@gmail.com>
To: bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com
Subject: [PATCH v2 4/8] PCI/DPC: Use pci_aer_clear_status() in
 dpc_process_error()
Date: Mon,  4 Oct 2021 19:36:30 +0530
Message-ID: <71cec6aef2535b48911bd98bd010012643eb0bd0.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Oct 2021 09:16:56 +1100
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Naveen Naidu <naveennaidu479@gmail.com>, skhan@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel-mentees@lists.linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20211004140630.50sXzRQVH1C7mjCFZr-A719KucREYTnjYgqh2a3ycqA@z>

dpc_process_error() clears both AER fatal and non fatal status
registers. Instead of clearing each status registers via a different
function call use pci_aer_clear_status().

This helps clean up the code a bit.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df3f3a10f8bc..faf4a1e77fab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_status(pdev);
 	}
 }
 
-- 
2.25.1

