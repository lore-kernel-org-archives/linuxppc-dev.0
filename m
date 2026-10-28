Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0450606A322
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knwpcmch
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF9Tz64MPz2y2Q;
	Thu, 29 Oct 2026 01:58:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793199511;
	cv=none; b=OKCsGvniNGCUXzMBv+ouRZOT2msxImKe+tzbsq/58pKUG1dzYnN4r8C2HPPAYERmUhmKvAFXcRUypLacIQ5xnw7jqavecUJmFrbe7B8KguTSkJ4FueMc8nrHZgNzNfY5t6MT9YfT4WBVX3ZFQ1D/KApJXfXoij1IyuloupuNPYdUU+lveck5/b/N8uiyufHwbEhm4wgG+qkHMtSchK/J3HiLhLGPJX+n8/dK+1V2Nd4mNXlQSI9psdQAy9kVxv+KmYU4xd+jkjur/7N4PcAWWTmcGyGJa9nRwBmi/bY2mWdJ3k8jTbMNWkE+hvB2V0qY4twOw4VgW6FO+0ot0IPx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793199511; c=relaxed/relaxed;
	bh=hJTPdQsfkBMS5hjQULz7ngcYeWbt5Jn5KRiZmkOAbIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj+jjGJH+cClDqEnrMYkswTkrxs3H1ji+SWPKJscoP2PCrW76s66PCoYSkekC5S44sO2udufaWfMmTZnILwp8NHapT78msDzWO96PF4o66p+5xbomxzungDHim1VuogQrvKSoHtJzlhHO43fmBebvtZHpKc3Trd4W78rPuDsClYLvw1+deIVCsiiYzrN8j/k5u2QvIpvhOQRVugn99QrQd3TtTd6rQww65Nav8M95sNXtyf5Ca7BiDBm24BiAcPKr0qrIAEKQjbkVMFK3DjDa3du+UjJpZrCYRe3bwMeWfrxNb/wxc+DOX833hkuy2GewvSx2SE44T677ORhO6iYbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knwpcmch; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knwpcmch;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF9Ty0gjkz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 01:58:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 26B14601FA;
	Wed, 28 Oct 2026 14:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C41F01828;
	Wed, 28 Oct 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199506;
	bh=hJTPdQsfkBMS5hjQULz7ngcYeWbt5Jn5KRiZmkOAbIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=knwpcmchCU3dSz9M/RFQ2iWxHWK9Uv7fU8p/QOtEysB8DKcC3dPaMkHQ2yJgUKunV
	 P9Y3MYW7ssLFu99zyvopXcRrU2KkQZLB+1xLjIjjQolgC2b79EgHl8jslYBnns3Qkr
	 Yg9wel9HFb9C5WqGMe3KgO3vufrzQ36COOdS4YFD2XIJWURYlhUbWM7rhZlgqk7TU2
	 p3HkV6ue5v62TIJ+8J217ZRLl5ZObmofiPwLBXFdYxqIqNf/3Tk+DnzvKrz+mRe7jw
	 9JOnQk8UQiwjLTARBZwSxJHeOJtOHEkBaRlYdEfexQHntQps2rgMa9kh8BqZGX40Co
	 DDDKghy+CF34A==
Message-ID: <20a5a90e-ee8e-41c2-83e9-5ff03bd0edab@kernel.org>
Date: Wed, 28 Oct 2026 15:58:20 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/dts: Add Device Tree for WatchGuard Firebox
 T30
To: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, sashiko-bot@kernel.org
References: <20261028143421.145290-1-lefteris.koutrakis@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261028143421.145290-1-lefteris.koutrakis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 15:34, Lefteris Koutrakis wrote:
> Add initial support for the WatchGuard Firebox T30 board based on the
> PowerPC architecture, updating the fsl Makefile and adding the new DTS file.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Missing DCO. Please read carefully submitting patches.


> ---
>  arch/powerpc/boot/dts/fsl/Makefile        |   2 +
>  arch/powerpc/boot/dts/fsl/firebox-t30.dts | 398 ++++++++++++++++++++++
>  2 files changed, 400 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/fsl/firebox-t30.dts
> 
> diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
> index d2cc8e1f0..0a5c8b596 100644
> --- a/arch/powerpc/boot/dts/fsl/Makefile
> +++ b/arch/powerpc/boot/dts/fsl/Makefile
> @@ -3,6 +3,7 @@
>  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
>  
>  # MPC85xx platforms
> +dtb-$(CONFIG_MPC85xx_RDB) += firebox-t30.dtb
>  dtb-$(CONFIG_BSC9131_RDB) += bsc9131rdb.dtb
>  dtb-$(CONFIG_BSC9132_QDS) += bsc9132qds.dtb
>  dtb-$(CONFIG_C293_PCIE) += c293pcie.dtb
> @@ -44,3 +45,4 @@ dtb-$(CONFIG_GEF_SBC310) += gef_sbc310.dtb
>  dtb-$(CONFIG_GEF_SBC610) += gef_sbc610.dtb
>  dtb-$(CONFIG_GEF_PPC9A) += gef_ppc9a.dtb
>  dtb-$(CONFIG_MVME7100) += mvme7100.dtb
> +dtb-$(CONFIG_MPC85xx_RDB) += firebox-t30.dtb
> diff --git a/arch/powerpc/boot/dts/fsl/firebox-t30.dts b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
> new file mode 100644
> index 000000000..6e9ec7f90
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/include/ "p1020si-pre.dtsi"
> +
> +/ {
> +	model = "Watchguard Firebox T30";
> +	compatible = "watchguard,firebox-t30", "fsl,P1020RDB";

Missing bindings, but not sure if it matters for PowerPC at all.

Best regards,
Krzysztof

