Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A1606D80C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW7vbwMs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4r5cRKz30HB;
	Fri, 06 Nov 2026 11:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::245"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925788;
	cv=none; b=J0IddSxtcjA+UX9uFcLzvHEmmO3IhjtqhmgcZubh4wfmxNM3QwYyMomfiIxNOOUu2C2/wa0qHRCNVXNO45h80ydrZDB88ss6KeWH65mvr9zJUYzUBlWRaNeoEdW+nxxCFIVKrl0u92CRaiBAfr9LuAYQ8eARJRBkmP8U4ptH9iELHSYCPG/c3JRY1rIG8RI+aI1YDssLddC3PIacGIkEhdo1Qh+cLVkxytnq4ke3HkAyd4Hj9OgdFxGHS5yzzn49Rz7YFL3ZAFfMusBo26rGeGXH+zW2xuKS/AKEesU+jNwl0X9s/dcyM/V4MIV7mvmIbB2hk3gfQpJSog1U8iCVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925788; c=relaxed/relaxed;
	bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vck68atcX5lzunFTmBs/WQHsvXfif3IBt3ssX+5KagNZNdcYvh69tE/fG4iQ4SWNXjPWZ7Cfa8ffgSdpHdNjkMUHG8V/M9q0tQWA8HyDHZAB6JGw+qFG6CDxFNuO0xD9i1uIjs+OLoEDw2mo0CBWIw79QU8lvG+L661v/SovUxNQvcdNRRSPaanPEZtkPl5rcrqIQ8wMlb/usJFo5oZK+MlCWIWDO+iMISdiBg91fKZkpg/Yby8bgEFTIx1hYoqCE64LhWzsdm4RXP+iHTESC2ITenHqKaf8XnN02K63eIYjqXLerEO8DL1Hs0UIRFRY675GJhM1n87j7Dw0tmLKmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW7vbwMs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::245; helo=mail-oi1-x245.google.com; envelope-from=3lyltaggkdo4tcqjbqsaweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW7vbwMs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::245; helo=mail-oi1-x245.google.com; envelope-from=3lyltaggkdo4tcqjbqsaweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x245.google.com (mail-oi1-x245.google.com [IPv6:2607:f8b0:4864:20::245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4p6TgHz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:06 +1100 (AEDT)
Received: by mail-oi1-x245.google.com with SMTP id 5614622812f47-5384e381fbbso55505b6e.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925784; x=1794530584; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=;
        b=WW7vbwMs0gbGK9jPO4w88EElZcLB457LWHJgrEyhCT6zB/RFrwPQFUJdMDhYtzQxU5
         eN2AVvA1eqC/qnbR9f2VDRO73M4cKWbAelqJDYMvvyz1RVF7n5inYa8TrQaN0nm6w3gB
         vetx4E+8eMIsrdnf0OGBBolSu8ZLhBNY8AmgDnRw6pxtnFDVe3TwYHjE0GgNjpeauJAm
         TizCWDt4XAjgIk3KZzvmUqoP773AbZiUPwWrJ/YlQXm7oOtjQCOfN7ObPxw7j+eYHbXt
         wRDt8VZrv1USsoNXBJNCxCX8Wy8RTzqZKXO7CoIKfYWzktO2TflkFD11uY2NWdTqejdi
         GjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925784; x=1794530584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqwfwAiEqbASiUZ5fLcpwdF4bH2r5Wh+f0RbnIc3OoY=;
        b=jjG5bmU5Tvk987v4I/L8OK3fM52y6hSXHqjKqIO/xj5sdp0AMndF4EweFk5l/PGVay
         r6TDU389W4VDaX4bQRqwZiuEiPFNEmtUJJBhIOgOjCIODrSAtH/thG3iwUhPaJ72B7Pq
         yYjcbEpXXWE4c+mat02/8uGezdv+VdqSirp97cNOg3Iv/A0He+4B2KQhcw/6zcsZQ3jG
         akPuRvyaQI7FX31jZ6QNFZ60eRK9XVxgAFc3QJQrNJA4GYNsqMc78ZjcVaZwbPBl9Lj8
         yx4GVZdpk67UCSjOtzNnYXzT11AT4WBnvK43DlgQIfFobFuX44CsKzGTiRNelYyHB9rW
         zlNA==
X-Forwarded-Encrypted: i=1; AKwUvBwS98PnGGTxQgTm+XRMuFfat5dcSIQdEw3K6L8LJbQCD/oZHylR4JFp6hPJj2AtpEhkRUX/ffCoSNBuWDw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/O/a6wGyDHPgBjurH7S5nrX1KxJYfICjvqOOGr0KHbz/xt0WZT
	FKu20MxTLCLem9Si1v2goM0ECMBC6ldOg3UWMEBmOS2qQ05asa3/sUPCylcT51xVbEP/V6T54j1
	DzOQSkZIegItiKg==
X-Received: from ilbec12.prod.google.com ([2002:a05:6e02:470c:b0:53b:d168:b69])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2218:b0:50a:7162:87df with SMTP id 5614622812f47-567e098e3f0mr811203b6e.2.1793925783998;
 Thu, 05 Nov 2026 16:43:03 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:07 +0000
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
Message-ID: <20261106004218.604799-7-dmatlack@google.com>
Subject: [PATCH v2 06/17] PCI/ASPM: Save LTR state in the saved capability store
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Save and restore the LTR maximum latency registers through the per-device
saved capability store instead of a private pci_cap_saved_state buffer.

Reserve the DWORD by its configuration space offset during device setup,
in pci_reserve_ltr_state(), and keep accessing the registers a DWORD at
a time because some devices only support DWORD access to them.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       |  8 +-------
 drivers/pci/pci.h       |  1 +
 drivers/pci/pcie/aspm.c | 31 ++++++++++++++++---------------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6cf4a64cb7e6..29d9474db1ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3742,15 +3742,9 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
  */
 void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 {
-	int error;
-
 	pci_reserve_pcie_state(dev);
 	pci_reserve_pcix_state(dev);
-
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
-					    2 * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+	pci_reserve_ltr_state(dev);
 
 	pci_allocate_acs_save_buffer(dev);
 	pci_allocate_vc_save_buffers(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 206e0d04e06e..0daa2439db5e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1151,6 +1151,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
 /* ASPM-related functionality we need even without CONFIG_PCIEASPM */
 void pci_save_ltr_state(struct pci_dev *dev);
+void pci_reserve_ltr_state(struct pci_dev *dev);
 void pci_restore_ltr_state(struct pci_dev *dev);
 void pci_configure_aspm_l1ss(struct pci_dev *dev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 02922b887ec6..39adf2cad331 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -30,8 +30,6 @@
 void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -40,31 +38,34 @@ void pci_save_ltr_state(struct pci_dev *dev)
 	if (!ltr)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+	/* Some broken devices only support dword access to LTR */
+	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
+}
+
+void pci_reserve_ltr_state(struct pci_dev *dev)
+{
+	int ltr, rc;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
 		return;
-	}
 
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+	rc = pci_reserve_saved_cap(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, sizeof(u32));
+	if (rc)
+		pci_err(dev, "unable to reserve LTR save state (%pe)\n",
+			ERR_PTR(rc));
 }
 
 void pci_restore_ltr_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
 	int ltr;
-	u32 *cap;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
+	if (!ltr)
 		return;
 
 	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
+	pci_restore_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
 void pci_configure_aspm_l1ss(struct pci_dev *pdev)
-- 
2.56.0.455.g6c5a503b38-goog


