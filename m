Return-Path: <linuxppc-dev+bounces-22085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD32CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSW1P92z3bp7;
	Fri, 05 Jun 2026 12:17:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585326;
	cv=none; b=oYkUxPyWrED5sh1W0WxQbvxJCltiBEkDUYYVzWbm4S/3Veg+2axIXGxX7okgL6e996iYOsZh9E4BM/lcV1wkRGMWozPRq+XJfMyKaniNfBd/nbmereAEPbbKJuj1cywpDln1sU6qyifQak97MqyoKZQDqNXM2sAk1fVQTEubs/pi6lOcgE/rcod1nKg/jTAxUPEIk5zLQ/U3BcYBtwhW6IGE0onKbOwllGb2gtNc2iZ6HjYqRVMRnLLHQgHpFNUHX3wCCzZqz/0BmpBivT/0Uf2oObGEXSA0C/TJzuxhCvuGZi1Ewy+yx4dWqPSa7XtJUPECkBiwcI0SAOvoC1z0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585326; c=relaxed/relaxed;
	bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe5ws+CMGyv9d1VetV3SqE3akKSZ17kV/FowgifEdJ7y5IT02CfjMT9eh431er57PsVM0+9umMmVJwz07EZOhsubyZzuYhJisHJohMwtSr4PIGqpaOLeupOGrFK46VWwPWOv8a2o+AX8ZXzXcMBw/KfM9HicEIrVkcuJ9W41QJMuBbex3f5CPtVDLXRs712zc0d9mVVIckfVIpjAtw6lRNmTt2GMzaPk5QmSVGWx9gCrDa7jN6h1KABfvjw5+rB8AyRPLNmzEC2ISgv4RjYiHaInfisJwLbdPYh9AOOhh1Zf1egdPSzCjz+96VUDd3gMKn+mWijjHUz3Lwh5jRT0QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WkRIR0Jl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WkRIR0Jl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTT0dXNz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:05 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso6076525ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585323; x=1781190123; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=WkRIR0JlraEp6dJYRGmFnpTLroj4le1pmxccJb4AFLerVz4S4eTSgwl2XExfs/z1dg
         lK3anSx0ybmpznL0twb2XOMAOBRn2HuzA6DXMEmJebsJQC31uMSq9H58d9lgIpILvaoR
         c8FE9EmdBGK/yPIrbHouBcNgdAI3Nu9js2dwUAzpn6Jyl1BIclVuvBuZmyjjr/P9DCry
         aAHT1vJswwu+Y7zvQjnPZOo2Nf7GDp3qL+ebbhZpqlJ6e8t9ic0UeH9x6pCCY3m0JEg/
         EkS9TOdlZbT9H6Ej0A7wZwrf+WK7zz0+ZCUjyv8bsokhNX5slIWjVnM2wliI/IW1VpTl
         uWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585323; x=1781190123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=nNqz3qRGqcYCM5XBH+drJpqaQalmlNGfg3wnEbuHFzAukOpDQ+sV0ZIA5onA/D5ikV
         EuawYQ2THgIIKW+IP9Kh3ll6dlrUdffZRS9QtiNVSeb5CukBIEiNA5753qxKhlCDP7SP
         KP8Cbj/8dfiUy6HkkoOMVCcaxMn/gp07dilPnPl3ymbYqQ4We25L1OxXY921HRQ2SXEH
         lXQNFCfkM8ENsfuZTKNBLmhHETG5xJI36tRuXYg6HTaSLkK6EGqPzteCWyrLh6UIL89w
         WcgFksKB1GfDSdW8A4E/MHYF7fUflyUtD1BNogPTvbhnEvtDWkfaXsJ7Bw0fOKh3J0Eh
         ez9w==
X-Forwarded-Encrypted: i=1; AFNElJ85Y6k//2OYZ5Q06a/s2EkVBcfUavf6xlRn51dQ4V2Y7Heb868PBJbknWKKvlSJnQVfb8M+9uDQt8KNO60=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJNpV15dzamyXfVO6nXDWtY9IQsLFbbbvlpPrbac/QkGzyz7y+
	DBWkbArHfVpXAk06Ik4rZ2C5TeW9rDu5itnupYpwVrIcuE5xva+MnJhp
X-Gm-Gg: Acq92OGLW1bWltCpHTYLvZEc8KF0ByD7p9DbTzJGLPWPA6MxXMzJfqj4xhVW97hcLtf
	rj39MfaZszOvgtm0pk2KWttQ5H4nRKN68e7JGQA3BXPu4b8uHeM1yMry7DgHv3fAC6kf/iGBpDi
	BHkomCcmehOqZbNWAzRS0HHRLs7X8SWPmSJ0i680oIQ0cwiN3MJe71pVpVi9PHRnEyqQSOh8DJB
	d22TBX2hRILQXBTjWdedgT5C9F/KmrLT4Hv9eG2H57+gRd2qqxIGulW2TDuX7CeNCoSGounmykF
	J/LpMNotJcnYEx5vTYYb1xMWvuyrYnrr+TEFHK3GCzvWTRAWtLx6ncOqvgK30qFimgsFZAEZUO8
	Q5mnZyj7mq6akYqvXtA0Zm/K0OPrnVDpMgUELgApckFuF0uxoG8n8Bwgww+dtbWB7GzMggLwm1J
	zB8T2IBOpT541Lg8lPkJhyqw+o7mm6YnQg6qW/aow=
X-Received: by 2002:a17:902:be03:b0:2bf:13b0:f8ed with SMTP id d9443c01a7336-2c163a28b4dmr55201165ad.3.1780585322733;
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm64224585ad.82.2026.06.04.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 05/12] PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:46 -0700
Message-ID: <20260604150153.3619662-6-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/s390/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..5e6f600bf60b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -611,7 +611,7 @@ int pcibios_device_add(struct pci_dev *pdev)
 
 	/* The pdev has a reference to the zdev via its bus */
 	zpci_zdev_get(zdev);
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		pdev->no_vf_scan = 1;
 
 	zpci_map_resources(pdev);
-- 
2.52.0


