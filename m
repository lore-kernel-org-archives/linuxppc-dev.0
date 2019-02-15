Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C9EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:01:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E4621934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raV8HANL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E4621934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440w1l3Mx9zDqZx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="raV8HANL"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vl50BWXzDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:32 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f90so4046012plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e/bZztgTuRc6b6QMzo/bQ5CptpgZV2rogpTll22dfes=;
 b=raV8HANLFu7qFYwermhycY8c7exeZ46TblllRX6vcaVUNnEySa2AIq6uWKAt67yMmG
 D95RZ2RMEL7Bpk/4fxROWidu5/Yxwveu62AEErWV8YYm/UQM1vpgujiSEbDSzWx2s0be
 4FpFyiU8q68QJ5zfExYyROeX8Tm226lNBcALo1G8zA/mYOfatKg2qzRwCS3sSm6QbO4n
 UMPqkGsqUWYf5qUnBen2OqX57QR/1D++agWeA/e38fwzTImAZynViegogcIshIQhGd8J
 rsPmCXOMVIyBfFuTjR8k9UUUTgwKSrcAU7ycHgxGIcbxSaP5ucbraXHX9VkGx4Z3ELAo
 jHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e/bZztgTuRc6b6QMzo/bQ5CptpgZV2rogpTll22dfes=;
 b=sciIEeuEDY6A3MLq0q3LBocpCRk+IMTlftEY1ZRKlbdfemz3xdvvc+JAjLcPDwA/aA
 rtE2oI428aswFu3Elj0TYBNW3byqSX18kF+lqGybdlnDqRey7H0lZ6R+G6pvrkMx+AvZ
 53zd5p35+IdlotK2RCpifrtXN3VcHMJB+A/zYZu8HWEsjk/SQH91mu1zfMsPzVRgsneS
 drtW+ZiKAoDXs/BtGG9Nbtik8aoNaS41NMZWBcVTuTXUs06GUG7cKSPezmX0x4HWUJpw
 8/3Ad7+WFjSM5u8Ta1P8hKa6EIr4BNQOOwD9J8/6nrS2n99jEI4bQUNn/eWz4pDh0bZs
 0YYw==
X-Gm-Message-State: AHQUAub/Yb2kWlHChd/2MLJ/3v1gSWhdp3pTEdPMLDp6+K8p7FWszweh
 JTp7Fya24f1tMhPUlLvkrND/113m
X-Google-Smtp-Source: AHgI3IYSjEGqYHf+Dd8rBfL1etJz9aRj7yupjh8d93GwRBqf+1LfHYB9j4Az3xdD0zz0JQ+PuQLOzg==
X-Received: by 2002:a17:902:b217:: with SMTP id
 t23mr7195130plr.321.1550191711082; 
 Thu, 14 Feb 2019 16:48:31 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:30 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/7] powerpc/eeh_cache: Add pr_debug() prints for
 insert/remove
Date: Fri, 15 Feb 2019 11:48:12 +1100
Message-Id: <20190215004817.19961-2-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The EEH address cache is used to map a physical MMIO address back to a PCI
device. It's useful to know when it's being manipulated, but currently this
requires recompiling with #define DEBUG set. This is pointless since we
have dynamic_debug nowdays, so remove the #ifdef guard and add a pr_debug()
for the remove case too.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 201943d54a6e..b2c320e0fcef 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -157,10 +157,8 @@ eeh_addr_cache_insert(struct pci_dev *dev, resource_size_t alo,
 	piar->pcidev = dev;
 	piar->flags = flags;
 
-#ifdef DEBUG
 	pr_debug("PIAR: insert range=[%pap:%pap] dev=%s\n",
 		 &alo, &ahi, pci_name(dev));
-#endif
 
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
@@ -240,6 +238,8 @@ static inline void __eeh_addr_cache_rmv_dev(struct pci_dev *dev)
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
 
 		if (piar->pcidev == dev) {
+			pr_debug("PIAR: remove range=[%pap:%pap] dev=%s\n",
+				 &piar->addr_lo, &piar->addr_hi, pci_name(dev));
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
 			kfree(piar);
 			goto restart;
-- 
2.20.1

