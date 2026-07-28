Return-Path: <linuxppc-dev+bounces-24949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD7C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 15:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8fF91PCvz2xyh;
	Wed, 29 Jul 2026 01:16:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785251789;
	cv=none; b=Y4H3Whf+yCBBdpdLxcGd034R06spW/9bVTJ2n0iaMI6t/BzAWO0G7HudoTpieQW8x0fzvP49OJvPbkX6BQGO29yUoFhJUaxdT4MwBO6HfjXkzf8htEHs5dXsESpEt5wjdM3am8tEj2D3r3XG9B/XY5p18zAQEDt2rnZGY6TJkow6stAcLbm9Sr6ARhCfZlG3FJV59yNOZtGA8JInbYwqtIiqYhkHQ6uFgW/bJO883NHamgtHgGygvqYtwo19EjJtBY7FbxHCds2MXvrmGo9ayvk45CAeM2+gvl/ExJxqmHoK2f321AS4bbKIDr4tGbyUFMAyUaR/IQA8O35nClT2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785251789; c=relaxed/relaxed;
	bh=AKmCiyijWN/uLTU+ziUJPAExecQNAfC6LNifRhKSbP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daL0IggnvT+AePKrLPMsfL6FwlTwPZRvXXC8AL6ArEymV8o61a8aRGSTOJ7jTTxxVGbdvMTag2u4H6602fLEoqohrWL4/0c4tz+NdwgewFRPJi71EBsJB1bNCtSnG8UtoQ0Pn7Rvr90FyoczehzcJ+3+mQtHsTcphuSogPcSxJSQwxWyhHmpmzuNZ09+RN0aKLq+TDVFsxvc//EJWLnp5trPicnVXcNctD8UWjl+w3CIzjwnOtiRdzSnYqqkDbcRlfPmWXFBO94fmVcaxxaQlEhSkoNKKt6vGsw65/qyKqe8hfgvs3wzdUhdxGtgVSdhPVSZYg9xbB76qdR4mWJuow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT+OWaoN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT+OWaoN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8fF75Ykgz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 01:16:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2639600FC;
	Tue, 28 Jul 2026 15:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E90B1F000E9;
	Tue, 28 Jul 2026 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251784;
	bh=AKmCiyijWN/uLTU+ziUJPAExecQNAfC6LNifRhKSbP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HT+OWaoNss9dyGIt96cm7kUWxZwr1/upNA8gYJhp4gQu2rcKARW7W4pOrYjLARVxf
	 RSBesFk/vRQugTx6TZM7pRwXl74IO/Txx8FxRdWHjlmN5WuymefVb2lDhkfHHnQu3s
	 0EVMH9FcMJN4tlMqlKlVP9UECW5l2Nwc9d+sk/s612W3JRKWidTIOYMNkyX6JbCkoF
	 dSrozUw+tguv6wSW1oR94DUs3pIF03YW5c8efhF8pK8q2maxPOMN6Ww2enl/ZiybkC
	 NZQrja/3P0XNalniKAg04vcByEm0yaKdJkg0yUZcjjoEVF/aT/l/v9Ya8dGMkl4q2E
	 GK/o9a0lw9dQA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Louvel <paul.louvel@bootlin.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	stable@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/10] soc: fsl: qe: QE PIC improvement and add support of IRQs to QUICC ENGINE GPIOs
Date: Tue, 28 Jul 2026 17:16:04 +0200
Message-ID: <178525175512.295368.12455063665178901595.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=chleroy@kernel.org; h=from:subject:message-id; bh=NeoWdYHUix6Az+HvrAdVP8+jIL8qYnnnjc+0DoSprAs=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlHN/h9Su++WiUD7dlVsxaha17f/VtSplhf185/HDq+ +Qm+9czO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEZskyMnTPvSXybe57JRbB pSqR+5IfLGLc7XOjQWFmW7/dL9mClZyMDK1S6w04VEN3zDCIlo7Pbd26s4i3/NF/t/8fLUNunHv Ayw4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 08 Jul 2026 12:15:13 +0200, Paul Louvel wrote:
> This series modernizes the QUICC Engine Port Interrupt Controller (QE
> PIC) driver and adds the ability for QE GPIO pins to generate interrupts
> through the QE PIC, completing Christophe Leroy's prior work [1].
> 
> Christophe's series was partially merged; patches 4, 6 and 7 did not
> make it to mainline.
> 
> [...]

Applied, thanks!

[01/10] soc: fsl: qe: Add chained_irq_{enter,exit}() calls in cascade handler
        commit: f9cb22ee1b94a3cc5927a3cf3a6f8d01eff8e569
[02/10] dt-bindings: soc: fsl: qe: Set #interrupt-cells to 2 to support interrupt type encoding
        commit: 5708dd3c5a92b9199e4d12ae835b42aed55fe35d
[03/10] dt-bindings: soc: fsl: qe: Convert QE GPIO to DT schema
        commit: a9fb1bd72af0bac860df82efcd92af9e6d4300b6
[04/10] dt-bindings: soc: fsl: qe: Add support of IRQ in QE GPIO
        commit: 33c35fcd8ac007e497f629de105aaf5f39139d1e
[05/10] soc: fsl: qe: Use generic_handle_domain_irq()
        commit: 2f30a619841dc0fee839eabc47b9d013a34dad7e
[06/10] soc: fsl: qe: Iterate over all pending interrupts in cascade handler
        commit: 8244ee2deae73c12a35616a8eed1a88531dcb36c
[07/10] soc: fsl: qe: Handle spurious interrupts
        commit: 7c1419107a55a8d89938a9d04f9c93d9074a3ea9
[08/10] soc: fsl: qe: Convert to generic IRQ chip
        commit: f585e2fac5750ead5f697a47b8612baf927f3d10
[09/10] soc: fsl: qe: Rename irq variable to parent_irq
        commit: 8cd24ff37c299f8159dee8193f171443b331c708
[10/10] soc: fsl: qe: Add support of IRQs in QE GPIO
        commit: 4a3ba9789922560a8111ffbd09f1fde2abff639a

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

