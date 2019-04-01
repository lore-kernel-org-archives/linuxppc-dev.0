Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:12:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0397B20830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0397B20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xp7N4F4MzDqLP
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 21:12:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xp5h64NfzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 21:11:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Xp5h2VYmz9sPS;
 Mon,  1 Apr 2019 21:11:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrey Abramov <st5pub@yandex.ru>,
Subject: Re: [PATCH 2/5] powerpc: module_[32|64].c: replace swap function with
 built-in one
In-Reply-To: <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net>
Date: Mon, 01 Apr 2019 21:11:19 +1100
Message-ID: <87zhpaox14.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrey Abramov <st5pub@yandex.ru> writes:

> Replace relaswap with built-in one, because of relaswap
> does a simple byte to byte swap.
>
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> ---
>  arch/powerpc/kernel/module_32.c | 17 +----------------
>  arch/powerpc/kernel/module_64.c | 17 +----------------
>  2 files changed, 2 insertions(+), 32 deletions(-)

This looks OK. It's a bit of a pity to replace the 8-byte-at-a-time copy
with a byte-at-a-time copy, but I suspect it's insignificant compared to
the overhead of calling the comparison and swap functions.

And we could always add a generic 8-byte-at-a-time swap function if it's
a bottleneck.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
> index 88d83771f462..c311e8575d10 100644
> --- a/arch/powerpc/kernel/module_32.c
> +++ b/arch/powerpc/kernel/module_32.c
> @@ -79,21 +79,6 @@ static int relacmp(const void *_x, const void *_y)
>  		return 0;
>  }
>  
> -static void relaswap(void *_x, void *_y, int size)
> -{
> -	uint32_t *x, *y, tmp;
> -	int i;
> -
> -	y = (uint32_t *)_x;
> -	x = (uint32_t *)_y;
> -
> -	for (i = 0; i < sizeof(Elf32_Rela) / sizeof(uint32_t); i++) {
> -		tmp = x[i];
> -		x[i] = y[i];
> -		y[i] = tmp;
> -	}
> -}
> -
>  /* Get the potential trampolines size required of the init and
>     non-init sections */
>  static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
> @@ -130,7 +115,7 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
>  			 */
>  			sort((void *)hdr + sechdrs[i].sh_offset,
>  			     sechdrs[i].sh_size / sizeof(Elf32_Rela),
> -			     sizeof(Elf32_Rela), relacmp, relaswap);
> +			     sizeof(Elf32_Rela), relacmp, NULL);
>  
>  			ret += count_relocs((void *)hdr
>  					     + sechdrs[i].sh_offset,
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 8661eea78503..0c833d7f36f1 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -231,21 +231,6 @@ static int relacmp(const void *_x, const void *_y)
>  		return 0;
>  }
>  
> -static void relaswap(void *_x, void *_y, int size)
> -{
> -	uint64_t *x, *y, tmp;
> -	int i;
> -
> -	y = (uint64_t *)_x;
> -	x = (uint64_t *)_y;
> -
> -	for (i = 0; i < sizeof(Elf64_Rela) / sizeof(uint64_t); i++) {
> -		tmp = x[i];
> -		x[i] = y[i];
> -		y[i] = tmp;
> -	}
> -}
> -
>  /* Get size of potential trampolines required. */
>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  				    const Elf64_Shdr *sechdrs)
> @@ -269,7 +254,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  			 */
>  			sort((void *)sechdrs[i].sh_addr,
>  			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
> -			     sizeof(Elf64_Rela), relacmp, relaswap);
> +			     sizeof(Elf64_Rela), relacmp, NULL);
>  
>  			relocs += count_relocs((void *)sechdrs[i].sh_addr,
>  					       sechdrs[i].sh_size
> -- 
> 2.21.0
