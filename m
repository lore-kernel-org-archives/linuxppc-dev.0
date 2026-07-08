Return-Path: <linuxppc-dev+bounces-23846-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D5C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:25:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ2T5lPQz2yd7;
	Thu, 09 Jul 2026 09:25:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519200;
	cv=none; b=kaVm73eZNYeKL/WpUuhTkVW5933AXu5iYh0MUs+BJfhI46pXY38lM4USvTwLgYEsNsVBxGv4godahFGXwGTBIFoo0RPXujjzi8rXXW7NLM1FhAspZ9Q55rCFxCwFO9D1n0/ybNlsfa00tcMF6Lm07z/0m1XCM9JOeNXGRQqLrZcvAU2X4TIcpGUGQkWzWsqYw4TrVQDKH49ftT8rrvUJk16iM8uHyAwrpUriOouXT1PvqLhWigbwJcyaXaqtRzk8S9ZYLE/HZFd1whlF0qoj74+oi5jjvTdhRAa9O1w0Y0rjEbwAPdzQL9qOfzOTiuUEq+dD3mdTm86cQtAGHu3rDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519200; c=relaxed/relaxed;
	bh=V6r7Cfko8qtYi+q5vbUTU1oSVIhRu4ON4ZSfNqUoKzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hseb7FCv50acDxtVFzk47BnWXFAd8/iJMuW4MWk6WkEEJaxf/2HWuDXy3R5VCy4L560mFq8kCYJNLv7xq3fhZCvurTvGWZ23Cauiytg5W0PJXhjlCEAyUDWTezy9ViFZJED/c+p59vys5k5m/DrFhEsdSL6nBqEOLUVMvfSgAao/nfnjdVtxxNo3I71JoUue4AhKUPqwJLPD0SztQNxZWQDNZKSbnbM8Rub2IFN7LYK27WFlINkGmYzJckg2AYgCOJkR4PYt6jsDnBw8DrSOkHVO7eYJP3wOIXVrymIqXeVrgrLF/pAjskHj37bzcZ90rM6/uaTs1fnOQ0Aq/mBCcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PPh5n0Rc; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PPh5n0Rc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKV54r0Fz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:59:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B6B152B;
	Wed,  8 Jul 2026 06:59:18 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EC253F66F;
	Wed,  8 Jul 2026 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519162; bh=egpzf7FOljHOA/UNeDZ0uuZAzOwk9J//58dI10sIFww=;
	h=From:Subject:Date:To:Cc:From;
	b=PPh5n0Rckf4lPT5ow/Rp0ugC+rxNZkCQVJJXF0ETmkRNYeQcxFnVRsmQo1ikDUSUN
	 NHgcSsIjM1TaYUpQRzAsK5Iu7jfGNS9QvFXLun9ISW97tCqPB5kZMG02XcsGCa7tyW
	 34qZIeUqLvT1FPNy3Efqhmh1/RrhEH/7DAsWJEzI=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Subject: [PATCH v7 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Date: Wed, 08 Jul 2026 14:58:59 +0100
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNXTmoC/5XRzWqEMBSG4VsZsm4k50x+dFa9j1Ik5qcGqg6J2
 JbBe+9xoFiXLr9AnjeQByshp1DY7fJgOSyppGmkYV4uzPV2/Ag8edoMBWqBKPg83ZMr3PbDnDo
 BPNvSxti3Ng9tGueQR/vZblL44l303pnojLMdI/GeQ0zfz9rbO+0+lXnKP8/4Atvp1lGAYACwl
 qqCGiRAw2ELBl9R075SqnLTwDZiwb9r55+3IBf8Kk206M1VQXeU5S4rqM/JkmSJuqm1UZ3VcJT
 VPxmbc7IiGYNQQngKSDzKepc1mHOyJrmBaOgDjLRW7PK6rr881bvuKQIAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ahmed Tiba <ahmed.tiba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=2775;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=egpzf7FOljHOA/UNeDZ0uuZAzOwk9J//58dI10sIFww=;
 b=z0wp9aIYNr5NMorh09jiJbcMtJLugd5jUHOdl53jOd3TImjbi3fvS+YXV8tvo1u999mp+hyAF
 A6HNDu/8MqQCkzA5Have9zBAay47klANWoyQ5GlaL26mz974WlQDnIH
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

This is v7 of the GHES refactor series. Compared to v6, it addresses
the Sashiko-reported issues including pre-existing ones and fixes
the ACPI-disabled cper-x86 build break.

The DT firmware-first CPER provider is intended for the upstream zena-css
platform. Validation so far has been on FVP.

Changes in v7:
- Address Sashiko-reported issues for this series, including pre-existing ones.
- Fix pre-existing CPER header overflow validation in cper.c.
- Fix AER recovery leak when no pci_dev is found.
- For DT provider: serialize pool init, return IRQ_NONE on empty status,
  add OF_RESERVED_MEM dependency, and harden status length checks.
- Include <asm/acpi.h> in cper-x86.c for ACPI-disabled builds.
- Link to v6: https://lore.kernel.org/r/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com

---
Ahmed Tiba (10):
      ACPI: APEI: GHES: share macros via a private header
      ACPI: APEI: GHES: move CPER read helpers
      ACPI: APEI: GHES: move GHESv2 ack and alloc helpers
      ACPI: APEI: GHES: move estatus cache helpers
      ACPI: APEI: GHES: move vendor record helpers
      ACPI: APEI: GHES: move CXL CPER helpers
      ACPI: APEI: introduce GHES helper
      ACPI: APEI: share GHES CPER helpers
      dt-bindings: firmware: add arm,ras-cper
      RAS: add firmware-first CPER provider

 Documentation/admin-guide/RAS/main.rst             |   15 +
 .../devicetree/bindings/firmware/arm,ras-cper.yaml |   52 +
 MAINTAINERS                                        |    6 +
 drivers/Makefile                                   |    1 +
 drivers/acpi/Kconfig                               |    4 +
 drivers/acpi/apei/Kconfig                          |    1 +
 drivers/acpi/apei/apei-internal.h                  |    3 +-
 drivers/acpi/apei/ghes.c                           | 1044 +-----------------
 drivers/acpi/apei/ghes_cper.c                      | 1122 ++++++++++++++++++++
 drivers/firmware/efi/cper-x86.c                    |    1 +
 drivers/firmware/efi/cper.c                        |    3 +-
 drivers/pci/pcie/aer.c                             |    9 +-
 drivers/ras/Kconfig                                |   12 +
 drivers/ras/Makefile                               |    1 +
 drivers/ras/cper-esource.c                         |  332 ++++++
 include/acpi/ghes.h                                |   10 +-
 include/acpi/ghes_cper.h                           |  141 +++
 include/cxl/event.h                                |    2 +-
 18 files changed, 1709 insertions(+), 1050 deletions(-)
---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab

Best regards,
-- 
Ahmed Tiba <ahmed.tiba@arm.com>


