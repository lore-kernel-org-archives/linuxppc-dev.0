Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB5606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Aa6U7TmI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb54r0l2fz2y2h;
	Fri, 27 Nov 2026 05:42:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::12"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795718540;
	cv=none; b=jaF914M7CPOHk4lP54G+nTwCkQhwz44kJ0u9dt2sUg+9ph9KEzCriVYj+JKrSYAx++pAMqtgkxqZpRnJm/+09IRUOywA2fo9VTwxUY5/o3xC7/8AGtt/N7+Ui0hxZ5Dti/FitO+YNyl7gnsgjs0mlj+15QqIqPVHMzlXoT953aIvAcQ9J+D3hcUumMGDxKj/GlRwDEf0vBpnDppGIirV3DG6b6PTKZUklHXv+u4QJNhc7VNW96sKX+DxOwpSXkNXEzSqMcV6U7pQE7Hpk8kKM0YPZflvzOMkvfl2bDMkjrIQFt9Ww/HMv1ilUj4xg8qol/Vl/SgFgApn+nWoZcxLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795718540; c=relaxed/relaxed;
	bh=TmIlGqYRKL1N0DbrflYbwLWHTPbsYPsvR4Gqt4JhWS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXZPBiugPV+agYAj0Y3QiW9/NuFK4KnLW3DyzYM++uBtwxOH7+ZZH+uAIW7xR89TNREVN37bAd9Gdm8Z3nbsK51hRlKLrt75m0zM5OEh40478ZzRTmBp6PY6+JskS6Ln0NLrGOC5SdEYJmRjUkJYNd+4Hldy02cOquqSk5FpGwzrGFPhSh2H0nfvNwjU+15lvqJ778WPHUsE4Fesw5GS4KTLnaYCbOEJ1ejQsJ0uGEKwohnN2YEByUAaliLpZmwDJGxqNKOU0o4o3NsF3WaOxKj0tb2r/bBeitXoJUVoTzoBRG9+T0IGFZb4xSF1uO1/tPWQ3VYmW9qnQi/CvKhdTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Aa6U7TmI; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Aa6U7TmI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::12; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb54n5M70z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 05:42:16 +1100 (AEDT)
Received: from L30177.local (unknown [78.240.251.125])
	(Authenticated sender: vjardin@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 60E9A13F8A7;
	Thu, 26 Nov 2026 19:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1795718527;
	bh=RdqlfcRYRyRN/alGMnwzCeIIWGVeJlTeO4EFT1U28HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aa6U7TmI2pqdSQbqnVAZ9wKX17hNwrxb7sJCGV9smHxFQfk8SZWDVGYgaykp5Bf+o
	 Opuxeg1dm6O2Towg5dhvaWuHtmKMVxBIpCDJOJUzALDj0tAlCADAWMldG++WYO4dsN
	 tDKK5u0vaKg0Hh0rViFgV+Z7rXpZrG6kvHPnaxKg9+faXcARzsIOmnPngTAZJ1RQeY
	 AZKeO66aAoBCbr2OWpSffyoctoL1hHR+Y9O5W9fT+//ct768q/Pc8Nn2hEz+EkLXrS
	 fh+6gnFi83iGV1NNb8Hvel5dZrW6Ix3LBfLHl8lPGGBHCoQYeaY5+SmE2AeSVI3HwU
	 ecFfi6TA2wvLg==
Date: Thu, 26 Nov 2026 19:41:40 +0100
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
	imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v8 0/6] lx2160a: change the pad muxes through the RCW
 override
Message-ID: <awh9ZB5V3vG0gg4S@L30177.local>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
 <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
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
In-Reply-To: <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

On Thu, Nov 26, 2026 at 01:53:00PM +0100, Linus Walleij wrote:
> Once the review is complete, can I merge all patches except the DTSI
> patch through the pin control tree, i.e. does it have the right ACKs?

Yes for patch 1/6 to 4/6, however, I believe that 1/6 needs an ack't
from a DTS maintainers. The status is the following:

- 1/6 dt-bindings: pinctrl: Reviewed-by Frank Li and Vladimir Oltean,
  but TBC if any DTS maintainer Ack, is needed ?

- 2/6 dt-bindings: soc: fsl: Reviewed-by Rob Herring, Frank Li and
  Vladimir Oltean

- 3/6 soc: fsl: guts: Acked-by Frank Li (fsl tree) and Christophe Leroy,
  Reviewed-by Vladimir Oltean

- 4/6 pinctrl: Reviewed-by Frank Li and Vladimir Oltean

Regarding the DTS, if my understanding is correct, please,
Rob, Krzysztof, Conor: could you have a look at 1/6 ?

Then, the two DTSI patches, 5/6 and 6/6, will go through Frank once 1/6 to 4/6
are in your tree, as he wrote:
   https://lore.kernel.org/all/awebHKtul2FHepc7@SMW015318/

Thank you,
  Vincent

