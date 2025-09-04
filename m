Return-Path: <linuxppc-dev+bounces-11726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8324CA1015
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Sep 2025 12:27:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHdym1Mk1z303F;
	Thu,  4 Sep 2025 22:27:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::227"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756988832;
	cv=none; b=UPR6XjQ0+PtZIt05cNgpajKoxPWsRsbb0oPQ9JQz0QY9E/ee7x34KbrbXUW9mnSUL04uopqmu4uVVB/CMLYaFIU66C4IpzqRTMG1Wd4YE8dt0n89gxpFxCLIAfVlxYeUoZpp9bHgtm6823v4rRy9YNi6fqGzWK7mGBl3TzF1loa5k1tMBFI/SPP9S5wQNTgPFQROTV97AfNrEDwNAIrDKZKlt22YbSumCJtQjfag8w6PRRg+KHsgNL/tKG5yq4ZH3xcbBLz84m0odkUdPfCWvZxSCxYicFLuMdvoaZg5xxW7OVm6QTxBZpQk49F9d36KKEi0u9CnohhtR2wijSFBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756988832; c=relaxed/relaxed;
	bh=ap/u/LxI4jJId+wwpbfiqajsfGDukKXM8oCDW1Th5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+PBvS62qE750pmbYtPSSaJXDBspf9k5R1bgOJE3jgMfP5k+jhU3+vOlc8zU4ZSkAOdUzdlEzrHPMGs+AyRTNd94oWeThY9eayqML5NTVadAPkekCNGoeICljlLOQk6gr73LK3ysdkcR6WTHQ7Rnu+8Mzwuh/V6D8X/1k5pOPVgSA76JLe8km9WhWQqqBv7s/Vpone2yDRuAc7fwPkb8jZX12muuf67YMZlmcATG1bsffPeqLoEeddYpoI+C1EU4srcOVt+VUkQVdSkdgoxgMBH9fmr1JVrqCnRUaoQ4UZdPUmkR47CVtwD8l5WXFGD2zQnf/3OrU9Xe9A9gbKiZiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass (client-ip=2001:4b98:dc4:8::227; helo=relay7-d.mail.gandi.net; envelope-from=alex@ghiti.fr; receiver=lists.ozlabs.org) smtp.mailfrom=ghiti.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ghiti.fr (client-ip=2001:4b98:dc4:8::227; helo=relay7-d.mail.gandi.net; envelope-from=alex@ghiti.fr; receiver=lists.ozlabs.org)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHdyl1qg4z302g
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 22:27:09 +1000 (AEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99F8842D83;
	Thu,  4 Sep 2025 12:27:02 +0000 (UTC)
Message-ID: <113262ca-214a-4cd4-86f2-c0e3e4bb1a06@ghiti.fr>
Date: Thu, 4 Sep 2025 14:27:02 +0200
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
Subject: Re: [PATCH v3 4/7] riscv: Stop calling page_address() in free_pages()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-5-vishal.moola@gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250903185921.1785167-5-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehvihhshhgrlhdrmhhoohhlrgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Vishal,

On 9/3/25 20:59, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   arch/riscv/mm/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 15683ae13fa5..1056c11d3251 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1624,7 +1624,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>   	if (PageReserved(page))
>   		free_reserved_page(page);
>   	else
> -		free_pages((unsigned long)page_address(page), 0);
> +		__free_pages(page, 0);
>   	p4d_clear(p4d);
>   }
>   
> @@ -1646,7 +1646,7 @@ static void __meminit free_vmemmap_storage(struct page *page, size_t size,
>   		return;
>   	}
>   
> -	free_pages((unsigned long)page_address(page), order);
> +	__free_pages(page, order);
>   }
>   
>   static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, unsigned long end,


Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


