Return-Path: <linuxppc-dev+bounces-6786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F0AC282D1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Mar 2025 22:28:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z83ww0tr9z2xGH;
	Fri,  7 Mar 2025 09:28:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741300127;
	cv=none; b=QVmoB07w+QnkO4Wxctj1I+i7S7+gD942/u1HRu/5RA5X/Gjz7QXrm1/o0uGRqqLoNQwLmln+hbjw1XpsW6V1erMuodXQeBLFNhvyT7a6UzIUrzY6NJuOilq4//4W5wm+MzSit32iPS+qbVwp+1EoGsvP2ON2jHJMkd06mzSZxLY/xzO3ezq+UHSlqdUVF5Joh3UAXAXxCUHnwX9aXUVafm1n4gsBfOvfQBVqKgI7aQucBxusG9oLNwMWrI88crda28DMv59cBUQcE+06+KaHVz6zLl9Llsl3IdJYIHR3bouavKmXcS3nWW9FtzjHwvrgCjOQxS0x6daTa/Q7+eaPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741300127; c=relaxed/relaxed;
	bh=MegudreLF4P4UxiHFKInsgrL02fKI45n+JKQKOhiHg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuQS32VD1P1B6q1qFawK83lRo0gHHcBCbDZxeQ9ZiPcdypoyR/M+/zvZx05VOpfRkt0KzhLxyyg80Hg0hT5G7wkarAJdYqmHKgsUQlHaaVe8+9GK63ztEDnK8Kpj0c7JAA+t41DUbLwoOMvEHXW6qvjOVNw2kv7vkojFDc5xFQSKCkShIrduj8kaHf2xOFjUPfyZVYCOLr7OOHTc53BAeYYno/527ZE2j01W8/cSHOpVOO0nE2NwjKF4lFdM/0dgVX9mSX6nHppD+Civ455+ZSP0cP4xoqqirFqzvCLY39KCPFCjLWW/ch2MTBu1pjCd9ooWHvETHDVPxNGUDM4A7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXrYt4Jr; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXrYt4Jr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z83wv28NKz2xCW
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2025 09:28:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 71E5A5C5A92;
	Thu,  6 Mar 2025 22:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC2C4CEE0;
	Thu,  6 Mar 2025 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300123;
	bh=2ABLlxIoMSQNDKV1phjvCwSi0BkSICv6/GcMMhHQews=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HXrYt4Jr8Ujw+I6ULk6lGN2aJq67C6kOW7bkoi+HYdokVxAaUNiqBmlKFwKMIrUzV
	 /r+awFkHB42epS4kjHahTJMSz8SCh5iVUfVp7FUF05c4R3e9WFYlvMcQd6pvb/PIRG
	 RPh6M60eNx8EDbdYyajwTtECC9oIg1VLkSS2sAtzN1NhfrH6nFqXSNLOwz3GkCZA6+
	 KBsYqC6pbbEcQeaiauNhnDRWjLY/616Ldj2jYEknJuPovaqTvDRBAhnxlU1dt3Clii
	 EjJjm2Sm/NmPQXdT+3s2pzy3QpcISUN6EqKKfSGJqwg5Ac6K0ooKjpz/lAeLt3vPaX
	 XCTRScQhSUdUA==
Date: Thu, 6 Mar 2025 14:28:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 01/13] net: enetc: add initial netc-lib
 driver to support NTMP
Message-ID: <20250306142842.476db52c@kernel.org>
In-Reply-To: <20250304072201.1332603-2-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-2-wei.fang@nxp.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 15:21:49 +0800 Wei Fang wrote:
> +config NXP_NETC_LIB
> +	tristate "NETC Library"

Remove the string after "tristate", the user should not be prompted
to make a choice for this, since the consumers "select" this config
directly.

> +	help
> +	  This module provides common functionalities for both ENETC and NETC
> +	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
> +	  flower and debugfs interfaces and so on.
> +
> +	  If compiled as module (M), the module name is nxp-netc-lib.

Not sure if the help makes sense for an invisible symbol either.

>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -40,6 +50,7 @@ config NXP_ENETC4
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
>  	select NXP_ENETC_PF_COMMON
> +	select NXP_NETC_LIB
>  	select PHYLINK
>  	select DIMLIB
>  	help

> +#pragma pack(1)

please don't blindly pack all structs, only if they are misaligned 
or will otherwise have holes.

> +#if IS_ENABLED(CONFIG_NXP_NETC_LIB)

why the ifdef, all callers select the config option


