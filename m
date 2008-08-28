Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 58BBFDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 13:47:26 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so206810rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 20:47:24 -0700 (PDT)
Message-ID: <f608b67d0808272047i1c455c8bsb820d61bd8051bcf@mail.gmail.com>
Date: Wed, 27 Aug 2008 20:47:24 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: mmap and ppc460gt
In-Reply-To: <adak5e1kf2u.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	<adawsi2j8wt.fsf@cisco.com> <adak5e1kf2u.fsf@cisco.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 8:12 PM, Roland Dreier <rdreier@cisco.com> wrote:
> OK, please try this and let me know if it helps:
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 1c93c25..98d7bf9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -75,11 +75,10 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
>
>  int page_is_ram(unsigned long pfn)
>  {
> -       unsigned long paddr = (pfn << PAGE_SHIFT);
> -
>  #ifndef CONFIG_PPC64   /* XXX for now */
> -       return paddr < __pa(high_memory);
> +       return pfn < max_pfn;
>  #else
> +       unsigned long paddr = (pfn << PAGE_SHIFT);
>        int i;
>        for (i=0; i < lmb.memory.cnt; i++) {
>                unsigned long base;
>

Ronald, thank you for the hint,  I actually tried something slightly different:

return pfn < (__pa(high_memory) >> PAGE_SHIFT);

and it worked. I guess your fix is faster, I'll try it tomorrow.

I also checked that the problem is there in the top of the tree in
Linus' git - isn't it amazing - I guess very few people use mmap()
nowadays, everybody must be using UIO device :-)

cheers,
vadim
