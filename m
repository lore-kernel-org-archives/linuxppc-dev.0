Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA4ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35DD214D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35DD214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZpSQ4zVhzF3WK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZpQT0qH7zF3V3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:32:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZpQP4HQMz9sC2;
 Wed, 17 Oct 2018 21:32:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3
 12/24] powerpc/mm: use pte helpers in generic code)
In-Reply-To: <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
 <87va61jsma.fsf@concordia.ellerman.id.au>
 <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
Date: Wed, 17 Oct 2018 21:32:10 +1100
Message-ID: <87efcoeudx.fsf@concordia.ellerman.id.au>
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
...
>> The question is what's the right way to fix it? Should pte_pgprot() not
>> be filtering those bits out on book3e?
>
> I think we should not use pte_pggrot() for that then. What about the 
> below fix ?

Thanks, that almost works.

pte_mkprivileged() also needs to not strip _PAGE_BAP_SR.


But there's also a use of pte_pgprot() in mm/memory.c, and I think that
is also broken now that we don't add PAGE_KERNEL back in.

Aneesh is going to do a patch to make pte_pgprot() only mask the PFN
which is what other arches do.

cheers

> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Date: Wed, 17 Oct 2018 05:56:25 +0000
> Subject: [PATCH] powerpc/mm: don't use pte_pgprot() in ioremap_prot()
>
> pte_pgprot() filters out some required flags like _PAGE_PRESENT.
>
> This patch replaces pte_pgprot() by __pgprot(pte_val())
> in ioremap_prot()
>
> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/pgtable_32.c | 3 ++-
>   arch/powerpc/mm/pgtable_64.c | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 5877f5aa8f5d..a606e2f4937b 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -122,7 +122,8 @@ ioremap_prot(phys_addr_t addr, unsigned long size, 
> unsigned long flags)
>   	pte = pte_exprotect(pte);
>   	pte = pte_mkprivileged(pte);
>
> -	return __ioremap_caller(addr, size, pte_pgprot(pte), 
> __builtin_return_address(0));
> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)),
> +				__builtin_return_address(0));
>   }
>   EXPORT_SYMBOL(ioremap_prot);
>
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index fb1375c07e8c..836bf436cabb 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -245,8 +245,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, 
> unsigned long size,
>   	pte = pte_mkprivileged(pte);
>
>   	if (ppc_md.ioremap)
> -		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
> -	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
> +		return ppc_md.ioremap(addr, size, __pgprot(pte_val(pte)), caller);
> +	return __ioremap_caller(addr, size, __pgprot(pte_val(pte)), caller);
>   }
>
>
> -- 
> 2.13.3
