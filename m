Return-Path: <linuxppc-dev+bounces-27745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A31C982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmfdV6RyWz303F;
	Sat, 19 Sep 2026 03:25:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789752302;
	cv=none; b=Ot1CIONUFQvTaFvAmor1708gUgz9EJUGeJ7rINaq4hy/uUlBxGocE6X/BmpX5Hn1sgvhxSRjyf89DFWG7H3ioVfRqHAiqiBUmoaiwykK4dpJBrW0a5+4YLaeEZmM+MsF/iVMi488bsitFfuRDclRO/DD5j94Oc2ka8tFyAKcDsNjsc1D9+Gz1q2m32xV6b1MmqUby1uoX9M49rwYeREtYdR25xZyjBAmi1ZhPi/o4kbZW9yBxNl0uxndD7pd0pnMoP1nAkjCG+dN1VATblQqvaxuN3zZVY8Z12zRGl+HrKed0eGAW9R9eTmvUo/OQPv11kjMrnmpyDEZfEc2eJiWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789752302; c=relaxed/relaxed;
	bh=Md8swCj0kdnOqQQJ2clN5fwQ45QLSCsFIDbY3twlD8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kjWE8scihYSD8DExOW4vctiAtRSTrArQBIsumCmJmXdgcvfaBikcuot5j0nMgdZKCjUr6bCgh6bzuStbi+DvnX74zhZPOOSV8iD0CYYST2u5NS5l/A6gz5aFCKLWNUGgia8UcOgK/u6Ebv7oEgHqQkvJj2Y+hs4vj7duLTmUhVXAjzrMR2obi9Fxzmqcnf4wwoNgoZFyowrFvFhDFYU5WrLZgertUSui0F9Z80u7C0YRnr8SwVrh5VRDLmowas54eUQL+SZ2agQeMqC5RvicPHTTW/Xjww1tlEcatbHjn32Qv/8KOLjbJMlf1ZFq48dN/PmHZrpOGNp8nUk11omr1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SKmhKyXE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=363otag0kdoqxgznujvxoegtqmuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SKmhKyXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=363otag0kdoqxgznujvxoegtqmuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmfdV15yYz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:25:01 +1000 (AEST)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2d6df0a1e18so17520325ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752300; x=1790357100; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Md8swCj0kdnOqQQJ2clN5fwQ45QLSCsFIDbY3twlD8g=;
        b=SKmhKyXEONjmll6f/7iT8cAGaUvGsM5A0r67FXd0yJ6VhhHuwWLoteNE1RyCTJ/cxi
         oqHDOaWLnRL0CBXVk6/lsn0y1ZVFIidNasjr1Rcn6o/hM8TzdWI9vK+8v3bxUpuetxyF
         hTWkxviMSV9KhnIH3CkLqRrqgY9wA+bB+lKb0v5u8H6xPRgvEaZwgpYcBEqMWCukKaXb
         Q0skz8JviRP9bALTJirlUAdkag2IAvWmd2ioAViSQOUqoJrcYABb2rjpG+ZorSOm57Y0
         UPRFZWRcIRksJkV+S1Zmwt5vmnTqkkKSHAK04bN0/yiZD7YFPnny14G5NhAFdujujThL
         mtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752300; x=1790357100;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Md8swCj0kdnOqQQJ2clN5fwQ45QLSCsFIDbY3twlD8g=;
        b=JLucBmCRTqx1gGAawhftZT/vzrki+V3AB9XRSA77ZeEuKnJtSlq3uUrHf0sLUP3Mrb
         Zm84ohNFsFbVVuyUCwtFAaRkrObppkBYIDvX04ce5kp8mVssh4hmF0/1du8rRhvZCF5V
         2ycboUdvzG0ZddLaPKdQJfXQOJ+j9RF0xITxVZH2hdN2AzNMA0KHu0abt9CoUdd0ExJx
         5wXl1v12oLvIOUbIAiCXzphVdo1EGu+CoYgYGBmLj9mPxcCoGXECDq6W8K78XLuBycHD
         /cAcjtGjTVa/XYL1dCUEnqFkG1oZg83tjckauRwCgtBB3OaJzLy1m/meuAP92BiZOVUc
         p0JQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCxB7L/ZgTW7MpBN1DxlICUd7ooT+uty3YwCR1nuhNWmZO6j8hrxDF09QewXuER2B0QV4Y90mlnaHa8QM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nrMQJblTcR6js8mXJG+4p3jzSZ5A55XX5yOkWaGARsMdFABKa6
	hyUTo1VPujk2Y27UY6chXFXVk94gOumrpBiWwMoPWm9tSUGPgDN1zgy7SpKoQ0lJZn53jnZqyz+
	ewSMRVQW8dM+qaFpSY1pHJdiSDSjyfIlL2A==
