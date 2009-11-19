Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38825B7B75
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 00:55:32 +1100 (EST)
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1258441832-20133-1-git-send-email-leoli@freescale.com>
Date: Thu, 19 Nov 2009 07:55:22 -0600
Message-Id: <8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2009, at 1:10 AM, Li Yang wrote:

> Rather than the original intelligent way, we grant user more freedom.
> This enables user to map cacheable memory not managed by Linux.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> The only direct users of this function is fb_mmap() and /dev/mem mmap.
> Although I'm not sure if anything is depending on the intelligent  
> setting of
> cacheability.

is there some reason to change this?

- k

>
> arch/powerpc/mm/mem.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 579382c..0fd267e 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -101,7 +101,7 @@ pgprot_t phys_mem_access_prot(struct file *file,  
> unsigned long pfn,
> 	if (ppc_md.phys_mem_access_prot)
> 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
>
> -	if (!page_is_ram(pfn))
> +	if (file->f_flags & O_SYNC)
> 		vma_prot = pgprot_noncached(vma_prot);
>
> 	return vma_prot;
> -- 
> 1.6.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
