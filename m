Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C26606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1Cb0x8H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0P150f3z2xdX;
	Wed, 04 Nov 2026 07:22:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793737349;
	cv=none; b=MB0xYnSy3z//Ih+OuuR9S5Dbe8HDJzh/j1TdY7oMuzww/JhQe4Ve6iPKuZ3AlmOI57PowF09lksMFRByqoSdR40VrGFwgcLFKrkVqSGCnhM1/SO83HknnUWR+X7RST173rWGCQQhgnLlKr7dXPkQhC0qnuyWwLW7aPNeA6UJVZ0ux+2jYqUsl/DyIQ6XUPfIVgcRCHpxqGxu3WPDlnl9blU9ahn/pN7jTlfQJORtACaySpDNCon3WyTlo58vWHOD7YXZV+RDZU20C9QHvJ4SiFQF7rf/JF2sDU4MUHfvQ20RpAps3rFmQOhoUQEYejdAum1a8QlGtLDvDpx+24cORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793737349; c=relaxed/relaxed;
	bh=OowuJQe3aC0/b/4LdRy+JJUp1bkSK8DzGICROZcpBoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3JjRIocumz+RXAMFHl+zIBqKZc+4hj356aN8VEiQckNEDzt4mGfL1u6zeDZlSzrj/UTe1qRGtHXPH8WefN1xg97CQcLdg9tHn3fE0Z1aevZZxQB9mhxecoyW1uMvZLjqz6XF8z6DB2TAhhQI7Gn5fc4AUixvkj0kGolIsP7U7zjSJYTVBPL0ulMJQZA4ZAyH82Of1V4h0D8uClxQeTH0Jz8fQ9ZkwM9ayAw+FvRnenDfhvol7bNJuzwyTb1bn2T0vI+dtH7tfxNMPxpliYzPDBIJyRFGJEUcTLMavxbt3jcTaBbZnoGglsccTF2OxQp9Lz0dZKBJFYNorBVvoL8HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1Cb0x8H; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1Cb0x8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0Nx1XGPz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 07:22:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OowuJQe3aC0/b/4LdRy+JJUp1bkSK8DzGICROZcpBoE=; b=F1Cb0x8H3kRQarOHQ6CQBF8gcm
	bhCaWl5QzG2ChnLUDKXehOJ1Fd70NHF5nPk8Qa2oY3y2zTXZibbInwgks6qIO7jsR2/QAgLiZ7Mnf
	+Oq5KN0uvYZ2FH4mc561XClVhRllCL1VVkD8cLM8DXg/rxi5vNy8AYZvnsFyk4Oy41f0rrDcMYsoT
	9NwwAIAxwrm0qTE1BW1pWuw+VsMe1BuN9kL7Pf6fyd3n7biq9e7FZh9lQVjdebAiQLka5B16WM4Jx
	A/pcNV/fQv+5FmRItjO+L6m0SVFyXyC+E+t7lg5UlUAi029mzw0Mgmren3UPQxkYTGL562EkzD+ZM
	fx5Fzeww==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOL1P-00000003c7K-08Ii;
	Tue, 03 Nov 2026 20:22:19 +0000
Message-ID: <124acf19-a676-46bb-a414-08d957d9cc7b@infradead.org>
Date: Tue, 3 Nov 2026 12:22:18 -0800
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
Subject: Re: [PATCH] powerpc/wii: Remove redundant 0x prefixes
To: Thorsten Blum <blum@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261103170305.455444-3-blum@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261103170305.455444-3-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/26 9:03 AM, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
> 
> Fixes: 7b69600d4da0 ("powerpc/wii: fix resource printk format warnings")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

There are other cases of this elsewhere in the kernel sources.
Are you addressing those also?

Thanks.


> ---
>  arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
>  arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 2 +-
>  arch/powerpc/platforms/embedded6xx/wii.c         | 6 ++----
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> index 91a8f0a7086e..e9c84793cc4d 100644
> --- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> @@ -145,7 +145,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
>  	}
>  	io_base = ioremap(res.start, resource_size(&res));
>  
> -	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
> +	pr_info("controller at %pa mapped to 0x%p\n", &res.start, io_base);
>  
>  	__flipper_quiesce(io_base);
>  
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> index 1522a8bece29..a1bdb83fe51f 100644
> --- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> @@ -171,7 +171,7 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
>  		return NULL;
>  	}
>  
> -	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
> +	pr_info("controller at %pa mapped to 0x%p\n", &res.start, io_base);
>  
>  	__hlwd_quiesce(io_base);
>  
> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> index e7eec328f121..928d082abf56 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -73,10 +73,8 @@ static void __iomem *__init wii_ioremap_hw_regs(char *name, char *compatible)
>  	}
>  
>  	hw_regs = ioremap(res.start, resource_size(&res));
> -	if (hw_regs) {
> -		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
> -			&res.start, hw_regs);
> -	}
> +	if (hw_regs)
> +		pr_info("%s at %pa mapped to 0x%p\n", name, &res.start, hw_regs);
>  
>  out_put:
>  	of_node_put(np);

-- 
~Randy

