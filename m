Return-Path: <linuxppc-dev+bounces-23147-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2049C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 05:43:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqBrt1ypvz2yY1;
	Tue, 30 Jun 2026 15:43:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782798206;
	cv=none; b=oKc7CGU+Sby3+kMXs686L0yIVia42P4GLummpvO2N75xsx15xLSJonBbOgszcKWfC7rJvtWJSkqUn0yx8QQZmdJmPLY4ab9uNPoMOQcHR8Z6jp5KxUwQPxF0Y84OsdQSWX8u8zG2XigK1vzWIJM+alx9U5sWt1Al1QTSh9hgiMUHAuAxRyFXNxYYt8Ge20IffPP7SZ2xsrZExvtAASnNwGe2NJpCSVcYZ8+/BuBoznJcATuK0XoeACQeGKwnJd7OwxWPCv6TXyOumBAew6sNV7Lj0WXHaEgnL/aXZNrk0a1NnvKW04HREp/3pl982J2Vd1rM60nizY/drL0sNuKJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782798206; c=relaxed/relaxed;
	bh=8aJUwxqPn5J8U7iknbujNbSqUM1cPZPdUY5Rjn7wydc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGlPAEyZ/iHiMm1UVSzBtWKvfc4xH8W7JA9D76eYK+nnTboP7GRT7Mus+jyJrqxjiMX3dNQg1X9tqSxJ1+Ilz9g1+ICNiMN96tkYs2yrIWhQc52OTgaJTYOkEwwIcv74tY7yjjd1raUKEqcsT4PPBktOyBAtUCRkvAu9NzZeZCAT4WmLe3CU2OcUk9+WMBQTg/XzkP0DUqddlA9hfmCqwIbLvfrZHz9yTHH7mDfXadmxetZcAV1go9HRLvRJhRkbPaxmdeLUopS5lZvbZ0dwRsu4u8RDA6mlXv+o1OnEdeUxOYjGxfei+PM5a22w1eeHKhcpqLN7HiM7TYkJ+PMQOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiWf9XzN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiWf9XzN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqBrs4jSmz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 15:43:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21F31600BB;
	Tue, 30 Jun 2026 05:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3948E1F000E9;
	Tue, 30 Jun 2026 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782798202;
	bh=8aJUwxqPn5J8U7iknbujNbSqUM1cPZPdUY5Rjn7wydc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NiWf9XzNLL2hvkyu2jw4gPzmT3+0Jq5WxqlP284Z0n3DJvcRU4upVjOe97DsrYDda
	 5ipE3oEbwgkEdwj9xLthoGIp/5JcUytSm11Aa0VnNqDrDsUgLVbC8nfenW+dP+v309
	 9UFgeeGZwpRqRbFRuHbtTE00hH1eQ+flBAkiBlnZHnxgShVkgshCuaG6tVeLIc/IWe
	 BSAFJXDgjsg6eWaeUtwtUF7wt/7Ai+cJtWZcklqiIN3tXezwi2v6TrOfWiIjllfIi0
	 OAoHwQbKnjLrH+qm8C10jZRlssLFdlvxClGNZmITn3OYMkpnk8V03n9cWYY0F2PjxZ
	 rP6m7nabWdcQQ==
Message-ID: <62302ee1-dafd-485e-88a0-feb695d209ad@kernel.org>
Date: Tue, 30 Jun 2026 07:43:17 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] powerpc: remove ehea driver references
To: David Christensen <drc@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260629211343.3712775-1-drc@linux.ibm.com>
 <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/06/2026 à 23:13, David Christensen a écrit :
> [Vous ne recevez pas souvent de courriers de drc@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Follow-on cleanup after the removal of the IBM eHEA driver in commit
> f721e8ffa92a ("ehea: remove the ehea driver").
> 
> Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the
> EXPORT_SYMBOL_GPL(walk_system_ram_range) export from arch/powerpc/mm/mem.c
> that was only needed by the ehea driver.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 -
>   arch/powerpc/mm/mem.c                | 6 ------
>   2 files changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index f795b74602ec..1eb8e3457e8b 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -210,7 +210,6 @@ CONFIG_BNX2X=m
>   CONFIG_CHELSIO_T1=m
>   CONFIG_BE2NET=m
>   CONFIG_IBMVETH=m
> -CONFIG_EHEA=m
>   CONFIG_IBMVNIC=m
>   CONFIG_E100=y
>   CONFIG_E1000=y
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 4c1afab91996..b617b69452cd 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -371,12 +371,6 @@ int devmem_is_allowed(unsigned long pfn)
>   }
>   #endif /* CONFIG_STRICT_DEVMEM */
> 
> -/*
> - * This is defined in kernel/resource.c but only powerpc needs to export it, for
> - * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
> - */
> -EXPORT_SYMBOL_GPL(walk_system_ram_range);
> -
>   #ifdef CONFIG_EXECMEM
>   static struct execmem_info execmem_info __ro_after_init;
> 
> --
> 2.47.3
> 


