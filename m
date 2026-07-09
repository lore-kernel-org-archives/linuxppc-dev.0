Return-Path: <linuxppc-dev+bounces-23961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07260C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3zz59MHz2y8p;
	Fri, 10 Jul 2026 04:54:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783623295;
	cv=none; b=Yr2SMy9zIf4bOm4PAIGWw52okTxp+6BskoYN5KE1pOAQDG2BvUHCD/0q0YG03iwk58BDTJ1ucykJ7gq6T+l+hg9JPGB0hDT5hUE0dpYLvoNm2xQ7IZa3Y1ttI5M2+2DFbyMTEANxui3P/B0xtnvvZKiUEn/coaumTxFMBLVZlCuCx1pXeLX7ZeDO8DhZgiVmsEhnhxZv9BNZ4+sJrjzFjxATCQzpiwROtsU4e871d9AkhFhny3UJ1aRCbTGQF37FFJ6SeEg9WdKFkoJ7sc3nd4380K7JBLNpvFtYaDzI5owoXqeGWRy8zl1aCTSrmZPNdBx0dCMA8OylqroxJjYuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783623295; c=relaxed/relaxed;
	bh=CwAEOJfLknybTUfP/QNSK3Dc8aL5FOhkk5/YS6kTpG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA+DQYV3Z4qDQnNFQhdnfYRR+itVIQ3vMNdE0NVEi9fz5z4dCjR1kOjKmkE/+D+RlAEs3zw8fdV+Pf6nYPogoByVNeLm/DSoPqvEDaNeBnwJjGC1NeltFlnim7NdbRLJfVwXeFCwojA/aVQeKpil/mAo5Xj5leoncNoK1gnX30O8pDybSa0j+xxrgEToaZmTxcMNGqzHzQFHHM2y4NtfzvqRnnJQdJ1HgUIazDMAWIrwpRuOzHxzQURnoX1QXYpX2mS98kTftIe0f0S5GEUY5VERz2cp/7RGbKulw6GjKkgGuQ2V450f0/cV2vGStYqZqc3+40G38Y/0Wbj02zipjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MIlbybat; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=MIlbybat;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3zy0Bd8z2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:54:53 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-36b9d265355so222392a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623291; x=1784228091; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwAEOJfLknybTUfP/QNSK3Dc8aL5FOhkk5/YS6kTpG8=;
        b=MIlbybat9obNM+r89xKK7LdSu9Sok5mUNAEAZWrcHpfPYK+6R3xG59Ua6/pW0MnBPv
         O0S4lKzUeyg5PKD9b4vkY+F+OjlRIYB9I6LGFrRthosC5q8/RnsP4mn/yn98+iZEIlJc
         /hhEMF1wkyc8oLbgicJ27X40SkP4t4DTRY1OiocvsT/JMAgt/+yeSxnXtWuFIwG/Gp0g
         KAYuPeCrxZveneiF/11db7TAQeZ/ez8t4FkAWAw0VYL+EuoU4GEUxGIXNlxtADx9nTEl
         bnOwXEe0bWMtberXmJ3Ylj3rDYTjZCG5fcdf9ofPgrzojulHDLRFCWOaEVMM/wREyj0M
         nIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623291; x=1784228091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwAEOJfLknybTUfP/QNSK3Dc8aL5FOhkk5/YS6kTpG8=;
        b=qDNbq3g43JTfa0zyJMYwDOgF1m5RZsMeJAmdx+m1Vyl2biH5wsTDKQowPpbSyP1xPk
         LrlGvgnbNwBLxPVprVR/6rUKvP8umc8qZUgQUh/21vXaTU+Z7eYc+bKafHzZADNIL7Ed
         jwuE2jH8fqtqSbn5lgh4DzxZr3viQ+TN8m23DRQT8bMmXdT6gDfCbYYsKAdK98XRjccR
         FfqbSFudbVyf+WvVTLQPe3K3q68vbY8oeHmpf3usnpSvlQXoPnlnMdc/YusPAuSG1uOL
         12G3OfhZ7uUJsO9pyHlAbm8XnWihIbfc/g9rTuFWRjxiJglDeue4wvQ67aCc0zOkRzQ/
         5ohg==
