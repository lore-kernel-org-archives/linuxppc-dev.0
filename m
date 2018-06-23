Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Chp31gQgzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 03:12:43 +1000 (AEST)
Subject: =?UTF-8?Q?Re:_[PATCH]_powerpc/mm:_remove_warning_about_=e2=80=98typ?=
 =?UTF-8?Q?e=e2=80=99_being_set?=
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20180622192749.24954-1-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
Date: Sat, 23 Jun 2018 19:12:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180622192749.24954-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> ‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
> unused tag to variable. Remove warning treated as error with W=1:
> 
>    arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]

Is type neeeded at all when CONFIG_DEBUG_HIGHMEM is not set ?

The call 	type = kmap_atomic_idx();          seems useless when 
CONFIG_DEBUG_HIGHMEM isn't set. Couldn't we just most type definition 
and setting inside the CONFIG_DEBUG_HIGHMEM {} below ?

Alternatively, maybe you could replace the #ifdef CONFIG_DEBUG_HIGHMEM 
by an    if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) ?

Christophe

> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/mm/highmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
> index 668e87d03f9e..82a0e37557a5 100644
> --- a/arch/powerpc/mm/highmem.c
> +++ b/arch/powerpc/mm/highmem.c
> @@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>   void __kunmap_atomic(void *kvaddr)
>   {
>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> -	int type;
> +	int type __maybe_unused;
>   
>   	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
>   		pagefault_enable();
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
