Return-Path: <linuxppc-dev+bounces-18167-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65EF105F781
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 09:53:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKYj0yqPz3cJk;
	Fri, 13 Mar 2026 20:53:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773395609;
	cv=none; b=BTikfyx0SB38M/OLrmlXAxKWbuWZiRZQOd4qwN+sojWZEKDyPM7FMugU3YfZvAwalS4330DBfzzlReFTjP5TkZ2QJ78kXsWcUGtWQDa/8WXUKCbdRi4NlKpKIvZRKOv0jgAectLMKIYyPWyTStJQebcRKYLEUNfv5RbmBB+HzEW3w/w8B6BhT8Ok0c6o7HWuUHhHy0gZEUDgXqZTBNzXUT4ydvDqw8jUIRfgYlEJltF3S9hneSShKGc02nBtqnDHT4Qb1eXC2ZyiIGewGZXs2VeOh4Yq2fCGvlR915uP4NDXqe+oVHSeJSON3JrS0/9bwfSvt8/Kxpb7bP7kve2l5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773395609; c=relaxed/relaxed;
	bh=UZjDFabv/JVxoyFBHx12mWT7ZrNxq98Zrg7DPbb7x1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D73VDIYma06vy1rX5t/GNM1UpHe7nk7N1RsxiMM4YE+Os8nFEnQGVbpophGK8IM787hJ1FxhkWVy/I3xaSwLw25n/aUZzkiWtS9ijEqPJDMD8UdrbU4/aLO1F4wmf5oylOWEJorF3yC84CT4bQU1fWUcl4lP8RSwO5DO6cAl0KeCSDXHqtgER1ySHESnuvQ4KhRwz/t4s3gRMsvPGtwPs9qJ1Yt/wf+8S2fW/weWxwc6WmHfWNyC5tP0mksjyUvE0LSyLBuwrmTXLnVQ42TEoElkcy2i7zsR1oBwWLhOMFPQFlGXteMgz7Imou91iAYv4cB/8Y+Tiwu2oEliQ5IPow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.net; dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=2017 header.b=p86ts5wn; dkim-atps=neutral; spf=pass (client-ip=185.67.36.65; helo=mout01.posteo.de; envelope-from=j.ne@posteo.net; receiver=lists.ozlabs.org) smtp.mailfrom=posteo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=2017 header.b=p86ts5wn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=posteo.net (client-ip=185.67.36.65; helo=mout01.posteo.de; envelope-from=j.ne@posteo.net; receiver=lists.ozlabs.org)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKYf33HFz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 20:53:25 +1100 (AEDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B200C240028
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 10:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1773395599; bh=UZjDFabv/JVxoyFBHx12mWT7ZrNxq98Zrg7DPbb7x1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=p86ts5wnVzPS2/xdsRYninq4XKt0ezE1h+lYLDqN+5+E0Acdi/zY6m0acs9xmYbnJ
	 F+Co/iROMdwNKFmu8qclFEwr2ZGjKZAGeiR+I0gC7yrZaOk0l1hN53Lbyw1NBp9zla
	 l0HA+DeO5yqq/YUNuIrO0XOGs/j9R3Vei3ZK3PUL0gZbTIMsF/LTfoSB3QykTAscCQ
	 k5MAsm+3+90ca66R9KkUGWTL1gZSa4STDpCd93nlG4+1ZnsLS71QqYmdODaLQcV+yL
	 uBCNbDvvz0kusULg8e9OGFLZfo+F0mxrg/sO6hZUJSgudD4pLZJUJmLOGtUkgE7ysj
	 O0nj3MRqqE7pw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXKYS2MnNz9rxM;
	Fri, 13 Mar 2026 10:53:16 +0100 (CET)
Date: Fri, 13 Mar 2026 09:53:18 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] powerpc: dts: Build devicetrees of enabled platforms
Message-ID: <abPei7QPNV2NHLO0@probook>
References: <20260311-mpc83xx-dtb-v3-1-4aa43bb9ffa0@posteo.net>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311-mpc83xx-dtb-v3-1-4aa43bb9ffa0@posteo.net>

On Wed, Mar 11, 2026 at 02:41:14PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Follow the same approach as other architectures such as Arm or RISC-V,
> and build devicetrees based on platforms selected in Kconfig. This makes
> it unnecessary to use CONFIG_OF_ALL_DTBS on PowerPC in order to build
> DTB files.
> 
> This makes it easier to use other build and test infrastructure such as
> `make dtbs_check`, and is a first step towards generating FIT images
> that include all the relevant DTBs with `make image.fit`.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v3:
> - Group multiple files per line, while still avoiding backslashes
>   (suggested by Christophe Leroy)
> - Link to v2: https://lore.kernel.org/r/20260305-mpc83xx-dtb-v2-1-cdb751458445@posteo.net
> 
> Changes in v2:
> - Use "dtb-$(FOO) += foo.dtb" format on every line, avoid backslashes
>   (suggested by Geert Uytterhoeven)
> - Link to v1: https://lore.kernel.org/r/20260119-mpc83xx-dtb-v1-1-522f841290bf@posteo.net
> ---
>  arch/powerpc/boot/dts/Makefile     | 72 ++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/Makefile | 43 +++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> index 0cd0d8558b475c..56581c2489df0f 100644
> --- a/arch/powerpc/boot/dts/Makefile
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -3,3 +3,75 @@
[...]
> +# MPC85xx platforms
> +dtb-$(CONFIG_STX_GP3) += stx_gp3_8560.dtb stxssa8555.dtb
> +dtb-$(CONFIG_TQM85xx) += tqm8540.dtb tqm8541.dtb tqm8548.dtb
> +dtb-$(CONFIG_TQM85xx) += tqm8548-bigflash.dtb tqm8555.dtb tqm8560.dtb
> +dtb-$(CONFIG_SOCRATES) += socrates.dtb
> +dtb-$(CONFIG_KSI8560) += ksi8560.dtb
> +dtb-$(CONFIG_XES_MPC85xx) += xcalibur1501.dtb xpedite5200.dtb
> +dtb-$(CONFIG_XES_MPC85xx) += xpedite5200_xmon.dtb xpedite5301.dtb
> +dtb-$(CONFIG_XES_MPC85xx) += xpedite5330.dtb xpedite5370.dtb
[...]
> diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
> index d3ecdf14bc42e7..be784cbda6b56d 100644
> --- a/arch/powerpc/boot/dts/fsl/Makefile
> +++ b/arch/powerpc/boot/dts/fsl/Makefile
> @@ -1,3 +1,46 @@
[...]
> +dtb-$(CONFIG_PPC_P2020) += p2020ds.dtb turris1x.dtb

I just noticed that turris1x.dts is in boot/dts, not boot/dts/fsl.
I'll fix the Makefile listing and respin.

(This is an arbitrary split that doesn't catch all Freescale parts
anyway, but moving dts files around is out of scope for this patch.)


Best regards

