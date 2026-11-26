Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F71606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bPhNLogQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZytJ1RSFz2y2h;
	Fri, 27 Nov 2026 01:02:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795701768;
	cv=none; b=nutdbtIgh8I1rh64n1mgl+P+sbwTugHHjrWcJXwJ+NV0UogEjfbJ4rMIYJoA8IJRi77xnjaGKaO8GvOG6RxdLj2YngY+1hazXs11NOnpTXA8W9MoWyCnE/sNc+qQjQvlOnTL4wEX/pb6130lImHEdZL+UUGGenMVVQN0fZbZGSzVOvywGbO2QRPyzzrUrv739Oj7/5hVw/XGgJsa9qXTwVErygZN3P3MXEq+yr2VU6esHVUrl7sSncmdpaJHk+HuE9WzMTYWh1GbcSq+gghx0P/nAURACZSA3qHHpmjzLgVXmw/Cnwp2NVGjJm3MfkQhRSazazJYs6P+gY7KA1M9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795701768; c=relaxed/relaxed;
	bh=Z9epXhgk8kv7aYQ6eP03FOVDBcgOKKV/qAqVe+wwWl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BV7wErntjs+w97+8Ow8lwE8qtBkSt3IQYTNG8hEtC4koq16PFmSqTqmNTQcTPw4p3S7FcrOoOCiRBAyzWc0fRpTE8FV7NOA3tBYJRXKeYURk4pHacuVvf4nu8BKum1CYF/y+KW/5Wuxn/lwXwy9ZFSk9HDOdMSHzGM+6XZu7ZyG0CjfyYftnn4TZdwjYtQTYfTuDAhzjy+urtlz6Iei9qioDTlt6QZwR/uNiF+x+OQr1cfAoZqr6X+lX+BFbR7V4xJiCRIV2QxvanRcP6aw5327o166SDaTFqb5q7SzhcI7v9eAg9y01qMgwU5DUMylWkwQn8+o2khpj6P/WwvjBiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bPhNLogQ; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bPhNLogQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZytG4l6Yz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 01:02:44 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6ECA14E417A3;
	Thu, 26 Nov 2026 14:02:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29AC060767;
	Thu, 26 Nov 2026 14:02:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14CCD11E6830D;
	Thu, 26 Nov 2026 15:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795701752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z9epXhgk8kv7aYQ6eP03FOVDBcgOKKV/qAqVe+wwWl4=;
	b=bPhNLogQ9VWimdCUOLB8QGQOQKOA3q3LOuc60lOK0VxQoGWyHNk3em3u0r79Qv2TJe9Cfe
	20qCy8RMXQUbTvgUz7u/7GfAYOKn/ewG8lLFu1QNf0WJgIG5L+UoXthH0jZDMaXvtyNszH
	N5Bcx2KVDBzThX5FDojZlNOhuwVnM0sVHkNJbJZCwV74cJVQkY6V6c/maD7VQYU6JV9TrJ
	KF7VqiJWveeytEpTWXy3Div1ic2cBtXKpikJf9lQRxH107eQAczaA2QJr8uQnmof/znVZK
	O6ZxG4QnWxNVw7k5esZ5CwwQb0hvFl5swQjUAt2M+XC1/yMdKhU32mauWb+i2A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Vladimir Zapolskiy <vz@mleia.com>,
  Robert Jarzmik <robert.jarzmik@free.fr>,  Alexander Usyskin
 <alexander.usyskin@intel.com>,  Joern Engel <joern@lazybastard.org>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shrikanth Hegde <sshegde@linux.ibm.com>,  Michal
 Simek <michal.simek@amd.com>,  Nicolas Ferre
 <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Brian Norris <computersforpeace@gmail.com>,
  Kamal Dasu <kamal.dasu@broadcom.com>,  Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>,  William Zhang
 <william.zhang@broadcom.com>,  Anand Gore <anand.gore@broadcom.com>,
  Kursad Oney <kursad.oney@broadcom.com>,  Florian Fainelli
 <florian.fainelli@broadcom.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Ray
 Jui <rjui@broadcom.com>,  Scott Branden <sbranden@broadcom.com>,  Han Xu
 <han.xu@nxp.com>,  Paul Cercueil <paul@crapouillou.net>,  Harvey Hunt
 <harveyhuntnexus@gmail.com>,  Keguang Zhang <keguang.zhang@gmail.com>,
  Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,  Liang Yang
 <liang.yang@amlogic.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Kevin Hilman <khilman@baylibre.com>,  Jerome Brunet
 <jbrunet@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Frank Li <Frank.Li@nxp.com>,
  Sascha Hauer <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,  Manivannan
 Sadhasivam <mani@kernel.org>,  Heiko Stuebner <heiko@sntech.de>,  Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej
 Skrabec <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
  Stefan Agner <stefan@agner.ch>,  Lucas Stach <dev@lynxeye.de>,  Thierry
 Reding <thierry.reding@kernel.org>,  Jonathan Hunter
 <jonathanh@nvidia.com>,  Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun
 Hung <schung@nuvoton.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Linus Walleij <linusw@kernel.org>,  Kyungmin Park
 <kyungmin.park@samsung.com>,  linux-mtd@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linuxppc-dev@lists.ozlabs.org,
  imx@lists.linux.dev,  linux-mips@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mediatek@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-rockchip@lists.infradead.org,
  linux-stm32@st-md-mailman.stormreply.com,  linux-sunxi@lists.linux.dev,
  linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/10] mtd: use desginated initializers in *_device_id
 arrays
In-Reply-To: <awg4ubbFu0FksThB@monoceros> ("Uwe =?utf-8?Q?Kleine-K=C3=B6ni?=
 =?utf-8?Q?g=22's?= message of
	"Thu, 26 Nov 2026 14:50:01 +0100")
References: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
	<awcZcuSbse5g3FWK@monoceros> <87v75jyiw2.fsf@bootlin.com>
	<awg4ubbFu0FksThB@monoceros>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Nov 2026 15:02:08 +0100
Message-ID: <87a4mvwv1b.fsf@bootlin.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Uwe!

>> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>> >
>> > with or without addressing the nitpick I had for one of the patches.
>>=20
>> Let me know what you intend to do.
>
> Your mail was sent To: me, but that was directed to Pawel, right? (FTR:
> I intend to do nothing here ;-)

Yes :-) My question was indeed for Pawel! (except if you have plans for
the sentinel removal ;-) )

Cheers,
Miqu=C3=A8l

