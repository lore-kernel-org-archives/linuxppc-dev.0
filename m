Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4C606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxivgSKK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZdZT0Dydz2yCS;
	Thu, 26 Nov 2026 12:02:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795654976;
	cv=none; b=Yfra2KHHHGdSh7d308Tla/SEoNirwbg0q7nSboS4DF3KItpQd8O/o4c38MWscbUdPM5ZyYJVfw0LfPrVbX/Ln+mJvUj+xbmX18f4vjBVFlwT26Dih6ZOExcR8v69HBB01Mc04qMUF91+w0nJMQu3g6zuL9TMWALZ1G94xssCP8udBmmvqq1vikZ9y28Yot7etsyolcGJXidaR26Anw8ZtLeNU6wqedStjfOpkDHM0WHFDHB4hHh0uoeVAuEEtAVlvZutn5DD7D22XXQNQGn1T8wjHc/GZQx+Bl6hCeVciKm7jS0GtHWo+d+WKE/LVlDacMsS0b2b8aGaxql/ipRsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795654976; c=relaxed/relaxed;
	bh=szOvPNyxohILp8ypzy0QBe0wsGgv+77VvcXMFL1pBiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WofAFxV1BHFPtYNROVUT7UM4Q70aw4D6j6D4CvDXyEmKnqACQtR1JZC6EZ2h4UQZ8jtP5YWArFFTk98ZlQtjsdMMxj29UaZOicZc1pWNELlV07uMfyu4p+jDPOX9pEbwMcZCbTiR0AL/laFyljk/bcXTAKokGYZKw7v007Od6to4QlJ0Eys/rlPkFfI7iRjh1r/neL3+z+ku6CD84dJcs7SNUjuQS3gDfbVsXtlb1sqFsIpgof2/j4ObddDYk1oVbmJkkwvkyYQIOwnu39UPLgPomTRnG3C4mdkhhcrsyXnqMIE7RbMFJCzidkr3TSwPY5rgAspP1MJm0/h3it0qKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxivgSKK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxivgSKK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZdZS1NMDz2yCR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 12:02:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB75C61E97
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 01:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7E41F000F4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654972;
	bh=szOvPNyxohILp8ypzy0QBe0wsGgv+77VvcXMFL1pBiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GxivgSKKpMAbosqUk66Yg4iqBddCw16F7dBmuZ/OIP0+CNyedhqtebgAKbjN+lZA2
	 XzrsTS5KEpJLSeD7i+R2egKS22N6blaIWVzB/WxRu41zP6lA0V7+QCkPZvpkqw7h5Q
	 DcOPg02AYjxyC9fGtPeZRjn5JjC4cMvQzgeZQxsOnejhZh008h9JVM8EDPJVQul17m
	 7Q/84bX6YEho/gL8wI/w9xIbCWrZKQ6eQ6loBY+e89YwfZc5xTsc96jiVKhMtbisPC
	 5IYou1zn8i7X+GbyR/XnCH4jYewJzSOCfd0jwZdQwc4RUmVL5gRGW+fKTKoc70yQ3j
	 Fom+4k4F7afMA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c102ad8420so3443562e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 17:02:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFQ2g5WsI2px2C8nEiWjSGrlNF6DYLB0xZdEv/NDu3iGm1c7c3fisF3E89pokcJp3LfR1dThwkueAed5LA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8FuCIVl0brym0UAqHvRV0Qfi5piY0Pq6VWOsHTvbGirBAyRIXe
	gRCK1uOGbYHyIU102DLPlJzmtrBLxlcS1kDiHyyozAavJfjCaSZnGH4U9Gf328B0rK/gP1LGPTL
	npirQj0cB3oAo9SSNiL0zrTMKVFZ2Tb4=
X-Received: by 2002:a05:6512:b9d:b0:5c1:5975:a6d0 with SMTP id
 2adb3069b0e04-5c1bc813d73mr5576689e87.49.1795654970525; Wed, 25 Nov 2026
 17:02:50 -0800 (PST)
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
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-3-fbdce4565a5c@free.fr>
 <avs4l1otw6ACW5P4@SMW015318> <avs9fmJqYShOIPMK@l3017729.home>
In-Reply-To: <avs9fmJqYShOIPMK@l3017729.home>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 02:02:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLnF07h3Ng5O=xcgKhTEkV9ij2ptzktAfi2Kt45smdEjpw@mail.gmail.com>
X-Gm-Features: Aa3M54pY2u0gcwGTwDEHxrFaQf4DHIpe5Fj8K7AAC6iAolS08Y7XLFFoVNzoAr8
Message-ID: <CAD++jLnF07h3Ng5O=xcgKhTEkV9ij2ptzktAfi2Kt45smdEjpw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] soc: fsl: guts: add the RCW override of the pad muxes
To: Vincent Jardin <vjardin@free.fr>
Cc: Frank Li <Frank.li@oss.nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
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

On Mon, Nov 16, 2026 at 6:30=E2=80=AFPM Vincent Jardin <vjardin@free.fr> wr=
ote:

> Then, since it was unclear for me if the patch 1..4 are through
> pinctrl and 5 thru imx (please, Linus Walleij) ?

I could do that as long as I have the proper ACKs.

Yours,
Linus Walleij

