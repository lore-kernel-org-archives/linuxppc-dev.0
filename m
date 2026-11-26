Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C9606A335
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPpEeEcK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZxL60Xlqz2xl0;
	Thu, 26 Nov 2026 23:53:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795697598;
	cv=none; b=TXjmyxVA2iXzpF5VFQw1kAKzR5uwOrLgaNXh2UxdPZuRzHzur3+YmX0xNutXcR3gehK+/Uvad9JPb04yh1NDvY4/k5IibobC10yzeeTN/PqhJolGaDFiYGxPUJRwV8B+GL+kYQU5GUplRQmaEwsdZhBin7tIJT4BrgQl+4xktr34ZuYfwxPpF7smebnGWhxnPKwGRfjZKYkvfS+zxu0bWJg3lAouUqProITquycI2BtYndls/37tIUWqfz2CQmGILrXHMp5p9MgVtGOPrAkM+9oGfqTTCkz9iy6/UGPGaCrPiMpZJUpR81DTBf/IcOMf/rsjj9Z6aYg1LBTRvFiQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795697598; c=relaxed/relaxed;
	bh=q3PzFJ3hbYSCea9rHodUJxc+bUxixgVlxzIsC4nrb7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc349y330QOFxdd+NXEVxq3saTr6Gbx4Lt9tK/ITyNz0lNKkin91s3hXlKfLl8TruY3cl4xZwJzadZbhPtLzQzMtXeUc45UcZw+Yn9/+mcg+PmS6wWElWPu+Ee7H3NZ2WAK+NEj1luOpm4SSu9u0EsaLX/WOajCxvMESXbO3bLblJDDXUD+GJkzIGwzMGcqwzhiXErPUV3MZj4hMu2BM/uOIuSLz/MM1/D/JqbabQfvlzcEalGqsyIQOIqn6NNe3WwDHYb+DcLEea8xvGytcUt0lBTl35GXNW0zDyAlZ4qkBdJFQIm8+e5j9MljX97s2EVakC2gEd31DpwIAFe0DAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPpEeEcK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPpEeEcK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZxL50bcBz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 23:53:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F14F60222
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 12:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A6B1F000E0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697593;
	bh=q3PzFJ3hbYSCea9rHodUJxc+bUxixgVlxzIsC4nrb7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HPpEeEcK7Qisws2Yn2HR2QKFv32My5gHCW/8A9zrInx19MWi11iDKK6VrCbEVVOUc
	 54mk7Xuyy+fUcUxmEcTpFao5KArkGJ4xRfCrwKfLM5YwpcAoW/4INXtsxGtZFZ4G5l
	 7k+xY6aEuv4JCnKsfHXJzIdh8femk6oi3DkGXYdY7RKArxdfMAZZtDybnpSkB1KIob
	 g8WDaS1mIGqnajzeLFzav47q/orkl5QZWAdJ62iMw2zuFzo3PAa2p4129pHOKZ1SsK
	 VikdTI5+VJ0uSbQMro5L3gt5zEm3hrLNyX+p8xOqjOptcU5nutkiVRi/Qq+VH/1iY8
	 iu7TcIZjKjh6w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso8958554e87.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:53:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFmEMCMzO5GoHjcgfnrC4j+Gp0IPqNqcWCBRdoiRQnTJVpcM4soO0thSFBNKd2fzKPINSQIB+Mg8agXtAc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/pNnjtkX+GbaRKwmZEjYV060Wb0dnK7wdGIA+uZ4rGyCXLkoBO
	Uvyy1ouYBNA3Sil2gask419JFJER1YeMNZnnNRy7NqDVRsR6JbGSL7I+4HYxheKWC0kVrHQ4ET0
	hICAHGQwHVTpNwJ97uHDrByd/L7fZMx8=
X-Received: by 2002:a05:6512:1111:b0:5bf:a172:db47 with SMTP id
 2adb3069b0e04-5c1bc7fbf6emr6119152e87.16.1795697592407; Thu, 26 Nov 2026
 04:53:12 -0800 (PST)
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
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
In-Reply-To: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 13:53:00 +0100
X-Gmail-Original-Message-ID: <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
X-Gm-Features: Aa3M54q-CsXp8NzMnoFlWGAu1EmQEOW5kQyf9eE8X0_RcR3iOaRDqKTNl-NFIlo
Message-ID: <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] lx2160a: change the pad muxes through the RCW override
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vincent,

On Wed, Nov 18, 2026 at 12:00=E2=80=AFPM Vincent Jardin via B4 Relay
<devnull+vjardin.free.fr@kernel.org> wrote:

> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW. They are read-only in RCWSR12..14 of DCFG, and are
> changed at runtime through the override registers in the DCSR view of
> DCFG, which read 0 until written.
>
> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
> gpio to support bus recovery"), fsl-lx216x.dtsi drives the override
> registers with pinctrl-single for the I2C bus recovery. Its first pin
> state clears every other field of the word: a board whose RCW programs
> a non-zero pad mux loses those pads at the first I2C probe.
>
> This series reads the fields in effect from RCWSR and writes RCWCR, as
> fsl_guts_rcw_rmw() already does for the SerDes protocols:

Once the review is complete, can I merge all patches except the DTSI
patch through the pin control tree, i.e. does it have the right ACKs?

Yours,
Linus Walleij

