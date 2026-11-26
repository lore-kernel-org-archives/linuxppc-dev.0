Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC293606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pKiP9Bb5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZybm1tN1z2y2h;
	Fri, 27 Nov 2026 00:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795701012;
	cv=none; b=iroqDgpBsOpM1YjSA38WqgdZh19OvGFG/Xq/zJrehXZOstAwHcaPhkqlX6jqWILUN55ia8NDyt3Nd2ocTsTSfoXPHMwY+7zbFPxjcNpLHMnwMfCpNYAH9Z93t4pEt2GoH8qcRohh7bw9FkAPbUUiQIqiA1ld2AypoPenxRZPI0YF4jFyzUEafNYKX9iT9hMqf4GS1/pWOM2I2FusEn5kUO8k2iBngKU5eno6hN8YaSySRzr2pKGC0lcLa4hrFumbc5dFHlUjPnLGF2O42vYWO2LST/8In9bRk4JmkSOZh5+Ina6ZsW7NKhDMDtL2KLM9fKKTDOsXPAxPr+8+4LFAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795701012; c=relaxed/relaxed;
	bh=ayDmQOMbnPDID0tnpH0Cz9zV9aQl1tR/L4IizHW7J4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDkGvA1C26ghAwt1WLRdeNGDmnJCqG7bk0CrJTti0N/C4wKHyGiFZ4IttDlLOrzpfo6zwzTg1wdot+pNX/2aoMZQxY9oYRKvHqcXZV6X4z0onLUm1Q98rIPOfmx2lop8Y/9RedmPSlv9v8hqENhBe5E2yXcqYhER4u5H5GR3+bXfFSojqmToVCKTu4qWg0wND8NQfbxTcc59KqpIoBH2A3j7yBcTbVpvinspYq9nm3br82/FXLqwGvzmwOC7rSIkztOrzhjDdVDx2r9yAvOg22Xk45NpBAgmVuWHDaq53BOycegR8/6xPFZ4gbggGdAjWS5+zcf08B6nQUehMnrWjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pKiP9Bb5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pKiP9Bb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZybj1rJpz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:50:07 +1100 (AEDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-491846221ffso6129921f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795701004; x=1796305804; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayDmQOMbnPDID0tnpH0Cz9zV9aQl1tR/L4IizHW7J4A=;
        b=pKiP9Bb5EydkzmEcltKVDfDxdXNjX8hovH3IaP4/8eNcl5zqN244YJXu3WS+9UXVgW
         U2/94yC9nfImfulDy8Z81WmGFC+dNyB4fuDW0CMDpXEQ3AyjofpfwuPC0qOpzepnKgjT
         JwAG+Hnr3SmDlEiAV8NNCvLYM03tcXDDuoeeW6JdNG+3Z8fm2y6/gox+pWjVmhd8NdLN
         S0lC+pKCIxwYZtgDJKzdScHs5HrZNp5v+uMnVJXTYWbcorjbK0mchOU/+HE9RaLkZ9sx
         w/zzGFqafLar6NRVFbwjLGNprQe8OzK8H2PBtD9hL1Hi/aLISLBcTXAGZbyHM/QYW5Tw
         QfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701004; x=1796305804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayDmQOMbnPDID0tnpH0Cz9zV9aQl1tR/L4IizHW7J4A=;
        b=1tijrHMBMt8T+ODN91CwBE7k7CEeMWG/QxW/Sh+ZvERUn/1E3R9UOWxZw6XRfbHYJ6
         sOFzy2YTEioswMwlP3bbxfy9e/VfTJq61L+dMnzXCCjb3qwJ2jHWQUH7UAgBGBSEhk+h
         6iW4Wh3Aq/n7z8KbAr2+Y4NoAX2w0csv6N31Dg8iPiYeSAVSv8U7j1+rICRc4UTqDgZj
         t2ofl+HM51GbNu1+VppCdnOnOVFOw2iCL3E9j5bMJgsaNJP0xyRQqiRfPcotUWiddph8
         AJPVAR6AzplcsaWT6mDUjvusxUCri26KbmKYzZtZOpQOn++/wvM4S3ZQMiuIJb4TJeJQ
         WVEw==
X-Forwarded-Encrypted: i=1; AL+hErH015XH4HX7r26fgT/R/60J4KCJkZmLBLz81lEcm4hTL5bsj5EXd40PGlctwNjkmDxFi9oqod3ItyRb5G8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9BrwHf0W8M0AyrzLPVipKJHLN8ExIcVQoPVwksM96M8TRE/nKj
	q14RtBEZMrYtDUPQ86iSXeiKGBzy4ZigV8nlDn+rnXkKiU6WgkqH8Y8aJ/sTtwxvTZ0=
X-Gm-Gg: AZFdTZdW2gpUnySjC0vMag8V/nm9FZjhLaKWbPVssqiv6B+1CrsUwRXhYL0aZfnN+D0
	09DE7+ralRdrBNn7C1awxZoJx8snaiS+12FyFgXhGzpvK75L6kYgCygnzDLUR08sFMJUPIOokPS
	qxIzqBdh7FCJaxAIwwaO49XszB2RpkDaevIZGcZs6AbwUOnTwh1o/++ujzVJKt3M7uuJmNRIenz
	tFg9tA9XGTnP3ewl0QgUwX40rlloNrWhi7s1zLdE4zUwlZC1PIRoNw2ZcM8iE8iqgx0FnGje2rb
	ASPMv/YP4l7HwXwJ3rtv440YdvwCMgaQlsmkl647Uzu/Oj0R0GJPxdVk6lHLPSwM8j1LxCldeI1
	3It1gHToNyh6zJoAmODD0qzu8X9nkIdb4HqF8wGEzQMWeIl57sof+pVpYTP4J6rNavYzEpmYdYT
	S76Q4+WqubmnVTeTnjRdcXg+13gcFGHvWwZd/fmTY6O1thgR/1ELV5UAulXFQB0r24/cDlDcWe5
	wp0duvtWtxtsk7uc1sio3Z2A6xBXUUGxv6Dkcrvj2+Da5GGYgj2K4lcAy6J+bLrTLITrWop2l+i
	6Wt04Za9l6Iy0WH34EXRYvs9LVPQD1vtjvhxbgKmExLNxa2SnE3baVAWnZI8zYdLPQDYdyq9Grf
	tepoEa+NbmOoSJN/jD1douBswcN1ACR8LlDx/
X-Received: by 2002:a05:6000:4b17:b0:48e:f47:273c with SMTP id ffacd0b85a97d-4abaac57a40mr41489070f8f.8.1795701003612;
        Thu, 26 Nov 2026 05:50:03 -0800 (PST)
Received: from localhost (p200300f65f19a904aae808b8a2e91502.dip0.t-ipconnect.de. [2003:f6:5f19:a904:aae8:8b8:a2e9:1502])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm40247966f8f.32.2026.11.26.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:50:02 -0800 (PST)
Date: Thu, 26 Nov 2026 14:50:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Takahiro Kuwano <takahiro.kuwano@infineon.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Joern Engel <joern@lazybastard.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Michal Simek <michal.simek@amd.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Brian Norris <computersforpeace@gmail.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Han Xu <han.xu@nxp.com>, 
	Paul Cercueil <paul@crapouillou.net>, Harvey Hunt <harveyhuntnexus@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Liang Yang <liang.yang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Linus Walleij <linusw@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/10] mtd: use desginated initializers in *_device_id
 arrays
