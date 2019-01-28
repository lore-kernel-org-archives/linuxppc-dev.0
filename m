Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA1FC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:47:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69E7214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQSYUPI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69E7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pMBK0jkszDqNp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 07:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=fomichev.ru@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oQSYUPI6"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p9XZ4Gq4zDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 00:32:11 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id l10so11812560lfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=BtLosDylb6plgntW0BgR/OHZjU+7uJh6rBZxNNbVbG0=;
 b=oQSYUPI6ILLhQFXChep1tAOHqGUmhkL/io4doP5plJeQHz2HpHqV3FVf9kwsKpINr5
 tYyckxeRHWneDiKoiYKefZmx4MHC/IECecVWj6gdArmF/o4Y4/SPJyoVzdSU+B9XuHOf
 M0s9i/lGzZH3doylWvsk4+c6PkVdcbbG01naO2W9qE9fstWvz1jOutw/GI+edgUN2bE5
 Lm0UIbq2/IJ+katQsAYEtj93qzor8UZuI2YukN90RaJJiSdSs1rqCC32o4ziKbayLP2d
 L73sz8gv++sdFly3Hwd5zcIgk05pQ5Ep6dJxlfhRXjqNJm8raWm5PEcP3hHRNKnVinR6
 +fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=BtLosDylb6plgntW0BgR/OHZjU+7uJh6rBZxNNbVbG0=;
 b=bfy8Fo/prUsNfBCUYXE72rnzr2B3Swy7/Xf2zHtv8kXmFNG4UCXJkbuJbM5aOSDE4N
 +9JiQ0BG6dvLmMV7I9iC3rNGHZVACwBIcRjkpm8ciZ1GtFNnruFWK5SGMR+kb7BBwDiQ
 Ubi71tYOkBARxxuQFB7O+DX88eHTlLexTR6rRlCrlQyIstPxvV6KAHBg0QkwpN+HFPFq
 w/8Gqh49AFYTKqY9A/5nX75ektvTUUr/4ILD8QKh3StAq6/WKucY3BkL0gQGOlVYXflF
 0+2GOk4Syr1q7IJYrcesgum6PEEV5uMAaV/Ck5zv383Z9mhi89j2/MeALAP/sfKfoSLo
 XaKw==
X-Gm-Message-State: AJcUukdrHAQ0PYtrsv4TBsVTvyYRX2KrKEPSJwOH/J2VWFu4amz9EVYu
 Nos7QcaCJHJOlLIiezSrQxrh8Yvb
X-Google-Smtp-Source: ALg8bN6Vdw1fsTWAhfWFTpKmgeqr0ekRPMtdWQRRFcjkIFUCfCNcDAEKIqUjzmHxD2+Cl6JcdPVojA==
X-Received: by 2002:a19:a411:: with SMTP id q17mr16489429lfc.160.1548682327503; 
 Mon, 28 Jan 2019 05:32:07 -0800 (PST)
Received: from localhost ([89.207.88.249])
 by smtp.gmail.com with ESMTPSA id d15-v6sm2977645lja.38.2019.01.28.05.32.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 05:32:06 -0800 (PST)
Date: Mon, 28 Jan 2019 16:32:05 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc: fix get_arch_dma_ops() for NTB devices
Message-ID: <20190128133203.mon4a3nkrzijn43g@alfbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Tue, 29 Jan 2019 07:45:22 +1100
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
Cc: linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

get_dma_ops() falls into arch-dependant get_arch_dma_ops(), which
historically returns NULL on PowerPC. Therefore dma_set_mask() fails.
This affects Switchtec (and probably other) NTB devices, that they fail
to initialize.
The proposed patch should fix the issue.

---
 arch/powerpc/include/asm/dma-mapping.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index ebf6680..cb6ac96 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -70,14 +70,11 @@ extern struct dma_map_ops dma_iommu_ops;
 #endif
 extern const struct dma_map_ops dma_nommu_ops;
 
+extern const struct dma_map_ops *get_pci_dma_ops(void);
+
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/* We don't handle the NULL dev case for ISA for now. We could
-	 * do it via an out of line call but it is not needed for now. The
-	 * only ISA DMA device we support is the floppy and we have a hack
-	 * in the floppy driver directly to get a device for us.
-	 */
-	return NULL;
+	return get_pci_dma_ops();
 }
 
 /*
-- 
2.7.4
