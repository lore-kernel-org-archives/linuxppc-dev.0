Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439D606D80B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=srH7cace
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXp11Wzfz2xfX;
	Thu, 05 Nov 2026 04:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814153;
	cv=none; b=UhoCBvTXfbotHRFd6vUKYS3qs4CatzFQQabvM9QC0+4Eqx+qKKu8qLXv3P7yamyCbdRNXRrCuZNAuvmdW8nAdaIAwtJROjatfXueUdfp2KE4fpJA529lBa+rqZvVRh9rmFHvLVOJ3qQme/Y1AoWWBua6UxYmgdCXwTRQEKarqNsfsWUf5U90ukMrV1uc7e4Hs483P+uZu+vrn37DHBUj1JxVTg2+elC81k06ww8NQIn/6+nxy0vttQMWs7kHXCplvPuQRnnTd5m1S7Lr5UB6qsBF8T9edJuKIZYGrOliI+uaqdpD1HsRsVT02hKr2nJ8JxkBTnlEM01r/vJVjDP/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814153; c=relaxed/relaxed;
	bh=Qgrr7ni+/wWB6KrEVoi8winLqQmlrOPhCmlWyUxljNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEJJE16TPTDOgEI9ThIoAJupmBEeFTrdsDjOEnGNTui1C/vBQSqXdLFy5YK091d4MGTMVmdWq7E/FgGO04n8mt8PRjwpGF3Y3r8eI4dr+aKZNKf7/ZChyx5taiMsYIUm3HSO571juVRpzHVF7DxxBrMwTJ4Z/7fp8UtShwo4qOy9p7lPlWon0D9arPpyRhij5T0Y9pu2KwreWq6veP2pNbqvzVHYKJyJdMYBo8yOy3zQ/06YnnNnsCR0IJ2SMaltAZyuAN2kAVURssxfUThWZ0kV4r33H6A43AKreed6H3/qJnhhMXUtkBh95gQEQ8RJERgq8vuQYJYBmmaGNIT2ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=srH7cace; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=srH7cace;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXp004Fcz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:42:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Qgrr7ni+/wWB6KrEVoi8winLqQmlrOPhCmlWyUxljNw=; b=srH7cace5OyxC1TdxFOr+0SV9v
	YTuYN8Mdli3q4t4D+ivBeGsfe00NdlnK7kxxurFEZTxKy4IQTBb35mdvErJ6E/u0SB+b/mcOTzlLD
	ycRAoYy7wTqSK9s7WyLpO2x5xh+TIM1vG0BjaKnJMWvCZBDWffiJj9CH1Q+5zXqgTCBo4gU/rjcHd
	ravT/ixqz1n8pAUEL4B0Bgq5BbCcwZbckr4CMNdBgVgTAJgiALyzFfyRGAzgJzAbx5sFP2cagKKyZ
	iLJOC/IYymF6l+QT51IQRg44qK/ODXABaQFCzfPiqQXQZsWRt4Qad/6CkiDZALp5+nDmTXKTUko1A
	jkujztEQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOf0I-00000006G0L-0rAQ;
	Wed, 04 Nov 2026 17:42:30 +0000
Message-ID: <0f7942d5-71b6-484d-bb4f-ca3b13462216@infradead.org>
Date: Wed, 4 Nov 2026 09:42:29 -0800
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
Subject: Re: [PATCH] powerpc/mpc52xx: Remove redundant 0x prefix in
 mpc52xx_pci_setup()
To: Thorsten Blum <blum@kernel.org>, Anatolij Gustschin <agust@denx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261104172829.231857-2-blum@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261104172829.231857-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 9:28 AM, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefix to avoid printing 0x0x.
> 
> Fixes: 59510820fff7 ("powerpc/mpc52xx: Fix some pr_debug() issues")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  arch/powerpc/platforms/52xx/mpc52xx_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
> index 0ca4401ba781..a2e53cacd15b 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
> @@ -288,7 +288,7 @@ mpc52xx_pci_setup(struct pci_controller *hose,
>  		printk(KERN_ERR "%s: Didn't find IO resources\n", __FILE__);
>  		return;
>  	}
> -	pr_debug(".io_resource = %pr .io_base_phys=0x%pa\n",
> +	pr_debug(".io_resource = %pr .io_base_phys=%pa\n",
>  		 res, &hose->io_base_phys);
>  	out_be32(&pci_regs->iw2btar,
>  	         MPC52xx_PCI_IWBTAR_TRANSLATION(hose->io_base_phys,

-- 
~Randy

