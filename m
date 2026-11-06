Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D27606A339
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0CINtrF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4j406dz2yLF;
	Fri, 06 Nov 2026 11:43:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::247"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925781;
	cv=none; b=O+BzlEyhKtTHOQZ1tg2omyYzkf/ELONClnxLmMTafKtHSKx3LGVpwjyhAzLyTMso23DdeLvtPffv/rqwUD8snkkxAm2C0gPpnUU/sbccN3N1MPumEOQr5Dp9ZEumT5xLsbd4Co+OcueQ79BKf6BH7DunP7tYK8+HnWBRlpvSI1WEh6JegJutL05TOn7Ppk0w9N99GRvsOIfgPs0m+kq6WuJbA4TJe0gg2S/EtP8/FogYiA67dFtmMvc9zqCjT9WxJ9+Ydm+7NrqXp196m/dyOXBCWbvINtmL15Ykxbi3bsUIvt9SBX0Z5UXqltahQSuyNtasLsXgNrEgKjv4SDe3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925781; c=relaxed/relaxed;
	bh=BPfp4nLyt9FVdmFE1yKT2sRgCODHAPIFVB7rkcjEfkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWuPePRcUCflb7ci1to9pJQDlhItsEsMQbdOo+okvTDFxq7x5s3O2kBhRVQ8JndOUWHSLt9Naxdefi3P+K95Kj/ugvGOGG3u+Qa10eZBRmAoKLzI0/fOXkcP4vcDA1w0rP2V0Py6ezzWWS2BCio5D1aYPKDUM+BxyvlzAFJiyZjkpT5b1Yv/kRGsO7mytQ3SLtXgmGxkmxBdgCgorQT+r22aYaDbSiMZBNEVVP9FU2mm66T7nIWR0tNiUFzDm0Y6WCgo5TLpmRsiNmny42F+a5lzNlLD6qhO96faJthXzIRRiiDQcrrjBXTT5VnPpEzT6apT5DYZoQqcQXsy9f4KXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0CINtrF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::247; helo=mail-oi1-x247.google.com; envelope-from=3ksltaggkdognwkdvkmuqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0CINtrF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::247; helo=mail-oi1-x247.google.com; envelope-from=3ksltaggkdognwkdvkmuqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x247.google.com (mail-oi1-x247.google.com [IPv6:2607:f8b0:4864:20::247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4h2pHkz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:00 +1100 (AEDT)
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4cc89e86e4dso86644b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925778; x=1794530578; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPfp4nLyt9FVdmFE1yKT2sRgCODHAPIFVB7rkcjEfkI=;
        b=X0CINtrFaYri62WuMRDmFsOC8lGtuqsqayBLUQoxgiFwQ5nLu9B/Z8e70S595oQ0WD
         439WBBBraRh/VWMA9nmkMSmcP6a7oX9ko8VqKUpjYnLpN0nfFUCPhR4XthNzoX186oG1
         PbdchROFzTxUAfKkwlSeG4Ug/FPub1upPhzHro30bjrQd19I/exv1jOQbbylRyXEUpqs
         kv05byN1gc9XuOYXhSNzhRFbEJmF6E7rRE6AbC1cpnI3EMt2GpwGKz5920MaG30zEKIg
         RsVRWAHRt4r64oloTgWgexIp5yE/1XJF8ruanu5SDaAxqw7xuExcTmEUoPyV2ckUExUw
         yExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925778; x=1794530578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPfp4nLyt9FVdmFE1yKT2sRgCODHAPIFVB7rkcjEfkI=;
        b=W0oqJy2d+yt1iPTaT3T2nkZtzVQsAhsLQndiLwphCuprARgAvYk8fj+0H4clwhBaIM
         s63UvzCknjiplUc04e60l3KEV1n8kb1xlj0MrvJi/EpI9ptkpMEJ9NrPpKzJZOyW01KL
         v4PAYVEY2bLKGbDHQGLxdFPDKiwOaByrBSUt0jtcOODqlUpiwDG/qX/Kbnjqmtl/UxKH
         mlhvXmmCZ/W5oqtbkIVfbeFc3Rxg237OiguhuDgCVibB4h1mk2tYa10VJ1Bbx9v6SLdp
         vwW5Z8tUT1yTkTPbX5Y3oYHfdTmI9vRPGlgy64Ch4OCB52e7kGX3+sBS0RIpczKPRsPM
         JnuA==
X-Forwarded-Encrypted: i=1; AKwUvBwYqgaaxzRopvI9VQfoTAbJjFX3eJR82XKpDV5K5/HOUOmEgCVxH6Rh0v7INyTx6EzK3rqHrKf7isnYAS8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8aulAaHMgykxkYkOLndIa84nejudPGr3HOQ/q+ODjpHLUQMX5A
	nb6bu2Pyi+GygAXGdiO+z7lNf2QVRQEZyJzUEqPCAFNA5gSN4A1EEovO3W2bC4/Syy0rBS5C2E+
	lJ5eM90m0cInVeg==
X-Received: from jahl14-n2.prod.google.com ([2002:a05:6638:8c0e:20b0:620:17bd:8c69])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2216:b0:4d6:9355:7547 with SMTP id 5614622812f47-567e1840a0cmr681897b6e.66.1793925777406;
 Thu, 05 Nov 2026 16:42:57 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:02 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-2-dmatlack@google.com>
Subject: [PATCH v2 01/17] PCI/DPC: Allocate the DPC save buffer during device setup
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_TEMPERROR,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allocate the DPC capability's save buffer in pci_dpc_init() rather than
in dpc_probe(), and report an allocation failure, which dpc_probe()
ignored.

dpc_probe() runs when the portdrv DPC service binds to a port, which is
long after the device has been added, and does not happen at all if the
service is not enabled. Until then pci_save_dpc_state() silently saves
nothing, so a reset in that window loses the DPC Control register.

Allocating during device setup makes buffer existence depend only on the
capability being present, which is what the save and restore paths
already assume. It also puts every capability save buffer in one phase
of a device's life, which a later patch relies on.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..b7f79266f66d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -408,6 +408,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
+	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
+		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
@@ -499,7 +502,6 @@ static int dpc_probe(struct pcie_device *dev)
 		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), pdev->dpc_rp_log_size,
 		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 
-	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
 	return status;
 }
 
-- 
2.56.0.455.g6c5a503b38-goog


