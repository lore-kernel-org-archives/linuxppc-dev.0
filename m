Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1218606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUrI1d5y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLf3w2mq3z2xNC;
	Fri, 06 Nov 2026 23:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793969004;
	cv=none; b=gRKIXB0KFXcuKFGqYoy4FvKv0CJIIGYOqQlGVkXkrlRK8GwmM24OejKTWYT5d4fwkZWUejMt8AdXtrpOnqxLroCNe7xiUvB0C1Eg5q84H8gFdVYS0TToK0h3RYFoY7xBXGGZSWDV2KsEpNCcrPfSa4NVM7T/bwHx056b/ihLw5ikoMjVYCCCgQUCteeblLWkCjb3+jUvB3ih/WdnNmDQUzOFfPep23yOCGf7yZP0P7Q0GJSWq05IOtQ3UOutUdFOTcpnOm+XKSkQvAW/u+Xf0lNRco9rjYjc9lCxCqF6A6Afwn3/NOr1174jXvAsABUjO7FUYRWQEK0hJiU62BcVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793969004; c=relaxed/relaxed;
	bh=AbLAJ3WxDTVKx50wvXdvbuoZC6cGIpM9TIIss9ASD2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnsuKH6N/yZEjoe1RTrvL+Rgz6+YY/bqUDIPvPNuJXVbC/KxhAT/iVSrMnUC/eIAASF4AevfowPRyrg3gFP4TgEksGPO74cHuCKM75yxezSZuav/dLG/FifGlWc35VPw1ZCbPQJ0N6Lxiu5spbSr6g+1Dp4HzGseQVv0+vxa90H5HVXS2ZqQL4uqUrzP65G6SUvT22vNHHyEVsNZLKUjaFpGvhiUwj54eFOTwuwrKrGUFcbFmQ+4jwpuN0fN5fFbtvZkn4bzq8pCATrZJyToe7iBsdNIQ19UBbwSeDW+MVQ6rgLuWMXdMN5RLLLDJrrSlf7rJkbhd1JFg514y6iQLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUrI1d5y; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUrI1d5y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLf3v1nyGz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 23:43:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BA045601E3;
	Fri,  6 Nov 2026 12:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A881F0089F;
	Fri,  6 Nov 2026 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969000;
	bh=AbLAJ3WxDTVKx50wvXdvbuoZC6cGIpM9TIIss9ASD2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUrI1d5yzxmdokjfAzvYAko5RWwe/LLqGo8vqE81Gq9ySuahoNu4COUDy60hTQBG1
	 pbLci13U7h/1EfLfUkkw6PVEXOTy1Jb4tpApZIjjwNkF76HS63MAo3HFOdT+SE+zwz
	 6hJkNTD4AFpsg/qFh1uZTPCSOZFG/xQoyMA3DIB2K1exCK5HGLI6VYkDwa7ZNO4bRy
	 1e0KE3D0a18ueouSvtUbSlNTpuK/JBi1ZY8sShRcj9Vfw+sihRiNqc9H23lh9GLCF9
	 iJ91oNs768o/GkHrxRY2pNRH9N3PQ+pNL1ksBZZDoNBI5j+KWAqiwiSDSW7ia08lWN
	 gFZz0tdfOnZzQ==
Date: Fri, 6 Nov 2026 13:43:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: soc: fsl: layerscape-dcfg: add the
 LX2160A pad-mux child
Message-ID: <20261106-smiling-infrared-dugong-48ee5c@quoll>
References: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
 <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-2-3aad0860b984@free.fr>
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
In-Reply-To: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-2-3aad0860b984@free.fr>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 07:12:10PM +0100, Vincent Jardin wrote:
> On the LX2160A the DCFG node holds the pad mux, overridden through its
> DCSR view. Allow fsl,lx2160a-dcfg with simple-mfd, so that the child is
> populated, and the pinctrl child, on the LX2160A only.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> index fc14fd0bf84b..dd6a00ba04eb 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> @@ -32,6 +32,7 @@ properties:
>        - items:
>            - enum:
>                - fsl,ls1028a-dcfg
> +              - fsl,lx2160a-dcfg
>            - const: syscon
>            - const: simple-mfd
>  
> @@ -62,6 +63,12 @@ properties:
>  
>    ranges: true
>  
> +  pinctrl:
> +    $ref: /schemas/pinctrl/fsl,lx2160a-rcw-pinmux.yaml#

Why other children are bus-addressed and this one not? Such mixing is
messy. Either this is a subdevice with its own addressing or not. Keep
bindings consistent.

Best regards,
Krzysztof


