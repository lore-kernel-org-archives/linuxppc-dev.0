Return-Path: <linuxppc-dev+bounces-28418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D03BCA5FA3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htpVt0NzDz30Sx;
	Tue, 29 Sep 2026 03:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790617237;
	cv=none; b=aT7025ra+SImJLvoZIYYIlXgn5Yb2ZoxlvCjDP2cRorAn2ajpeMWnGWgx6JvP4w4BovzNZohR4g0gQ8k/8FUePmiUw0H9bqzzYfLLYI2WUAx+kpl6mubmtZDcEFf8HQEX0G2iEp0B6qWdtAE8hr4l9Z6ndkiJg8ate2N/g8Uzx1Y2oHlSMbgPbz+3CM2YCucXYa5y9K+ge3tF23k0VnNIAr8GMn61ofOIwlJ1+YG8nA65oP3nq0p8tjQoHehMHOnrjLZgXHZ6hGs175JI5NvxPB9L1CYBKz96PA6STK8oaNq2P2sc/5VwhvsZVHuw9LZELwqzV1S6le4nvif7Ss42g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790617237; c=relaxed/relaxed;
	bh=fYPTVor7lW3r9SolJqGFaqIvM2+F+nxKkoRVuMrFoD0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OlR3EHlG23emLqMXzIDvhuRnoYIV5e1l335qKCA92E3nl26YIKTTfQzXW3HwH4WlAhP3nabSe3jGOmrdhQ8rd6hNmpLlNrBpOg97CYxyLmu+auNIzgN71uX1zEQ8hMa0AVCc2Ow79+3jSFT03pQWWgaeqVwg8bFwBpOaL1er96/Jno8XOX5Oxu9Nmxa8t6eHEKsfydZcH0cJZ6q/TPW1/gtZ20uzf1eCH9dJ7UB+aLMFu9XeWb9fcV74vHsnMFgJ/zPECeYV7wJj6OoyZuGtkZq6LJi3uwo3DzjQg6FPIGPoXsQx3qNLZB2PqlK8ex4rJtRoMN8U6p5qwNJqFT+yRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=deGGe5Q9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3kka6ag0kdcusbuipeqsjzbolhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=deGGe5Q9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3kka6ag0kdcusbuipeqsjzbolhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htpVq6mrzz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 03:40:35 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cb48f41343aso46189a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617233; x=1791222033; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fYPTVor7lW3r9SolJqGFaqIvM2+F+nxKkoRVuMrFoD0=;
        b=deGGe5Q9lA30c48bmqWsk/P+T5gAHbQebBpKXZDBsiMMo/6Sm6X4370/vRNURGEq0L
         G0QaypPxMfqGevDsjfOfRd9oypxc9UALkWrjvDjKT+V90uDvA4wZRV2zMJ9yNOf5sflG
         Dp1sXDdiSjyIQ40sB+A5TLT4WIBSLGaNlpAKqhVYH4WlBa6NBoS9XNY1DgKk4CYtI4w0
         vEv6uI0TOWSCM9UT9xY9k3aWc9E0fZeqAIzBFX4EwE+WT2hI6fBszhXTaM2/TaewMPcL
         /N9E9mzBGNTx4ihxmjIziwB5a5u8UYvXb6ZsKpG/0mXrYBC1jz3rFJEDgYvrW5nBNBYd
         Yx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617233; x=1791222033;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fYPTVor7lW3r9SolJqGFaqIvM2+F+nxKkoRVuMrFoD0=;
        b=jqeuV+KJrttiFefGVZJrzLFw8Vy9ZJYnsD6kHZOJgt6g3+lC/Atr6Wjoe3g8fJmOPO
         SwqrJi8Ee/5j9xLTGb8FRXJp/Qw5B2in7npB6BU9JVnyae2SdTjfyRSUFzWd2XGbzSR6
         dlyeHQv/JsnycxhtybMgAgL4Hcu3kYAxLo0UQklmPjQCyCln8KpTlb7mIM7KKQYYQksW
         67sXLdFpR0QrN+WyzCPkvj7Ic0pTI+hPJsZoJqCTPpVhBq+iWD4otH6gW/T11tcxnyQW
         bwMVFNyR3rXWiPEOaB832jWf0EqzE9+8Y0531gc0qxnxGbC9SzdHh4haFWi5H3UxkW5j
         9Qvw==
