Return-Path: <SRS0=g/Eh=73=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1351C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 06:17:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6AC2065C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 06:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C8QrbHkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6AC2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49l45H094FzDqSP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 16:17:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--gthelen.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com;
 envelope-from=3jlvlxgckdjc7k85c5e7ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--gthelen.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=C8QrbHkB; dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49l3ZK226dzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2020 15:54:25 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id s7so11943873ybg.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2020 22:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=otdX70bz2YIi8N5w4rKF0s6D9LcxXuBVYPPx+zpGPno=;
 b=C8QrbHkBy6a8AJ+AlBLdblPvmdd6cdbCl6/dXQfGJBCYmaEhOfoq7YrkgeeRZzz/c8
 RanA2Ail3Hwu8/xw12exkyofWZybBZI9IBEcc9OJM8x67lWkxsMYIEx/NsHtRfqCbe8j
 mlZtT2r/ia2x+6XAFmXE4OGEZG+aghV4NauThpFTlUr3pOwOkA5aYdJtyLJLNKYC+eZq
 EotCsfpaXiICE1er5NL/Uyl96va0v1l4hZK2lctTHA770c6f9Sywa08+FtagatAM42A+
 /wsgK2ZdhfEOdP2F2EHF4JGGm+viPoI8fZtQsj1ACsBfRjLukp7J3xXZWau5ZQK6Mu5Y
 TQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=otdX70bz2YIi8N5w4rKF0s6D9LcxXuBVYPPx+zpGPno=;
 b=W3ZSzUtI/YtEgVoflNqkAoB9wXVs7gtoZucq6mU9yyr06BHTFDNReWTDAnzy1FsK9A
 ts5ftXYHJU+2PS0mvh8ngpqBQP8/NJGv3wav3dJSKJpacl9Vfs5/maLhVLdDPotHvaZn
 BVz88jjyatQv4GkSH3DLHurxgmjiuQW2TFjGQ9/mpneuycCTzsb3G2+eKUEDiXJgHmWB
 HEuUNWi3fUUTqAxwVRJkuyXQQ+byNQTOCVedL6TlclsoHhsAWf1RasvvQxuG9Por0sSe
 Hb+tkxCFRI7QdRWs0emsVX+ALTVRoty3XJf65cHD1uL1a4XlE30wgkFKnKDIYyBr5Yq0
 /7cA==
X-Gm-Message-State: AOAM531LQ9uDvRQfP+iU26n8XecRUBXhteBIOcDR/WAjSbxW0O0kfrO3
 ZpnR/CJWSxysMEvOOKJzkSIzywlIjRGH
X-Google-Smtp-Source: ABdhPJyOLly4XuglNWi7b9HgglmYKgBk4jq2k9V8yBsUa6I6YUUAZG3V5TvZRcuw2m2Nk5Xg7lRSUPIuzeuD
X-Received: by 2002:a5b:942:: with SMTP id x2mr27173587ybq.273.1592114060922; 
 Sat, 13 Jun 2020 22:54:20 -0700 (PDT)
Date: Sat, 13 Jun 2020 22:54:18 -0700
Message-Id: <20200614055418.33497-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] powerpc/powernv/pci: add ifdef to avoid dead code
From: Greg Thelen <gthelen@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 14 Jun 2020 16:16:08 +1000
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
Cc: Greg Thelen <gthelen@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
CONFIG_IOMMU_API see:
  arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used

Add CONFIG_IOMMU_API ifdef guard to avoid dead code.

Fixes: dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE configuration")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 73a63efcf855..f7762052b7c4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1885,6 +1885,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 	return false;
 }
 
+#ifdef CONFIG_IOMMU_API
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1897,6 +1898,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
+#endif
 
 static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
 						     bool real_mode)
-- 
2.27.0.290.gba653c62da-goog

