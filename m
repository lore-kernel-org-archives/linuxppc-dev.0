Return-Path: <linuxppc-dev+bounces-22083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF35CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlS96XC9z2xlw;
	Fri, 05 Jun 2026 12:16:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585324;
	cv=none; b=ftPyjgo8Tr+aUy0I6dAZyGDPgKYPPTodPDqq7j1Xi2LTVmPpP2LedgISFzsjm3fNLhLwIwdyg2wWbDhDDSobuTdTiyfrbCMtA5xErz7JfKGOUzVHKtwdtC9SVO9NZBsVJe158lm3yKx/T0jKEXrJPQ8oJ8Kmod8z5s2bEygCHpZxvswtTh8KuhiXSPi3XAz7gglAjaasD6dZ9/RE5yuwZ/LXKRrHgPC7VhZHtRLOKe1RhLu/GIy0wfdqASnoNhqgENDWuu/pIsrFeBbLaq3vSxOB7cmwmjUdRnW+saXpF34FBciYj5mJKNZtAl01iuO7FYRbCbWw2R5VW4d4YBoSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585324; c=relaxed/relaxed;
	bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+WC0bfTGJti9Zp5iHMVslj2/POWLXufCQZ233j67pNiJ48hRimcSR+AU+HEq3sJ+jgf3QRQ99EzmN5fdIrb7weRaA6ABo8vYooXW8q7hrgXLUSsVZcPfeqABw+cOgzXoB8jtASx8gUgs2pjk4spR8RDxdFHPfxAp7hP16ww0Z2TEYjuauOzQO4TsUHaMVcvc/lw5TcX4a3ZpzITRWXzlfrm7GGWxVaEawupXuRNsscY2A5qdjsSO8UNXQuPzu6r/p9Y13oTP3A4k9MXv/+1V0ade+1bZZa9aUr5jFt0pFmrXylrMBi0Rr2BJyEodVhQdeZDuGBaXDcwbG9415LY9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2m5Q4Le; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2m5Q4Le;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTR3YXVz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:03 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84275887a3fso1160427b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585321; x=1781190121; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=H2m5Q4Le7tvCOfGgRvIrBRjFgJPVfV50d3S+TOhue1gFGP4GWsX53NbvJOAurpwoYh
         x92gVHuM9YDhvsafF9pgWOxuqcahQWU4p4LHuMpJtE7MYV6wImXDsbCVLFeKbvWzVTKC
         ird0oNMmxTUCrs0nC6axhPJ/Xj3wb4EL1KJMRdaxFk41pmPHJW1+ecE82fgu+be51/1s
         d2kWp8vse9SW3eYGpbjvDJlux0WP+gQOYntegukRSeIuzZ2YwgfVlB01FhG+TkeGeXZp
         CE04UjFVdPnZsZdVf9QktHZtll1LHEH4uW52Yg/YBU7aT54maimtl+l2roSyXGTflJS4
         T1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585321; x=1781190121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=i0BAeRkAnpMM3fwzW1sIGMe+7Yr6X/2DjC7yE1PSA/KPwIiuGS12zZiheiY4iwUabz
         hhKD4yl28mtP132X/ZqEVw7D+mcZvOKkYKQ5d7n3c8xXYju44z54bMkdXGfFa3FAwtHh
         6nclMyLYGWrVPLuf/AdvFyN5PaggMIsfRJ/GshyqyqXR6l6kADB99g3L/kZ/aUf3fjQl
         CQElLeTfdLrgjBHO8hfItsn00oRhohBuGx67jRTdN69ZHFchc1COINGYxcxZGBkYJVs8
         oAcB/G3rrwqFQxZXcvwu4cjA8+yUPwdmuaEe1kXVPySCFP8gviqJS1piiwix6VSAvVtz
         SCNw==
X-Forwarded-Encrypted: i=1; AFNElJ+trK5X9wetCAzCVKlxyhAYp6jeDybnsOwm0CGUoc59lqBK98aRsPX1ChT+ISvJZxoLMmknYu9DEAN2Wc4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyF1+iE5lxiYU1b6fyATkACmIHjNkcSqmM/RcyYKVsPZBl5Oelh
	JD8zjrw2sghUL/xZoc8u134p0Gt0/W09vrPH+mvpE94CpOQSOPczb3KQ
X-Gm-Gg: Acq92OGJVlm+3bh5y1Wzc8AGQRorITnrwXWFRpmco0JhcHddb7z/wc98AtLCzAwUZaG
	I2MSv16Mgr0foHws4XOO94oaIuTGJchWim195Nddi8FwK0gR4isMLVu0jYOnlbrQBXEJWWnF7zW
	36mJRASqY2X5aSPvHrgAZhpHl9R7ZYBHBCkhonVT5y3d0PfHuQHLY6u57Kp+N38WNypcP6KNngU
	sWWgT0Al1MqkgcAavkuKGBXRe5eeq4UvzxamfpLpFg8hPxEXrFKTly5QRcSFHhc/zGt1uRvwp0v
	zLTr2EZ5zw0wGgOKliUrJIpIThdsV21jaIp676542W+M9rxGY8HalQ6CE/mc0C3I61/yOBvjU6j
	bTZM+IlMXkLWkz5n/+U/NipO67BpDNvcorPuJdJoKH5ysRAL3d458EDoqyhYwIi2G28J0AoqTL5
	3Du7efbfwzoe6sfK1+ZzvCbmRe5VPsw7cQvzWqDQ==
X-Received: by 2002:a05:6a00:6c8d:b0:842:47f7:5f1 with SMTP id d2e1a72fcca58-8429b73c68cmr3210028b3a.28.1780585319505;
        Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm6223764b3a.33.2026.06.04.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
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
Subject: [RFC 03/12] PCI: Convert pci.h to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:44 -0700
Message-ID: <20260604150153.3619662-4-dimitri.daskalakis1@gmail.com>
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
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..73b913bcb87a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -954,7 +954,7 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->vf_rebar_cap;
-- 
2.52.0