X-Forwarded-Encrypted: i=1; AKwUvBzcw6i60Ve/yCshZc2YsVEd1vuILDewgGTpPGW7fyWOwRt5WDnUl9dB54xxnO9Arrkr5Lpq9WaTp3pBTUQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mLxyMh3KM89sXpU3d+VszLi6FiETTI6N1JVRcBtOLfMGipjgRW
	EtTQ2zafArCWPZLa/6xt4WB3j2qLZigIFPOv6hBpNAJVe6Z3XgaksRjosW+VkU1UZg/o8bCyqNA
	cVSPDBLc9aWokaLzOCpqgnHQhgN6CBacJbA==
X-Received: from pgbgj4.prod.google.com ([2002:a05:6a02:4944:b0:cc7:9801:78ce])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:790b:b0:3db:887:7868 with SMTP id adf61e73a8af0-3de7cd46233mr58280637.15.1790617232335;
 Mon, 28 Sep 2026 10:40:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:11 +0000
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
X-B4-Tracking: v=1; b=H4sIAHumumoC/43OQY7CMAwF0KugrDGKnQSSWc090CzSxm0jaIMSV
 IFQ7z6BxYwQLFh+y//ZN1E4Ry7ia3UTmedYYppqMOuVaAc/9Qwx1CxI0lZaqaDR0MULeM4w8nh
 kfyhgSHtsgmFrrajNU+a681D3PzUPsZxTvj6OzHif/nlolTVqoxVp44Ag+/OQwinHq58O331K/
 ZE3bRrF3Znpqfv2l5kAoQvoXCNxh114QdQHiKoI2x0at0V0Sr0g+h9xaN8jGiR00lNLyAEDPiH LsvwC0WDYiX0BAAA=
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

This series fixes both leak paths and documents the ownership rule:

Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
         aer_recover_ring (capacity 16) is full. The rejected entry is
         freed immediately via ghes_estatus_pool_region_free().

Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
         an active PCI device (pdev is NULL). The loop is restructured so
         ghes_estatus_pool_region_free() runs unconditionally for every
         dequeued item.

Patch 3: Add a kernel-doc comment stating that aer_recover_queue() takes
         ownership of @aer_regs, which must be allocated from
         ghes_estatus_pool. This is documentation only, so unlike
         patches 1 and 2 it has no Fixes: or Cc: stable tag.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v5:
- Add patch 3, a kernel-doc comment on aer_recover_queue() stating that
  it takes ownership of @aer_regs, which must come from ghes_estatus_pool
  (suggested by Kuppuswamy Sathyanarayanan). It is a separate patch so
  that the two fixes stay minimal for stable backports, and because the
  comment is only accurate once patch 2 is applied.
- Add Kuppuswamy's Reviewed-by to patches 1 and 2. Their code is
  unchanged from v4.
- Still applies cleanly to pci/next (94e8d4e94266), before or after
  Lukas' "Error reporting for AER-incapable devices" series:
  https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
- Cc Kuppuswamy Sathyanarayanan, Jonathan Cameron, Ilpo J=C3=A4rvinen and
  Dave Jiang, plus Shiju Jose and Rafael J. Wysocki as the author and
  committer of the commit in Fixes:.
- Link to v4: https://lore.kernel.org/r/20260918-b4-fix-aer-memleaks-v4-0-f=
0a2c21ed1d1@google.com

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
- Both patches now build warning-free with W=3D1 and CONFIG_ACPI_APEI_PCIEA=
ER=3Dy
  (earlier revisions were only build-tested with APEI disabled, which
  compiles neither of the modified functions).
- Explained in both commit messages why the caller cannot free the buffer,
  and when the missing-pci_dev path is reachable.
- Cc: Lukas Wunner, who has been active in this code.
- Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e=
87159611933@google.com

Changes in v3:
- Resent to fix threading of the series.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-f=
d199b0171fd@google.com

Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_fre=
e()
  is called unconditionally for every dequeued record.
- Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
  buffer overflow.
- Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriya=
nk@google.com

---
Priyank Rathod (3):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overf=
low
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is m=
issing
      PCI/AER: Document that aer_recover_queue() takes ownership of aer_reg=
s

 drivers/pci/pcie/aer.c | 48 +++++++++++++++++++++++++++++++++++-----------=
--
 1 file changed, 35 insertions(+), 13 deletions(-)
---
base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888

Best regards,
--=20
Priyank Rathod <rathodpriyank@google.com>


