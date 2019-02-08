Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A068C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:15:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DA42146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZ76tYW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DA42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgKG5d1bzDqVn
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vZ76tYW/"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9j25RnzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:25 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id g9so1001662plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G0jVPbyC81UfkD7GYRMd3CFXjml38fgzwspejNIxlR0=;
 b=vZ76tYW/0R7GCLr8F93JA62YciwT1QX9N+bP9axnzQrF/5Abx6Lb+q/AQbu0DqimIR
 O7AQY5tiPhD3vU3nS7zWrPlOZwXmhp42ZiITGvA+rxCUw3tE6dJiXrXCYAXTDQ1m5CGa
 8qQLaXSwUk4PhPspPZ17QZvbIk4sC74coNBmDyrEE+L4zmNj+ZO0Dp+8MwI8G52xqjQx
 ClH+w2pbYTFnzrMSOPssozv1C+Bp+l41kHFwRVYRD5K7AdgWt9bQ2Q80gAYFGiSZCKIv
 jrSJZLCffHiRWdEdzuYvR86m8AYqfmnfBS/egUFbojvFsVWKPZmS4V9KfmbFhHZRaH7V
 blVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G0jVPbyC81UfkD7GYRMd3CFXjml38fgzwspejNIxlR0=;
 b=Rl1Y1M7jaM/6OU3alhOMEEhoCrIMUw8kmK14CZf4mkhOjOsRBf2GMKdX2TCkTDZ4w4
 dQVigHSaxnVhZbzK5icWPv6thWs73QfJQb2TG/UHJiryaPduylfTcigHXB3oFHYs2dSw
 eXi9h3xNsVHq/s2DhYGoOmeJ2oET0KJXUG7Kv5b/qrPOMyDny0GHblxVYckRJIdL8SgA
 ktujxrrf/BgmVVkP4Xr2LtQ/wdV3BTsb14o0KSfMsMO5s8oPOUOT0XR/3yNYush/2tRz
 N+BJtoSpSx6juRmk22rytnOWYBMetDV9ZAKskzLXx2GyThTYp0kLIiy0xofjb/MpHWx8
 /HyA==
X-Gm-Message-State: AHQUAuaptd7jmsr6CX9uZyMv124PynXx4yPE9JxhH5zShsiz/EAnV9Cf
 YrLqBXJmf6/U2ZwifjXUNQTrp/jm
X-Google-Smtp-Source: AHgI3IZC7dO1MVylfNKR1IMUBMRFew0W+Sc5k9zOTm0tCvjkdxJQ5pm89zobCBQPD9hI6gWzXYvYeQ==
X-Received: by 2002:a17:902:ab84:: with SMTP id
 f4mr19837014plr.207.1549595303115; 
 Thu, 07 Feb 2019 19:08:23 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:22 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/7] powerpc/eeh_cache: Bump log level of
 eeh_addr_cache_print()
Date: Fri,  8 Feb 2019 14:07:59 +1100
Message-Id: <20190208030802.10805-4-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
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

To use this function at all #define DEBUG needs to be set in eeh_cache.c.
Considering that printing at pr_debug is probably not all that useful since
it adds the additional hurdle of requiring you to enable the debug print if
dynamic_debug is in use so this patch bumps it to pr_info.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index dba421a577e7..7de278f88e3d 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -114,7 +114,7 @@ static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
 	while (n) {
 		struct pci_io_addr_range *piar;
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
-		pr_debug("PCI: %s addr range %d [%pap-%pap]: %s\n",
+		pr_info("PCI: %s addr range %d [%pap-%pap]: %s\n",
 		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
 		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
 		cnt++;
-- 
2.20.1

