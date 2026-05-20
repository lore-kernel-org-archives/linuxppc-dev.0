Return-Path: <linuxppc-dev+bounces-21238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2709BCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 12:28:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL9mj4cp4z2xqv;
	Wed, 20 May 2026 22:28:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779280085;
	cv=none; b=oh3Fax4g2JKQ0o6TuXEcOFyRNJGNnHkLeL/B0M/HN9iIhrff8ouGIPGSuJh6e5cNcmxzKzrzJBtyRPuS3r/EIBuAcoVXtTMRi1HBII/lsEuPqKmpg1o2OmTU9eI46vMUsTY1WCh43x2EagjQyukIgJuE5If7nOGjWmygDbvMMou5SVRwc1z235d2v3Mteuvr6oN8XfqwKPLDDgItVWQhrn+VBmzHBz3NhAkX/4hAbp2IMLRn0pSjqhj5zVqeG9DzSWz4NvMG8wvHJakOkRa8Rqk2L9EQh+paMvk8gg9XinzLepvWf4XejAPj70uWQ3OavA8rNbxWdVGZMiML8sIY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779280085; c=relaxed/relaxed;
	bh=YPsDEinQC31MNkFSqLK/AYf2QgBz8ODGpxSGL7Px3IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4u4qIh2YGpL/8XOUbMdPtHYmd6HLx1y2QUNtqKfx/5R4QzTpYWQ/3JKDxjhPl3kfK1L784kqJINezlqfjcuz+NeoPKHqNUwHYi3Xlbh2qdG3lnbuhTO7t20JPKIPTzuBmlubS1Yf7q1q4fHfFhevBc13vpsszeJxi0Jd60sQlVilLMHWBmc6nYmhroJ9NSxNsjxM+wIRKpYXXRm8QedNjotpgE3XPFZqCElRee1sJBOBhyGx0FNshozR6+veNguDJ0fcQafmMV34nMSdTQN39JtRp+ccQX0JtBBoI8uwHJEM+ZZ56oui739sowSYa4z0BFgFLwGn7UwrAme4KcTiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc4Tbi1m; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc4Tbi1m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL9mh1hDCz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 22:28:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1088D60120;
	Wed, 20 May 2026 12:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74851F000E9;
	Wed, 20 May 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280080;
	bh=YPsDEinQC31MNkFSqLK/AYf2QgBz8ODGpxSGL7Px3IA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tc4Tbi1mDQTXmycd1ELO6Lje82rVlRYlTAc840+8ZjfSzh5ogFOayADO17WMiJvZh
	 eUNK8P1ItT1GNhsEXP5Mj8bYthxGgeidBMKeFrA/TA3FC//EjtKeQ1zpL1bKFrZdJq
	 GcRahcvzBjBH176FYWWve2Ut0Ybt2qKHE/DXfqM+FKK8Jgur4ifwQtl5WqbcMRbILS
	 IafqUbxhOZzvBEnm9K7SrCw4t/c6QnnVDOZj+Cr92f+H6VG+7JzE2moRiLTvlroN3v
	 DtChkRU1G5QGhIR5nY39NCOmTHKTw2ZxnFHx48fDiSEmdSCKrprcl/eMiedM6X83SJ
	 1LlS4+JwBqwDg==
Message-ID: <8ba30f1d-19ce-449a-966c-236fd6026c07@kernel.org>
Date: Wed, 20 May 2026 14:27:56 +0200
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
Subject: Re: [RFC PATCH net-next 2/2] powerpc: remove ehea driver references
To: David Christensen <drc@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260519224353.1282038-1-drc@linux.ibm.com>
 <20260519224353.1282038-3-drc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260519224353.1282038-3-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 00:43, David Christensen a écrit :
> [Vous ne recevez pas souvent de courriers de drc@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Follow-on cleanup after the removal of the IBM eHEA driver in commit
> XXXXXXXXXXXX ("net: ethernet: ibm: remove the ehea driver").
> 
> Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the obsolete
> comment in arch/powerpc/mm/mem.c that referenced the driver.

What do you mean by 'obsolete' ?

As far as I can see the commit is still valid, I can't see any other 
module caller of function walk_system_ram_range().

The comment was introduced by commit 26b523356f49 ("powerpc: Drop 
page_is_ram() and walk_system_ram_range()")

> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 -
>   arch/powerpc/mm/mem.c                | 4 ----
>   2 files changed, 5 deletions(-)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 6316ca4df25d..b022d00708f4 100644
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
> index 648d0c5602ec..1f5ad1a59d68 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -370,10 +370,6 @@ int devmem_is_allowed(unsigned long pfn)
>   }
>   #endif /* CONFIG_STRICT_DEVMEM */
> 
> -/*
> - * This is defined in kernel/resource.c but only powerpc needs to export it, for
> - * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
> - */
>   EXPORT_SYMBOL_GPL(walk_system_ram_range);

As mentioned in the comment, the EXPORT_SYMBOL_GPL() has to be dropped 
when drivers/net/ethernet/ibm/ehea is removed, which is now.

> 
>   #ifdef CONFIG_EXECMEM
> --
> 2.47.3
> 


