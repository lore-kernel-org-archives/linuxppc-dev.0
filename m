Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288D606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=agZnjsJQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTSX34GSNz2xmk;
	Wed, 18 Nov 2026 01:57:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794927475;
	cv=none; b=KCZBP859TgSKZb8uLT/WsZwNwmUgj0XjEgpXlAS7vu/iwnub85arY/71O9LD1xetMjpnvon8AIyGua5cIUW8bDlMyFrpe6GG3RvhFyiSobkQInqWVZa+lyyYGltXVwEpdo7CSirQpaA5O1st/K3QwHeUM6nGflxzFuyqfxBCDl1J8UqmquaTjZwkbpYO5zSl1DU8Q4lUeQ938K1Mvwe+rmpkkbSe0rUTgv+FrN4GLCrbcLxEIPPdZAIFRKG8M+++qRxbv0rrb8/plL0CIqgdTpJr8hCSsB90Vpwgd0c74phsTCNV+Y6c0PfP/JRiEixhm/bCWSf+Z0sWJuAxP0hFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794927475; c=relaxed/relaxed;
	bh=s6kZBCjfiQkhSEJV2Z1jyMjdsrciCZ6ttNX5JGYKx+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEc4GycCTFy9H3TBQy3dQBsVguDsQ09DRLUA+GhO4tCxuJXkqg7WaygSY9XUsAOvulb05EoPkEjxMejpPqwhkFQAgqDxl6FFCqzBRjJ3496zop78Rag+XCw6zXYPCpIO1RzIc77KXlsSOiWN7O+8PNl9GtTKzdqWcyIxx29hAP3688F8jFdDqN/CH4mccUGJADNd6pdS7X0p7GMEMYA8jjuDnGS8vZQ6BSgcGh/pszufbfnXmSKnO2C6Etfaxe7wE1PYrWTJkRqt7MvldAQUInhd84jzSty+xpRyCzpuVCUhWS/mau/1V3KCRAmofoH671Pa9W1J7i/xZ4TafIrQbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=agZnjsJQ; dkim-atps=neutral; spf=pass (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=agZnjsJQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTSX22bRCz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:57:53 +1100 (AEDT)
Received: from L23803.iliad.fr (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 3E5A5780510;
	Tue, 17 Nov 2026 15:57:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794927467;
	bh=Kxv9zLHW2Eb4osegyxsTaFPBbgAIfUoYui4bAAK2XVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agZnjsJQLzDfu3kiyhn9g9Sy0L9RXmaKwOcrWY/ydd2lvFoEG5S9tDXomzsdJ1VXJ
	 6Efhw+DDCL3WoiHk12XxonGtBUnHIhNCazNoTIrzAfuRtLZMQQFyFcu2UHxCjLQADB
	 hScFR3JbvNWUVxSXxsCfq5BXGNYwnbuxoKWlRjpizBFRUIXTETgyq8CAW+oQJUDFJy
	 /SsNK4xGmX5TYhdANwCFD9lfsmUCExQhiLbR3ofnBYnQDvbmme3MajAzHttOMQiJ/1
	 jY160eWve0YCnHZLGap/GtTdoe2QJs23ebh3cXWuKGWKBwbQ7Bl+Hhl8kUsHfU0Tru
	 O8KB8MTr4ysWA==
Date: Tue, 17 Nov 2026 15:57:23 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Linus Walleij <linusw@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 4/5] pinctrl: freescale: add the LX2160A RCW pad-mux
 driver
Message-ID: <avxrU7frfDp6HeF0@L23803.iliad.fr>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-4-3aad0860b984@free.fr>
 <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com>
 <au9YgytCc4TKfETI@l3017727.home>
 <CAD++jLnWcVDbh-vf20w4nfvOSZik619XqoEjXTBZ29sJkX-bCQ@mail.gmail.com>
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
Content-Disposition: inline
In-Reply-To: <CAD++jLnWcVDbh-vf20w4nfvOSZik619XqoEjXTBZ29sJkX-bCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

> > Could an ack of Christophe Leroy be enough on patch 3 to 1...4 could land into the pinctrl tree ?
> > Then, patch 5 could be managed apart.
> 
> OK let's try to do it like that.

ok, recorded into the serie 7, but then it should be patch 5 and 6
  https://lore.kernel.org/all/20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-6-5d7201970629@free.fr/

best regards,
  Vincent

