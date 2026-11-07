Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBE606A336
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=K6io2DjS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMgN6dsCz2xrC;
	Sun, 08 Nov 2026 03:58:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794070688;
	cv=none; b=IHp12NXDeGEg8hT8BCEHpwZAFxiln2Gjjlu6N7RgQ1EzCOlMs656yoOOB/HfL+0pNJJJJehqLowd9tFQWuT7bmvz0mTY4E0CFY5F1G9+0r8PbK9E514IgO6GCDxDl15LksHdBCWzUgnh5YCOjtpf6HHQIz9o00nNYU9rLnAverhoCRjNpxLu8aKix0uG79Ok3xbkaryyLHAFbyoENE2c+FAENHWOphdn92qawmOAjl7PHwCA8QGbQwVvuAVUkAtzCjUfCLQH/xCNbrWNICecTiX7PWCZXyBjDzGcaiIOqj1GRyEIksydauaNMvZw+8UzJSb/8WpGrUCGuqc0ytLhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794070688; c=relaxed/relaxed;
	bh=J3tz+cSiafPLwvvRm44v5Y4E466QIE4boG9uIUbrsH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU7LD11b/ftJ7MU5V06MRLNocIaGa3UR2WXKwrlPQuysgKnvujidCzH/ITQiKJqr2DlPRME2XENI+X6zLP/Aih/LIjDHKvAErxyqkJY13NIJ4x4sfyOyTZ5MT64mm7+k1Tbzaha1jpD3Lwyi9pXL2Alze+zmvgFWTo78CpIlNxeFBCNA7OFyoWlPy95NBPQT5uNDggXC3O+2ML7UgJKjyH/BNW5CUObGOBmUybAvRgbFtjZgbSMQu1QvCA++IJVM/qG4uztmt7w/wHzJMc5wMZkExwVtcrVHt1kxUEycFQ/Orr1hoj/iJcB4FEgyAE7ySqumDcbFWBw5EvwZgXfVvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=K6io2DjS; dkim-atps=neutral; spf=pass (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=K6io2DjS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMgL3dFLz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:58:05 +1100 (AEDT)
Received: from l3017727.home (unknown [IPv6:2a01:e0a:ac2:22b0:71d9:bc2b:4a47:20c2])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 7AF7219F5C3;
	Sat,  7 Nov 2026 17:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794070680;
	bh=O13tiZdfp/UEGvWDyX95aSMMi3lIWkI/aVlJE/2wuXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6io2DjSWYhFOZfsmOqsqU363wQkYaCYKDCLPsn1jo9U0yhsl/la94ukFdngDKeIg
	 CAswLnqCHWtAa+HWFrndk6DAUroYhIlRxK23ZEXOctOVb5LYKFtNqDkSBEPKvu/O5H
	 Rov12EgGF3LzvNgi8GwTlYCwSQ2CPRI9XBi1TkCzgyTImZMC2VUqeMtdGgN6b9GcDN
	 AXAVW5zFL1UBb06ZpBUsdUCBActaakISAv+M3SzoD23oIwniPG5CKbGDTEafInSNrY
	 2bHpKVrIyC2uDI+zmRR1KraZ8Uv8xPMk1AfFmMPs0dVYJd85cExToldBNf6uMu+LgF
	 JPjANULTh01Rw==
Date: Sat, 7 Nov 2026 17:57:39 +0100
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
Message-ID: <au9YgytCc4TKfETI@l3017727.home>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-4-3aad0860b984@free.fr>
 <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com>
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
In-Reply-To: <CAD++jL=Np+_+wTkuLCiqjNY5EBqn5qq8zKTJB6F-=1G0R+7=Ww@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

> Can this be applied separately once reviewed?

I do not see how: this 4th patch needs fsl_guts_rcw_read(), and
few other fsl_guts_*() which are from the patch 3.

There are the following cross tree dependencies / maintainer depencies:
 patch 1, 2: DT bindings -> to reviewed by Rob/Krzysztof/Conor, but bindings travel with the driver that uses them
 patch 3   : drivers/soc/fsl/guts.c -> soc/fsl, Christophe Leroy (via arm-soc)
 patch 4   : drivers/pinctrl/ -> pinctrl, (you) Linus Walleij
 patch 5   : fsl-lx216x.dtsi -> i.MX DTS, Shawn Guo or Frank Li (via arm-soc)

Could an ack of Christophe Leroy be enough on patch 3 to 1...4 could land into the pinctrl tree ?
Then, patch 5 could be managed apart.

best regards,
  Vincent