Message-ID: <awg4ubbFu0FksThB@monoceros>
References: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
 <awcZcuSbse5g3FWK@monoceros>
 <87v75jyiw2.fsf@bootlin.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjhsfzw7maxs7oq6"
Content-Disposition: inline
In-Reply-To: <87v75jyiw2.fsf@bootlin.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fjhsfzw7maxs7oq6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/10] mtd: use desginated initializers in *_device_id
 arrays
MIME-Version: 1.0

Hey Miquel,

On Thu, Nov 26, 2026 at 11:41:33AM +0100, Miquel Raynal wrote:
> >> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> >
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >
> > with or without addressing the nitpick I had for one of the patches.
>=20
> Let me know what you intend to do.

Your mail was sent To: me, but that was directed to Pawel, right? (FTR:
I intend to do nothing here ;-)

Best regards
Uwe

--fjhsfzw7maxs7oq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsIOQcACgkQj4D7WH0S
/k7VGwf+JohDT6rUS7ETNio1M8Z7P9mW/dw41gur3gOUE8OBNxOfsasQ0n/riOvo
4sT4fsGJWgm+ezHKcYcrXNknVg5Hmfpk4HeA47K1y+P9G6LhwsBLtqRGMM/7dCMd
nWmBVR77ExMyThLv6M2Li7HrkLHKSnuq7/HXqOD93OrqD6YYrrRBvTsBklbEdhWB
wm40UJgQd+3R2Lwq+CSDVUYqVGj8LP+XGj2vNoHXEfGlk93ZED7JguilGU62561G
N5qNDGfQC+CzqYC7tQ2tj0TNnOK6kYXrK6jxThQovh4ubLadqtHT7mVLa3qbS36h
iO7uFgMsn6ww6nNgTXKWH62VZzkJPg==
=6HjX
-----END PGP SIGNATURE-----

--fjhsfzw7maxs7oq6--

