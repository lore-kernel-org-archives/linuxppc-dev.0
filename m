Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922B606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0SQ4rzU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR0PX1jPdz2xSS;
	Sat, 14 Nov 2026 01:43:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794581024;
	cv=none; b=RI3xwz0Dxg/anGBgfjh0LYSe+QclyopKfTPHt4ZL3B0/GqAZ/zwcJdZkEDg0HKlvfFMV72X/ZFvww/W2DFIOnttk1il0JfPDU99zwxLrPV6GVEPvdDObOUydRT0pnRzOeAxOrthF8Q1GlmsgugHbh0TcMFKas6ojFBKvP4rZtedzwDBflrG1R4Jc8VoIBCYlL5F9Ed7EG0O69GdGptjVcbc11Hq+cJG3PyyBzRhfxi1CqWF+WQHRAZqsSGltLCN1JRG78Q7uaqszTTOl5FhdGiwFzzNnwcRNo6bSImqXyUfh+pAvz+loaRAfTrEJUHBIKLUiFslfUgDXvHNALKhAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794581024; c=relaxed/relaxed;
	bh=+289KWwCUBwSGViqjea0W9Qg4FPkLuVGVzLN0NXnagA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPhzTm612Nf8l8Nsvko8BL0za1hHwaOpBNpvocvned7tEA3Mozxzpyz2H3mzqCYxj0SxjHZcNtEs1wrsPPohhZypBOTotnaVXmHegINbb3whHHip2BoPWvD+2H/Y+VfWbWvbYqftDppwIS7CPBiFl0t2DKtkdYXZejNS2GwJ9gl7abBYNPtd+xEqE3TZCJ3fYcxIOWCT5CvSuZuBmQl8hKIteLHF7XzAcs0Xbum7axOrE5o0tZ37HGLenhTkq3f6/j39sh/Z3H04zyq+gtlTHsA7rnNJKchoh5PXbA43kbmHEuulRBzbxu3tKNE5bRxJVPIucGEWxGSg44vVshd2DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0SQ4rzU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0SQ4rzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR0PW3kq7z2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 01:43:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A4AA3618AD;
	Fri, 13 Nov 2026 14:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF71F000C4;
	Fri, 13 Nov 2026 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581021;
	bh=+289KWwCUBwSGViqjea0W9Qg4FPkLuVGVzLN0NXnagA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V0SQ4rzUxRzFRK4g6VJ+CGzkMySQWEIOsnv+rTId5imAOTMpxQVu2tWEoGRe+VKZa
	 M3I/THA4Z4IDr7qOLGvsMsB1pz3ZhB3XeOBii5bRqjS5g83uE0zJiXc7azAm2HykXu
	 kCD8wPuEYWNFbWX0MQ84R9EONcwGKB3leipchtAFgOwjoFn3ErDYlTsC/hFpwkabNQ
	 R8jiOHzpqqOpSV7vaqypxlRDTTufWdOUWIEn1mYJHL+LNlxRR8dDBU78rpawikdGrC
	 scVfXK5Hj0UKxwxGRb+RhDhFkkNdeHjbGixvCNTMsn8rBjZUoCWQ19aL3UA+XvSMog
	 3D4liuRvDh1QA==
Date: Fri, 13 Nov 2026 08:43:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: NXP S32 Linux Team <s32@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>, linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
Message-ID: <179458101851.831300.17996837915217986690.robh@kernel.org>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-2-5a0063f1da9e@free.fr>
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
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-2-5a0063f1da9e@free.fr>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sun, 08 Nov 2026 11:06:50 +0100, Vincent Jardin wrote:
> On the LX2160A the DCFG node holds the pad mux, overridden through its
> DCSR view. Allow fsl,lx2160a-dcfg with simple-mfd, so that the child is
> populated, and the pinctrl child, on the LX2160A only.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


