Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CBAC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:33:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCCF2168B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1V5FgEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCCF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N3GB1mp1zDqSP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 20:33:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1V5FgEY"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N2tX4gj7zDqbq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 20:16:52 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id 4so5327098pgm.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y7C6JfbNI98IT1HOqcQ3/lBqSY4/fd5mwjwu2f2DSV8=;
 b=N1V5FgEYxxcfuEz2v10ENIG3ArkH/viK5MPZ612sdcPW3dKQEyKPatwl3xK0MVjZAF
 ORkwFhh8rDI3Bw+DDkDI1aT3KauYqdoIPoN7wIHfM6mykl+48OjWfIAyElsHX9qnGdLV
 8r8lNyGalOAREpp/urws69XqAyO9aRCn1fTme+xmA7xeTvJnoWPiExtEDp1bP7SjJhvs
 VUhLkgCAm6VYk2YdIQGn2ls2GlLzRUij5ozQznFhA685/hdABv0dWDZxMY8Qr21MoiPS
 t75NkV+mxhTZlR9qwkm6JsjU2VGwJr93YOMxptbGTnikS/v3UlL0SdxfKitHp1kXrGWl
 qmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y7C6JfbNI98IT1HOqcQ3/lBqSY4/fd5mwjwu2f2DSV8=;
 b=EjAQYOEXA06vybMjZs7pcMwWaf0GcJO9uqSXUqhhxXY7QRpEnfapyXLJfNyiwlNMIR
 b0zco+CK0Vj00WQYAC88KEZFPvxmeLI734PhcY3KwPKsxa4V3JFd0tPQsxu12Y/cZUGF
 qvKC+Z94M78enAMbacuCX0YWDvSZNWGqoGhVzfLwcTSdmwza/9btPBum8//WeH2LDfpO
 TH6CjE5Z424Qro6lQYeWcVlNyM+GzYBbIYXSXQxzDsGRPdr+unk0N/UyQuqvQ3oob+io
 di+OYsm2KSlb+UxBTsKSOgZat/vtMpiVdcJQQiVmZopoRlLPrN8d6wHCDCx288gMbfv7
 3Z6Q==
X-Gm-Message-State: APjAAAX1o/bKlezMSrau+13NbBLBKenNCsfwaoL9sjrQ419WuPpdGp26
 PySDPJzYc4kJ31WCuIYwCFIqbBta
X-Google-Smtp-Source: APXvYqyfPzXvEo2efS0uUikB46o/s+4rhqsJeHtYyEGFOeWYPYlw+QptsIGwUptfqDlCbj1fsR15Rg==
X-Received: by 2002:a62:ac0e:: with SMTP id v14mr9006985pfe.14.1567505810284; 
 Tue, 03 Sep 2019 03:16:50 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e24sm19676701pgk.21.2019.09.03.03.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:16:49 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/14] powerpc/eeh: Remove stale CAPI comment
Date: Tue,  3 Sep 2019 20:15:57 +1000
Message-Id: <20190903101605.2890-7-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903101605.2890-1-oohall@gmail.com>
References: <20190903101605.2890-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Support for switching CAPI cards into and out of CAPI mode was removed a
while ago. Drop the comment since it's no longer relevant.

Cc: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e7b867912f24..94e26d56ecd2 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1125,13 +1125,6 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		return -EIO;
 	}
 
-	/*
-	 * If dealing with the root bus (or the bus underneath the
-	 * root port), we reset the bus underneath the root port.
-	 *
-	 * The cxl driver depends on this behaviour for bi-modal card
-	 * switching.
-	 */
 	if (pci_is_root_bus(bus) ||
 	    pci_is_root_bus(bus->parent))
 		return pnv_eeh_root_reset(hose, option);
-- 
2.21.0

