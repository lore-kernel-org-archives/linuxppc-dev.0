Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CE606D801
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=udgMF85L
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMMkb0rfzz2xrC;
	Sun, 08 Nov 2026 04:00:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794070855;
	cv=none; b=XyxGhS2XGnuk8+MseaCkmSRxlH4rXx4ukOBxMtM6AGmKTLD2bQLJ2iJHq3p0rtJJ/iWizYUxR3vzLeHB4gPBh9M2YaNrPnBaJiE6NkSahiu487SM9mu6oW1kgNkeWkG4JBNVOh7M3N3dplK1pJP7svy7dLbqjZHjeOY1O88pj+uPFrR3FOJ9QsvXuxhIyEg1bb/AI76WLzBMzoJZ880WrCcQ7CHrT7fYNVo7r+54BYDUpiL1YCClI1lekEGlhmUOGo1OuCuiiDQovVy4FNl5ZuAl8g21hYIyOLtoFU34PfH/A1I6QFttlcP+WEN4d1T2veXJz6xMpUhtOi1MJPAGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794070855; c=relaxed/relaxed;
	bh=69YlIhpcdRp84o4ABpJJqYwv378wcIs9fm+ouT0CtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foZaniYuSIIby9erf1zcHURr2ymfMDpDvQb34iN+tn20Kb24iZoLjx4uSOW1z/SM5ZF8Xr00YzNr1FD+E9rthQ7XEo6d0MIjcn5qinj7XYLFZAzb0GZXcCKr7uLQttcuYYrBx6pPiHP6k1AgOxu3es3Byyrn+EDPSpfiWiZO6DEH4DfMA1l9YYvzMsKnl05g4laJeJh7h1IV2FkKoWfSoWuR3wmGhuVABAkKlcUuRb54cpo5XgBkJ/foP+wsQdgbbeVd49CUzMnNXoKIK/6TVxVHmkyHvPjULLr0xUCnsC32zyjbSX/3XlbgqnDYr2hCPUZjDUSY/nuj7kly4XNlBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=udgMF85L; dkim-atps=neutral; spf=pass (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=udgMF85L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.4; helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMMkZ2pszz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 04:00:53 +1100 (AEDT)
Received: from l3017727.home (unknown [IPv6:2a01:e0a:ac2:22b0:71d9:bc2b:4a47:20c2])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 763DE19F59C;
	Sat,  7 Nov 2026 18:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794070850;
	bh=syJyVGNndyaT76xcg3TviaWZJbrAimIaATWckjraIYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udgMF85LazaNU0ZXoRcnJhuQA21gmX/PlbKegAK+KxJJ1+kt3COSyM4r3yyBlo2SB
	 joV2E0iybcwLRKiZcjGbvmlrcGxsmWSkcK2v5/e3MIhT5YCjV5e7ZldqYPSaac9n9a
	 xDGJv45X/pXl86eCC/AxwhHdynJkl5q/tN3nuuWtCWd89D7XzGQadqvNz1rQU4IIzx
	 7oFSepoRUUNROi/gKYXlhpl+FV/iEPGc2KDIJuBNR1uwt3vJ3451smaTQYDYSEU2NN
	 ji35jqiD+doB8aTdWL2ARgfPqfFI/dNsp/9F49p4yxGEP/N5dm5LIH/1zxtb/bT6kR
	 4lz15iEri2+Yg==
Date: Sat, 7 Nov 2026 18:00:28 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
Message-ID: <au9ZLBSJ_nTuMaVc@l3017727.home>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-2-3aad0860b984@free.fr>
 <20261106-smiling-infrared-dugong-48ee5c@quoll>
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
In-Reply-To: <20261106-smiling-infrared-dugong-48ee5c@quoll>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> > @@ -32,6 +32,7 @@ properties:
> >        - items:
> >            - enum:
> >                - fsl,ls1028a-dcfg
> > +              - fsl,lx2160a-dcfg
> >            - const: syscon
> >            - const: simple-mfd
> >  
> > @@ -62,6 +63,12 @@ properties:
> >  
> >    ranges: true
> >  
> > +  pinctrl:
> > +    $ref: /schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#
> 
> Why other children are bus-addressed and this one not? Such mixing is
> messy. Either this is a subdevice with its own addressing or not. Keep
> bindings consistent.

ok, I'll provide a v3 accordingly.

thanks for this comment,
  Vincent

