Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27780606A898
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1s8OUdm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR0Nx2ck0z2xQr;
	Sat, 14 Nov 2026 01:43:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794580993;
	cv=none; b=Ihxaq1JLjm6euhLYcZRLiA+9mYX+uIMnBSzR9br8BjSlZuLB0vwejDIy0dEg6n2KJ4W4IyGOX/GTDyCdZ1n7rHlwordOXB1fSSiA0polUx38ANRJtDG0AfPReESiON5kRW6a3Mv3AfAFYjcfxsB8ayDVjBX0nbX3/05XKIesvakl8WbecwdZtVwsbTNlx2/FWP1AI3z/sh8hBKg/0pfSqycD9tCAhkQhufjUDeHQQFuTFoHDBkelBYVAOjMfZeMjcb35wWOhK7zPohawIE46tMI/WQsaEU+C9oQ4X+kUfetYFcdsORiKQdNx+kMRr7Ff1dKqnht5ZbsAJS1lOcPUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794580993; c=relaxed/relaxed;
	bh=ZeJA76pSYL/29D1SUxOsf1XnK3pl538xdtA25Rrvpo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc9Kx5oiCIRjj4YxxInz1Sze1pY52/435D8U1/EX4t/bp7D0SoTFzwTXO4bgv+EfwI2RuG9cZjqrtuo1cSeERf1/vgPnmBQX82CK5D1MlX6vtdD/v+ftOTIrcHVVu+bPRg+EjaGwwa5cz3wXrG0dldwoVH7S0hjPDzTxjdADjYRECRxBo2wuCmFLGDCAUQXflD4Xy6pDIiNGK0zK5WePA08WNzegUhgfm61b9QdqwwQQoG+Lsbr9jEHMRhmdCx70VOYY+1/Dyk7cTchJe4WPTNICZJ2pPSpnYH4UpccI4vJfNOXoKURIA9y8dm53Bx7NOK7ja2M2aj0Iu6HCx7rf5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1s8OUdm; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1s8OUdm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR0Nw4KDqz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 01:43:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9959460F21;
	Fri, 13 Nov 2026 14:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF81F000C4;
	Fri, 13 Nov 2026 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580989;
	bh=ZeJA76pSYL/29D1SUxOsf1XnK3pl538xdtA25Rrvpo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m1s8OUdmwP41N/y2KWKb5jHCOlvKLqkZBWbDu3E14YEh5d76fNLkhxj1nUGmB5chr
	 7Sj0wBrGftxeG7S73VUUhCDhVwtQ0KlbpL/3bWT4vz4d5kYedh2cXX2pqCpSoDU0hI
	 urYVSrcZI0pIHIlyazLa6XUoGn8nmLbNcCCJUQFlZefVZQnzqdqI93UQHPfuoEJ72E
	 pDsYdbop+FjGLAmzwafXZt801QB6887kHaxQ5XuTrp4EE7sPTZAIgVeMb8mh7KTU5E
	 Eu5kZT0S+YCgXQTzWZEIw4F2HVmyIjNvEuD+V38wOUZkMqUCgKWGCkPdYuTnm2lXSe
	 3hAQ3kpK5bNTA==
Date: Fri, 13 Nov 2026 08:43:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 1/5] dt-bindings: pinctrl: add the NXP LX2160A RCW pad
 mux
Message-ID: <179458098591.828545.5346870650734056259.robh@kernel.org>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-1-5a0063f1da9e@free.fr>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-1-5a0063f1da9e@free.fr>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sun, 08 Nov 2026 11:06:49 +0100, Vincent Jardin wrote:
> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
> fields of the RCW: read-only in RCWSR12..14 of DCFG, changed at runtime
> through the override registers of its DCSR view.
> 
> Describe the pad mux as a child of DCFG at its RCWSR12 to RCWSR14
> window: the override registers are at the same offset of the DCSR view
> of the parent. One group per RCW field, one function per encoding.
> 
> Each function lists the groups that take it, so a pair the driver
> would refuse, such as can on iic1, is refused by the schema.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 264 +++++++++++++++++++++
>  1 file changed, 264 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