X-Received: from pldv5.prod.google.com ([2002:a17:902:ca85:b0:2d9:e5f:1d26])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:17d0:b0:2dd:c053:e665 with SMTP id d9443c01a7336-2ddc053e6damr7685515ad.43.1789752299497;
 Fri, 18 Sep 2026 10:24:59 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:24:58 +0000
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
X-B4-Tracking: v=1; b=H4sIAOpzrWoC/43OTQ6CMBAF4KuQrh3D9AdbV97DuCh2gEahpCVEY
 7i71YUJ0YXLN5n3zTxYougpsX3xYJFmn3wYcpCbgp07O7QE3uXMeMmrUpcCagmNv4GlCD31V7K
 XBIpLi7VTpLVmuTlGyjtv9XjKufNpCvH+PjLja/rxUAutxFYKLpUBDtFOXXBj9Hc7XA5tCO2Vt ufQs5cz81X35y8zB4TGoTF1iTts3Bci/kBERkjvUJkK0QixQpZleQLOcG3FOAEAAA==
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Subject: [PATCH v4 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
ghes_estatus_pool to store the aer_capability_regs registers before
enqueuing the error record into aer_recover_ring.

aer_recover_queue() returns void, so ghes_handle_aer() cannot release that
buffer itself; ownership is handed to the AER code, which until now freed
it only on the fully successful path. If the record cannot be enqueued, or
if a dequeued record cannot be mapped to a pci_dev, the allocation is
silently leaked. Under a sustained error storm this exhausts
ghes_estatus_pool, which then breaks GHES hardware error reporting
system-wide.

This series fixes both leak paths:

Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
         aer_recover_ring (capacity 16) is full. The rejected entry is
         freed immediately via ghes_estatus_pool_region_free().

Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
         an active PCI device (pdev is NULL). The loop is restructured so
         ghes_estatus_pool_region_free() runs unconditionally for every
         dequeued item.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v4:
- Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as
  well. No conflicts with the Advisory Non-Fatal Error support that landed
  in the meantime.
- Added missing Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption
  when error status data has multiple sections") and Cc: stable to both
  patches; that commit (v6.7-rc1) introduced the ghes_estatus_pool
  allocation whose ownership these paths drop.
- Patch 1: use braces on both arms of the if/else and fix the continuation
  alignment (checkpatch --strict).
- Both patches now build warning-free with W=1 and CONFIG_ACPI_APEI_PCIEAER=y
  (earlier revisions were only build-tested with APEI disabled, which
  compiles neither of the modified functions).
- Explained in both commit messages why the caller cannot free the buffer,
  and when the missing-pci_dev path is reachable.
- Cc: Lukas Wunner, who has been active in this code.
- Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com

Changes in v3:
- Resent to fix threading of the series.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com

Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
  is called unconditionally for every dequeued record.
- Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
  buffer overflow.
- Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com

---
Priyank Rathod (2):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing

 drivers/pci/pcie/aer.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)
---
base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


