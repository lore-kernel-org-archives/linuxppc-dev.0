Return-Path: <linuxppc-dev+bounces-23796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F82C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWc2rGyz2xpn;
	Wed, 08 Jul 2026 20:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505756;
	cv=none; b=oe3377U2jLCjiw87v0Ge9LIc0pnCl+4jmf/8tXYOGa76LjOyeSHhYWOdvWD5gj1YdKFGgrSuFpmMtxfw/6zc/AQ1caxrzUhjRAO4xqLGMfvGOoq2tFksjF0zpRkyzHtutR6fKzrC+F5VpubVSt9Bgd+9GLmBBfWhT9+7xu/TtWbgCEFTwqJYDPBO1nu6BqUAJvusj3JZ3nz3wIlALw2p68t0jSXO417Ew14/bTeOxBpBpExi8Me+MrkNgakWigo60QbXXTjzMt1iSpnggfFbQHImVF4G+oEpf4+QYn8tYAybGX6HBXH52z5E67Nt+OEnQQEUZTBrvF07HFLjtjAw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505756; c=relaxed/relaxed;
	bh=vAvPgJKH8E5PMa+rzxmboQbVEpCqkKMOdwuf26Tm0K8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYjdjmiDRzHq5W4s4ywCK61baHuw3k9e8z2WWmfZRYx0SjbOWWGUrcVo9crXxFgfcKVl/a8qTUEO+C/njc0++yBPKbOvUa+QNZh70F9KruAzXuubwxp8c9bQo8V/+PWU2elLop8Xg2CoNZ/ixcB+4j9EsyOwmMMjyuA0yC+SCi1V/7RmfnIfdNGunvt1EqvyyFtU+HDsb6mDVwrZKfBoSlDTC3Sj2F8+O+A/njJqBoSb4f7xIBPV2rjBqmVXMYT7e5DFXle11oE6xIOezYa2zIePMNoDukRz86mTrZS0441MvKplCkv3qcfWDOCinsw26VoUwpkqhXq6nu3K7tDkMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jlFd1uYn; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jlFd1uYn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWZ0xPzz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:15:52 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B04B1A0EDC;
	Wed,  8 Jul 2026 10:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47BE760337;
	Wed,  8 Jul 2026 10:15:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFF6711BC3422;
	Wed,  8 Jul 2026 12:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vAvPgJKH8E5PMa+rzxmboQbVEpCqkKMOdwuf26Tm0K8=;
	b=jlFd1uYn2yV2CPBYgVByiNDZQVn+1Kpebd2p4SHFTj/6APevVxQac56sRg/ftHrvki0SEk
	TPL0Vm8+WFLZJ/9LRiQcWKjwwV8MXGDrrN2uJUQzLeOXI4Sa2niDSKYsa04pTn5CIMUoD0
	KyFhOHEOcIzvJK+2+p9NigRBDv1pMDuC/O1TZGyKiHWXyHtTD6+tj0tbCHWvdKY1dVXdNA
	m5yfzIufseA2G4jO+M1T08/49wubZ37ZJtZY8uzqnSqGB1zKoxWCrpuVdxZJfCNcPYZKCc
	bmOrBuoLbYuI+hGHHB6L8fgLDpLAyMR4uv1TYZg38DPmwPnTS+cHUQ3HBLm3pA==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH v2 00/10] soc: fsl: qe: QE PIC improvement and add support
 of IRQs to QUICC ENGINE GPIOs
Date: Wed, 08 Jul 2026 12:15:13 +0200
Message-Id: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQQ6CMBAF0KuYrq1pp9BWV97DuKBl0DFKkSLRG
 O4uxY2iy5/M+3+eLGJLGNlm8WQt9hQp1GOA5YL5Y1EfkFM5ZgYCtMil4lfkDXl+aChELoxCsJm
 WeaHYSJoWK7pPdbv9O8ebO6HvUke6OFLsQvuY9nqZ7t7VWsyqe8kFr5T1CJUAi9nWhdCdqV75c
 ElNEzN/mfYKjdAIpvRfLP3Uw+dqNuOQ+LpwKKWtysz9cvXJ8xlXI7cCtZPOlA7UNx+G4QWo3SB
 mcQEAAA==
X-Change-ID: 20260513-qe-pic-gpios-073e284615a3
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, stable@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Christophe Leroy <chleroy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=4530;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=3mw24PdZ/MnLAdgaavO1HCjV8HURiuVJHNRuMIows9s=;
 b=pdrtt4GhhaY6xcboT+i0fyq42dyNHqHy5xcjYiq0zPAb3adp1yM5GcBdpgFU3U49Vj4rHUtvJ
 kK9jcVgfRkGDRqsTyU6D3iVuO+6kFpBIrtSULIyzkr4pYqa6fna31Ta
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

