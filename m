Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36677C2D0F4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 03:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FE320738
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 03:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNfudXPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FE320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wbGD5vQTzDqjp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hNfudXPj; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wb8350lRzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 13:08:03 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id w3so5355080plz.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2020 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9s8Dd4k0iLEu+uLz6i4AaFtNRdR5AG14qmCBn0sIFyM=;
 b=hNfudXPjganUktUgOd+dWGSBbqG3OjXzQVEv2jXaTsTm/KAi+A51UhgADglKNrsE0M
 QIkKkrdOAewMY2rYcaGUM5hPTj5WxauSh1a+HqorBkEvrD8Kpv/ca0gqXzR8mBLtos0a
 5uZUobTNJmF6LOsaHIeQ5q+WeZfwxAVxuw6T4nCRlEN0Nla58AKm/y5mmnVKxxESXwUl
 YIB/e6hs0JLWMgKCvuo0U6nIoGvHbFTWqeoB+Nu3i//OhQJzrrOfQpNNQFuuGajg67+O
 NocdVZZkMRCunkVxmCHiujJW5ZLCJUnaiYLFGdCvgcT2jjGquq04zAcPaNCh96d2c0v1
 Hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9s8Dd4k0iLEu+uLz6i4AaFtNRdR5AG14qmCBn0sIFyM=;
 b=nN+BYGwgc0fdHdu7l7SWSQoKWvBjg1ERfFZnEJ9bxenctpc8cwjvaqmdDWK8gL0Dh4
 93jJiGBzqoCPPfueO7f/rNECNaj0zaDATbtt+7e8ohCWwpEiq3tF0pPmyR+CNbxUp2gG
 /FsgknJJdMMUex0kdKnpyquBF7T54CWoNriptUiHrnWS75eyuoe/baHX1tFQqlSlV6FA
 fryaF8HlLvI6x1Zry/kdS05QVzC6d7k/JDJ/hrXejkdfUk0jJK8n7LkAtGgyqp9+JH3E
 ZB6frzYaVVKpWoHwolgwWbvgGNEPaT6dcIpVvy4RY8WPXzsWkqb6T3bolujl8vgwwUsS
 tx7Q==
X-Gm-Message-State: AGi0Pubg/PH30wld217u5BbccGR1HEzYg5HlI/6aGmIlYJfVqlPddV3/
 Yvy2xT+TEQ9oduA4is9ENUrmynef
X-Google-Smtp-Source: APiQypIEgdwQ70GMS2UgD4fBUAhHSaQQ8VRjFyf7CTDnKU2xJL36W8apVVL/ZV9iNFPOR6iEMJlTRg==
X-Received: by 2002:a17:90b:490b:: with SMTP id
 kr11mr24148303pjb.21.1586142481499; 
 Sun, 05 Apr 2020 20:08:01 -0700 (PDT)
Received: from localhost.ibm.com ([220.240.58.168])
 by smtp.gmail.com with ESMTPSA id e187sm10196443pfe.143.2020.04.05.20.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2020 20:08:01 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/7] powerpc/powernv/iov: Don't add VFs to iommu group during
 PE config
Date: Mon,  6 Apr 2020 13:07:40 +1000
Message-Id: <20200406030745.24595-3-oohall@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406030745.24595-1-oohall@gmail.com>
References: <20200406030745.24595-1-oohall@gmail.com>
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
Cc: aik@ozlabs.ru, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In pnv_ioda_setup_vf_PE() we register an iommu group for the VF PE
then call pnv_ioda_setup_bus_iommu_group() to add devices to that group.
However, this function is called before the VFs are scanned so there's
no devices to add.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57d3a6af1d52..2c340504fa77 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1622,7 +1622,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 #ifdef CONFIG_IOMMU_API
 		iommu_register_group(&pe->table_group,
 				pe->phb->hose->global_number, pe->pe_number);
-		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
 #endif
 	}
 }
-- 
2.21.1