X-Forwarded-Encrypted: i=1; AHgh+RpASVNEHJVvoXexnKOjfotMbxljG4+FAH+MowpPxMuDS3iXbd9BjgU+43hb5uX9Nwm2ohV36bhhHL1DSKI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZtzWgoUbBqIqM8z/CFgRSCR8YD+aFS3LRz1i5dZGDbLTiJsbw
	846S0guSPx4K7UqBG0XRq/kKZv/fQTQKnfaew9J2JJpCaXMXQpemXviv+xcmKoC1vMugGIlc54B
	1o+w=
X-Gm-Gg: AfdE7cmM7jKHGbINfRTniqOqefFiaus7SCnqq3J7u3MWn/NKUlOCYqeBE1gtAB2k0gX
	QLYVAf/Za+4UF0VlwRCkgjPoQCn/oACwSjEQr4gKE5veOoMWe9O5QGRNsAMgePtREQzCeVmkzHz
	4opvYuDX8dofc8trhqoTtVCJgAk0Pr5hVH3W1WreqiB7h/zgOx1thB7pJ2to2Lt/3LU6pSai/Kd
	bR54RRqi92R9Tc4I06ojJaMllx7Rg++wnP3xuxazcini5KNj3ZWC+XLgRtyc28VI5sqdLGLr5ir
	P/E1V/YtdHzRp2eFnDCEzv964XOyBBYKBldeAkfaqvbO5o3373iBHe9rFU7CdHARe0zdELrxG2s
	FZIQiem99L/l+nrQE4l9bHZdIEX55lJSi6cG9JiNgud1eJx8zpHn/+55swGbn7+cH6O21YEkxbY
	G0Ai2JZKeGMbMSUNsRPHUeMdObuoA/Yy4FMB2ZVrdMm91b
X-Received: by 2002:a17:90b:56d0:b0:37f:9ce1:735e with SMTP id 98e67ed59e1d1-38941bce343mr8584552a91.31.1783623291109;
        Thu, 09 Jul 2026 11:54:51 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:49 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH v2 0/2] PCI: Add boot options to disable DPC and AER recovery
Date: Thu,  9 Jul 2026 18:54:27 +0000
Message-ID: <20260709185429.627968-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
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

On large modular systems with a complex PCIe tree, the default kernel
AER recovery and DPC behavior could cause unexpected side effects.
Sometimes it would be nice to have the option to keep the system in an
unmodified state and be able to handle PCIe errors from userspace.

This series adds two new PCI kernel boot options:

  pci=noaer_recovery  - Disable AER error recovery while still logging
                        AER errors
  pci=nodpc           - Disable PCI Downstream Port Containment entirely

---
v1 -> v2:
  - Patch 1: Move disable check from pcie_do_recovery() in err.c to
    pci_aer_handle_error()/aer_recover_work_func() in aer.c for
    proper AER-specific scoping. AER error status bits are now
    preserved (not cleared) so userspace can inspect the error state
  - Patch 2: Also skip DPC port service driver registration in
    pcie_dpc_init() when disabled
  - Rebase onto v7.2-rc2

v1: https://lore.kernel.org/linux-pci/20260602105558.1799563-1-yurypm@arista.com/

Yury Murashka (2):
  PCI: Add pci=noaer_recovery kernel boot option
  PCI: Add pci=nodpc kernel boot option

 .../admin-guide/kernel-parameters.txt         |  9 ++++++
 drivers/pci/pci.c                             |  4 +++
 drivers/pci/pci.h                             |  4 +++
 drivers/pci/pcie/aer.c                        | 30 ++++++++++++-------
 drivers/pci/pcie/dpc.c                        | 19 ++++++++++--
 5 files changed, 53 insertions(+), 13 deletions(-)


base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.51.0


