Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62052606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAR24fhg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKxNq0M5tz2xLt;
	Thu, 05 Nov 2026 20:10:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793869834;
	cv=none; b=fjeS3w/j2RaEbd9TqQ8QeJA01dr8OSSvfqp8Snind3/6iCev5dixzvUV9XuOf6krvmFckakWCXob51Yy22/C5Eqr9ggVjAviBivdHkY512a1cdFSP4vr0cbMgjZl01AszcGg8XnNCVMCsl889TOqnUqeadZso56tRRoYgUFosUJzUq3ZMY7H+8ki4Hd15ixdukjQAS4enaCuLbkJCx+f8JQCoMdw4ZVBwxznNdiY50NIP0s2L9pdHZlj41JaYdNauAl+yTH18sZC0tmlFsCLJ7KARQZ25ICi/khUu6ZbNiyH302KNOOB2+OJ2sI/o7nQt5WC18+aWyuIYn7Z7MLj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793869834; c=relaxed/relaxed;
	bh=l8FVoARO3j3t6Swl/r4USV4n/IIP1DJGnmzvtDWkxwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqUhflBUx9Gm9rpLrZkJnd/GRTl0QjzzUe+XZAQaw3fje2ZkAcfZBZktCR7qGFXJ/iE+a/UPux8BoRmQx7UpBOQVPukxXz+ril121AQTlIW5qAtYbaHnsLMOy+GJIJBMn3QYmbWeWRK2tSznQm0E/mJ5G2YdOalVmLUFKUdAlLkYCjpUb9hsJLpQ7YxlSow1sHw6Ujejz7xFl4uo4XEdAxuxuDPjWydiJ5lHJ5V1tTqVl1/RFXpImadgifpacY2kAbmyoTD9J5S/bkMW+gQpnvbCSuCsW6gdLOXB40qAUid0GzbYUq2SZ0go0xssIlLVHcj7oPbBUJRq8ATSFr0a8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAR24fhg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAR24fhg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKxNp1j2zz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:10:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CB822445FB
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2026 09:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5931F00A02
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2026 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793869830;
	bh=l8FVoARO3j3t6Swl/r4USV4n/IIP1DJGnmzvtDWkxwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DAR24fhg1o12QPYF8w+7b8HIwsxRutsHpEf4cTFEyfIe1ri9nazYsDIocFwx5ISJP
	 /3zIPoK5gQ2uI+H1WEkOK0X8GhFfj+9hv4l19yz1q/DPecQzQz2d5wbU1n2ejd3hHg
	 /zhtdfWlMuzov1tVk4nMgIA2qtMOnpO+yRJas9gvpgUs9txLGJr7ilihbpns5ihEDF
	 4/2yV2xRNhSNdsLoCt6rVfexZqo5PI+2bh5Zb6srEz7QL1UDMhOmHpUYxCXABSTIqt
	 wtkhqxb8Tr9xqccUmW68LmRoovBaE4sFySPUjEpNYZPRH5NW5iNUtVbG0K+6xqcnIW
	 aiNZNsoA0p13Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be416e603cso1088766e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 01:10:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByStotcfVr8trrVU/MVTe3jnv8hG2BU0PiYyATVwtFLxyYI+gwiySjez2QFqH+wZfZdC1pVz/vcwh9EbsA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9MhKrN8MuI4QaDnsvGST861SwAn6pNESb7+b/r7YUy7ZLbJ7Yu
	gC1GF84sBNSWd8LwSBQJf0CIT5JjXALT/jCVumOnFON3x6v5ufxbwjsNovZDN4uck3tZgQ0Fkfr
	Gaz22BeWKGrEsdL4DnupMmJ+VPGaBoEQ=
X-Received: by 2002:a05:6512:31ce:b0:5bf:be3c:6599 with SMTP id
 2adb3069b0e04-5bfd957cf17mr5726763e87.67.1793869829164; Thu, 05 Nov 2026
 01:10:29 -0800 (PST)
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
MIME-Version: 1.0
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-4-3aad0860b984@free.fr>
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-4-3aad0860b984@free.fr>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:10:16 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com>
X-Gm-Features: AclHuK_7g7nY-8H8wprNfNKV8lgILSoOexV2IGLiXfskv9qSmIolBJEeTn_Fqx4
Message-ID: <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux driver
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 7:12=E2=80=AFPM Vincent Jardin via B4 Relay
<devnull+vjardin.free.fr@kernel.org> wrote:

> From: Vincent Jardin <vjardin@free.fr>
>
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW, read-only in RCWSR12..14 of DCFG and changed at
> runtime through the same fields of the override registers in its DCSR
> view, which read 0 until written.
>
> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> gpio to support bus recovery") Linux drives them with pinctrl-single on
> the override registers, so its first pin state clears every other field
> of the word: a board whose RCW programs a non-zero pad mux loses those
> pads at the first I2C probe.
>
> Add a driver for the pad mux as a child of the DCFG node: the fields
> of RCWSR12..14 and their encoding.
> Then pin states select them with the generic function and groups
> properties, and every change goes through the RCW override
> of fsl-guts, which reads the status register, writes the override and
> waits for the status register to follow.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Can this be applied separately once reviewed?

Yours,
Linus Walleij

