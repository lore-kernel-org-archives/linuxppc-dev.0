Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D76082BDC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=MqjfaUek
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJvTS5hcNz2xSZ;
	Wed, 04 Nov 2026 03:41:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793724060;
	cv=none; b=ADUfSbpuRJGu5Q8L7F/fSQLY6Ltn9Ihn/CShfRsmYShKf3aJO/48AkFQeV7/ufwuPBVIaUzzbsx8u16LFH4v0Kc26hkDvlBzViWChFCCVpSaGinX573deCoNYgnYJTV85K14uizUIQWeafpcA1DGzbNv//Ayj7aBuG+SSUTd7Jpc/3kXgjuQlh+RHhWZXabxhC8zkcWbEGFBvhXraiibff3lKaCpWv3HoRJmoPu/Z5r8u3A+ZlKecFIiUL5RX4El7iOMS0IdNOn56cfmrIckRNaNsd5Vy3Me+lDYXJc2WkWUFQVeeybc1GhKpkXpBgIV5Q3s1Vsh9GQdfgw5u+6wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793724060; c=relaxed/relaxed;
	bh=Shr2teq63V8P7ushHBYXKFTTJfhpOja4aluMgZ/Uw+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGb13La694XCVg0gL6gFVNLlRtly8opobomVwUoOXfJYBXOmDhPoMnAyzn2CGrAxuw1cgS1KM+cmUvZCCQd7weW4FqLdmP19yMuSoga9zlXtNjCtrWVD6QOWzCaUl2UFUahAYBIY82ePfqFlhQzMl1DXr0nVwVsLlE4iQouI90Mc1lm1AVhQ4aEqtwS0q2P/j+gKAxr3K/S+X3drVWza3Q2PdZTdsiUowhOWAeW9tmQgJ6Y9QgRjpBs3LQJzaBKkSHDmG2SKtqPHeACqGeVl4rKPHKKwNTaGJCKDWhkeH2z5HiDCII9+d/ED3g50tJXnNERaP9g7k2LWpOdWk5MqoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=MqjfaUek; dkim-atps=neutral; spf=pass (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=MqjfaUek;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJvTQ20zZz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:40:57 +1100 (AEDT)
Received: from L30177.local (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4F8F4780395;
	Tue,  3 Nov 2026 17:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793724051;
	bh=hIo5wKJPZnjho62FTKebqDa+KdYP3W8K2TKY9Ek4sYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqjfaUekQFvuCKTt/CUf1BBopp/kcg5M3iZ87uBtd/nRtKnBJfAp02aoxBl7fM2h3
	 S9tspLtn+2miYvL3O33DMvrKkdk3IixH/NZrAhZFJkJa9lEUDrc3klMlJ2Tu8fPrqP
	 hyG0EmOouYs6CWYUmATZ1eGbbTdIieM0rWBoegQDVorc8DPHVETgHgH1D832uj7jLv
	 4+JPhBMpxsfYp2j/i51/WozlNaSJVSJ3drk3wC3RGqqle3g35vXJCr+ux9j8XjEqzJ
	 eYK24F0ZHgsKICSoFTbPEbbj0DYsIkfrxmMu5K8DKbZ5z3NUcNUkluqP83Epb/BPzS
	 kEIgfY7oOzMvw==
Date: Tue, 3 Nov 2026 17:40:27 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Frank Li <Frank.li@oss.nxp.com>
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
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
Message-ID: <auoOe2-9wZhAad87@L30177.local>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-1-0a61a9837744@free.fr>
 <aun5TzN6kWdkr5x-@SMW015318>
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
In-Reply-To: <aun5TzN6kWdkr5x-@SMW015318>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank,

> > +      groups:
> > +        items:
> > +          enum: [ iic1, iic2, iic3, iic4, iic5, iic6, xspi1-data74,
> > +                  xspi1-data30, xspi1-base, sdhc1-base, sdhc1-dir,
> > +                  sdhc2-data74, sdhc2-base, uart1-soutsin, uart1-rtscts,
> > +                  uart2-soutsin, uart2-rtscts, irq11-8, irq7-4, irq3-0,
> > +                  evt4-3, evt2-0, clk-out, asleep, reset-req ]
> 
> how to know which function belong to which group?

ok, I get the point, I'll spread those into their respective groups
per the CPU documentation.

For this v2, I'll try to be inspired by the
mediatek,mt7622-pinctrl.yaml and the airoha/ralink bindings:

    allOf:
      - if:
          properties:
            function:
              const: can
        then:
          properties:
            groups:
              items:
                enum: [ iic3, iic4 ]
      ...

best regards,
  Vincent

