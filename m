Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A40606A32D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ik6dsrXJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS7n83NsVz2xGr;
	Sun, 15 Nov 2026 22:19:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794741580;
	cv=none; b=Wj09BKtz9As5IyvN7ei0kWdkFHCKN57MWES5Ogup5sqqp5wihJFzQV/F1YHos3qLJoyqGFkvK6pQ5A8RBgr5tBNWiNLUtycI0T2Qj/WXki2tuOBFVL5UXbbbVrNhEheryAMiuHCbigow9cGixTPSd4lOPaVp5NZxrwzSyyMw2gw17cGWQlFGzRMo24DAY7Ku2L0hIY7hDA0grxzFI7FYFrWB158P48dSUiEuo6s5n0ycN8h7uyYRq+MK6NM7IucF0T7o0tHR6z43dC4adENTt7njkmEHJJilmB2XHi/hRrg+oCapRYg1mQC3S2i2tQDohq8mMndNdbbuL6NrXf7epg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794741580; c=relaxed/relaxed;
	bh=I6M9drfNN7zCNsaSrSObIiphbvQS2j9fYF//SvIIVu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n32tMPuwpxeCnHI/ZR8J+2iI0kUpNxRrBxuYgL0c4oC4UJZntPY0coBPDhlsrHdKDfvcbDAZkPQ4Z7akziw0uBUWxim6IqeDqWrqqIYS/AGbs1VumCR3n1uD+2NGd8r0KzqsudLeMZLYr873ZbhxeZ4DlWmBVZQm5WgQq3LljyrmMImG3V1g+HZvqYKyIsopcOl6JJs07an3G+4zpzkkO4NhaniCPe8mtOONHzjdmv5LBO9ZKyB4lVkSthhLe1Nn+JA1i9Dl+baYZWQopisekNDecAphTRL77sd0d90jmbaBWeT4uX04ELtbasOrT8I0GoF+kKB3wcIwoD6ND7b+Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ik6dsrXJ; dkim-atps=neutral; spf=pass (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ik6dsrXJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS7n61MK3z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 22:19:37 +1100 (AEDT)
Received: from L30177.local (unknown [78.242.88.98])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id D792CB0051B;
	Sun, 15 Nov 2026 12:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794741571;
	bh=JQD3/EFXCa4lxF1FzAPYk7PWu+NKW3cxCD9tTy0x1cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik6dsrXJYrk/VQXyRed2GD1Pp5tDkQSbJ83ictljm1FKfb4Ox8x+nlLt0T2YU9kJR
	 rvmjalYzY7TiZJfQAbCUy1e2Zt84pL9OLjTa20g1DK2yews6kwKo/vq20kUD9jonZL
	 C46MPyDT7DhMhbvQOOqe6zl38xuHODDxKCvm8MTp8HuV003/CEC1zxqnvfncFbp4uR
	 TOIgfbpbbZ1do+E1PYz0KZTcBnbc79rLlddNWRWGBeCMkjN3nAjd7ARCpRdywXrX63
	 xo/tKnRt+jx2nfY5H7izHPB8sfV3RfaNPrIK0MBzXPHbN/jYZbsEyHnJBMRKnw+v7t
	 Gn8OC0dkrijwg==
Date: Sun, 15 Nov 2026 12:18:57 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
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
	imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avmVIb5-l2DUq75m@L30177.local>
References: <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr>
 <20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-3-eefcea066a55@free.fr>
 <avi9N8P34X5uel7a@skbuf>
 <avjy-lCL2A9gEhcL@L30177.local>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <avjy-lCL2A9gEhcL@L30177.local>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

Le 15/11/26 00:47, Vincent Jardin a écrit :
> Hi Vladimir,
> 
> > I cannot agree with your API proposal. It exports to the rest of the
> > kernel a blanket API for RCW override of any RCWSR1-RCWSR31 register,
> > *including* the SerDes fields for which the fsl_guts module already
> > exposes an API. So with your proposal, what can be done with
> > fsl_guts_lane_set_mode() can also be (un)done with fsl_guts_rcw_override().
> > The possibilities of abusing this API design are endless, and I don't
> > want to have to deal with them when I can avoid them.
> > 
> > At a minimum, I would recommend renaming the API as fsl_guts_pmux_override(),
> > and make guts enforce which register fields it permits overriding via
> > this API. Example:
> > 
> > static const struct fsl_soc_pmux_mask lx2160a_pmux[] = {
> > 	{ 12, GENMASK(29, 0) }, /* IIC2..SDHC1_DIR */
> > 	{ 13, GENMASK(29, 0) }, /* SDHC2_DAT74..EVT43 */
> > 	{ 14, GENMASK(10, 0) }, /* EVT20..IIC1 */
> > 	{ 27, GENMASK(7, 0) },  /* EC1, EC2, USB_EXT, GTX_CLK, SDHC1_DS <- your series is missing these */
> > 	{}
> > };
> 

I did test it on the board and sent the related v5 based on your suggestion.

For instance, when I did a forced bus recovery of IIC1, it
moves only its related field of RCWSR14, and the first override of RCWCR27
does not touch USB3_CLK_FSEL.

The v5 is here:
https://lore.kernel.org/all/20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-0-d246166ea469@free.fr/

thanks for you help,
  Vincent

