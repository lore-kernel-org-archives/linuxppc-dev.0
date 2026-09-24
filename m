Return-Path: <linuxppc-dev+bounces-28133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1310DC98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZg6MxZz3bf4;
	Fri, 25 Sep 2026 03:35:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271323;
	cv=none; b=DdTfkjLlti5tLK8n76ONJ5khWPmC4wRRbm/pLhmhxcIk7L6WlwPS5MBZjbnY28p7z0c80aA/YRIHwzKvxeEP0Yuu9ZJSnCccHFdPNfP+9Gt3H3xPZRNJ8FgHIpTASnQ3k7JvbsgEzZAvrexOEP8yENc1WgCYCKjet+mhRoSD/zYJxHMi2xmFiq5ETye0Day6UvoCC4OcEWCEjpozW/WHy5TeZtK5uSwpXFGagM69EnqWpbMjGWu8GCafgT2O6cA41QSj6vi202OKEmfvDTjofQWdcZhqcflE5yfTdteYoaJ+a/cOREwjs15ZFzJj7Z+TpOMjrRG9QOjZmad44J3TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271323; c=relaxed/relaxed;
	bh=44zkx5wXiPoFVTiEc5KY1Ag9ipCGGabDIfpXco19T3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RXW+GYAGt2M1S+IU4WULWqSaaX0kdkVl7JEQP6oEa5kwCLqf36FxBYwQYa1MR4zfc4TXbBDQKj2AdhXHJr98tg+YJWBkAR6B1hsfa/uxGpMP0vxQa0rg25Gt5sFspPFledRiSLDvthk2S66IO22sAxIZSxz/Yp/d4A6yS0jXXpiesdgciSVj6sJI+hHX0HZl7dn9WtTuFKM/AyQTRY3My8+xhTmUH5L0msmCUVGNvTmHPz6+76+BFt7ON7EZaJV3vOfrdRYSKN2Knnna8FJMMbTtcxEL7jFRSU+kmbPU0EUxH5ym0buLx8E2JGq6easrrpMfJwMs8V9/H3iSjZONVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cDxrdhNB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3uf-1aggkdeegpdwodfnjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cDxrdhNB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3uf-1aggkdeegpdwodfnjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZW4VlTz30W5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:15 +1000 (AEST)
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so7687a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271313; x=1790876113; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44zkx5wXiPoFVTiEc5KY1Ag9ipCGGabDIfpXco19T3Q=;
        b=cDxrdhNBH5bLqk4de7M3C7woa5sKh6f8hDbs4Rt9uINO2780h2A9y55J5r+uCCd2uX
         VfN3vHOLj6kEeUeL8ptzmnDNEkAP8ALgCLN71qP4AX333BZeBN4q1uU852iJNKGSfcBu
         fCBjcKvPCOs7Hdb1pf/zPoQZf+e178gJfyRpmxu6T55JrBwniqo7VkHjb5lIhnmBlepX
         LT+7A7z7CT1pB1FOmyPf2wkFj3V76ewLxbDCwNv6X9OhVSsmaRU+x8rcOLBP7BmuZaad
         ZQ3V0+eMFNsEgnCYl+2wMmjhs8OPIQgLal46AU+wXxNjjMSU4L/RCqL3v3L8Y6LbsIPc
         DGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271313; x=1790876113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44zkx5wXiPoFVTiEc5KY1Ag9ipCGGabDIfpXco19T3Q=;
        b=jCzk9hTbee0XNR63+11ejFjl4fKqlhgUpFIB+49LEQdLQOndENOkjl1QeeT9kwQBk8
         g4FoK8+9sp/3yOFIae8QdpONad5msEuIieoA5q2uXwOoZFBGGwm7T21cuB34iu6RHsZS
         ttC7ZrNin2Pb9ccRS8pv8jcemwVyI+kqfaOaSJ7OAgFXEoXEwVFfqdiJGjZwM9mumFmP
         I0AS2hXQgw1gn5cYyCG+WoJ5YW/e5JrIWTV6w09swMv0S5w3JRvldCwh3aa6UwA2Vxcs
         5RHTaCqxUQiBY3IsjBKuEChFJnB/fUX9nU9RPfOBBlPU4fLLH26gayLD5TI1//IUHVcY
         zkSw==
X-Forwarded-Encrypted: i=1; AKwUvBxE/HKC/nE8MfZ5VzbzcZDhH7xH1sKtraie5hA4sMhK4++hLOOiW9PpuLEJzfO4qyTZbIaT7S4lf0X7bvE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lAIT8EtHC3aiI0P88MHi0zUsn0ZKiPBUdFzaUioRWD4GEXmlbe
	nqcaeptXvvegXlP06UEDcPwIW/mFs8zzcfL0s5Cv3KiLxPlXNSNhtaYRky4XY0rmsZ4E3hgpvP/
	LzOp1IUDlgo81Yw==
X-Received: from pgbfq21.prod.google.com ([2002:a05:6a02:2995:b0:c88:e5cb:265])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d09:b0:3dd:a196:906f with SMTP id adf61e73a8af0-3de0e942ae3mr2935846637.57.1790271312798;
 Thu, 24 Sep 2026 10:35:12 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:52 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
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
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-7-dmatlack@google.com>
Subject: [PATCH 06/15] PCI/ASPM: Save LTR state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore the LTR maximum latency registers through the per-device
saved capability store instead of a private pci_cap_saved_state buffer.

Reserve the DWORD by its configuration space offset during device setup,
and keep accessing the registers a DWORD at a time because some devices
only support DWORD access to them.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       | 12 ++++++++----
 drivers/pci/pcie/aspm.c | 19 +++----------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e49806c6891..e53bca1cb50f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3580,10 +3580,14 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 			pci_err(dev, "unable to reserve PCI-X save state\n");
 	}
 
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
-					    2 * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (pos) {
+		unsigned int off = pos + PCI_LTR_MAX_SNOOP_LAT;
+
+		error = pci_reserve_saved_cap(dev, off, sizeof(u32));
+		if (error)
+			pci_err(dev, "unable to reserve LTR save state\n");
+	}
 
 	pci_allocate_vc_save_buffers(dev);
 }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 02922b887ec6..16f22af98686 100644
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
@@ -40,31 +38,20 @@ void pci_save_ltr_state(struct pci_dev *dev)
 	if (!ltr)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
-		return;
-	}
-
 	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
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
2.56.0.rc1.315.gc6ed9934b7-goog