This series modernizes the QUICC Engine Port Interrupt Controller (QE
PIC) driver and adds the ability for QE GPIO pins to generate interrupts
through the QE PIC, completing Christophe Leroy's prior work [1].

Christophe's series was partially merged; patches 4, 6 and 7 did not
make it to mainline.

The series is organized in three parts:

1) Add missing chained_irq_{enter,exit}() calls

   - In a chained handler, the parent controller need to mask and ack
     the interrupt source.

2) DT binding updates

   - Update #interrupt-cells from 1 to 2 in the QE PIC binding so
     consumers can encode the interrupt type (falling-edge or
     both-edges).

   - Convert the QE GPIO binding from freeform text to DT schema.

   - Extend the QE GPIO binding with an interrupt-map (nexus node) that
     maps GPIO lines to parent QE PIC interrupts.  This approach was
     suggested by Rob Herring [2] as an alternative to using compatible
     strings and driver data to specify which pins support interrupts in
     a given bank.

3) QE PIC driver refactoring

   - The QE PIC is a perfect fit to use the generic irq framework
     instead. Perform the necessary changes to the driver to convert it.

   - Minor cleanups.

4) QE GPIO interrupt support

   - Add a to_irq() method to the QE GPIO driver that perform the
     mapping of the GPIO pin to the parent interrupt domain, allowing
     GPIO pins to be used as interrupt sources through the QE PIC via
     gpio_to_irq().

[1] https://lore.kernel.org/all/cover.1758212309.git.christophe.leroy@csgroup.eu/
[2] https://lore.kernel.org/all/20250919152414.GB852815-robh@kernel.org/

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

---
Changes in v2:
- Applied Christophe two patches before this series [3] [4].
- Fix a miscalculation in patch 6 when iterating over bits set in
  CEPIER. Old ffs() is 1-indexed, but for_each_set_bit() is 0-indexed.
- Add in patch 3 commit message more info about the changes introduced
  by the conversion to DT schema.
- In patch 4, keep the existing example without any IRQ supports, and
  add only one new example. Also fix the DTS coding style that was wrong.
- Add raw spinlock guard to mask and unmasking hook since multiple CPUs
  can modify different IRQs concurrently. Also add it to set_type hook.
- Drop usage of register offset in irq_chip_type. It requires additional
  load instruction with no real benefit since irq_gc_* functions are not
  used.
- A race condition can occurs if an interrupt fires immediately after
  the domain is initialised, because gc is NULL.
  Instead, do not carry gc in the struct qepic_data. Add the domain in
  the handler data, and retrieve gc with irq_data_get_irq_chip_data() in
  hook functions.
  Because of this modification, patch 10 and 11 are dropped.
- Link to v1: https://patch.msgid.link/20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com

[3] https://lore.kernel.org/all/b08f76c1d8ff864774246f1e2c2158c223c001be.1783435914.git.chleroy@kernel.org/
[4] https://lore.kernel.org/all/cd46aec4b325745d38ac7992e4d3d5b4f4c4e95f.1783435914.git.chleroy@kernel.org/

---
Christophe Leroy (1):
      dt-bindings: soc: fsl: qe: Convert QE GPIO to DT schema

Paul Louvel (9):
      soc: fsl: qe: Add chained_irq_{enter,exit}() calls in cascade handler
      dt-bindings: soc: fsl: qe: Set #interrupt-cells to 2 to support interrupt type encoding
      dt-bindings: soc: fsl: qe: Add support of IRQ in QE GPIO
      soc: fsl: qe: Use generic_handle_domain_irq()
      soc: fsl: qe: Iterate over all pending interrupts in cascade handler
      soc: fsl: qe: Handle spurious interrupts
      soc: fsl: qe: Convert to generic IRQ chip
      soc: fsl: qe: Rename irq variable to parent_irq
      soc: fsl: qe: Add support of IRQs in QE GPIO

 .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   |  84 ++++++++++++
 .../interrupt-controller/fsl,qe-ports-ic.yaml      |   4 +-
 .../bindings/soc/fsl/cpm_qe/qe/par_io.txt          |  26 +---
 drivers/soc/fsl/qe/Kconfig                         |   1 +
 drivers/soc/fsl/qe/gpio.c                          |  28 +++-
 drivers/soc/fsl/qe/qe_ports_ic.c                   | 145 +++++++++++++--------
 6 files changed, 208 insertions(+), 80 deletions(-)
---
base-commit: c34b47a17bc566c7113679e6ae095d5510b4f1c6
change-id: 20260513-qe-pic-gpios-073e284615a3

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


