Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2rLC0428zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 14:20:03 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 34so11091pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 21:20:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] powerpc/mm: fix up pgtable dump flags
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170331013749.17874-1-oohall@gmail.com>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
Message-ID: <c68c1247-b676-5b48-264d-8affe0c10ead@gmail.com>
Date: Wed, 12 Apr 2017 14:19:56 +1000
MIME-Version: 1.0
In-Reply-To: <20170331013749.17874-1-oohall@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31/03/17 12:37, Oliver O'Halloran wrote:
> On Book3s we have two PTE flags used to mark cache-inhibited mappings:
> _PAGE_TOLERANT and _PAGE_NON_IDEMPOTENT. Currently the kernel page
> table dumper only looks at the generic _PAGE_NO_CACHE which is
> defined to be _PAGE_TOLERANT. This patch modifies the dumper so
> both flags are shown in the dump.
>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Should we also add in _PAGE_SAO  that is in Book3s?


> ---
>   arch/powerpc/mm/dump_linuxpagetables.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index 49abaf4dc8e3..e7cbfd5a0940 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -154,11 +154,24 @@ static const struct flag_info flag_array[] = {
>   		.clear	= "             ",
>   	}, {
>   #endif
> +#ifndef CONFIG_PPC_BOOK3S_64
>   		.mask	= _PAGE_NO_CACHE,
>   		.val	= _PAGE_NO_CACHE,
>   		.set	= "no cache",
>   		.clear	= "        ",
>   	}, {
> +#else
> +		.mask	= _PAGE_NON_IDEMPOTENT,
> +		.val	= _PAGE_NON_IDEMPOTENT,
> +		.set	= "non-idempotent",
> +		.clear	= "              ",
> +	}, {
> +		.mask	= _PAGE_TOLERANT,
> +		.val	= _PAGE_TOLERANT,
> +		.set	= "tolerant",
> +		.clear	= "        ",
> +	}, {
> +#endif
>   #ifdef CONFIG_PPC_BOOK3S_64
>   		.mask	= H_PAGE_BUSY,
>   		.val	= H_PAGE_BUSY,
