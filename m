Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRhjs1ysbzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 10:50:08 +1100 (AEDT)
Message-ID: <1516837782.2312.10.camel@kernel.crashing.org>
Subject: Re: Are those hacks still valid on powerpc kernel ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 25 Jan 2018 10:49:42 +1100
In-Reply-To: <c0b2f3ad-3247-1b80-8789-e120c3ebd8bc@c-s.fr>
References: <c0b2f3ad-3247-1b80-8789-e120c3ebd8bc@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-24 at 11:17 +0100, Christophe LEROY wrote:
> Below comments are very old.
> 
> Aren't new glibc and binutils now able to go without this ?
> 
> Note that the code inside the #if 0 is wrong as we have no vma defined 
> in the function.
> 
> Or does it just have no performance impact anyway ?
> 
> 
>  From /arch/powerpc/mm/mem.c:
> 
> void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
> {
> 	clear_page(page);
> 
> 	/*
> 	 * We shouldn't have to do this, but some versions of glibc
> 	 * require it (ld.so assumes zero filled pages are icache clean)
> 	 * - Anton
> 	 */
> 	flush_dcache_page(pg);
> }
> EXPORT_SYMBOL(clear_user_page);

Well, I think it would be a security issue to potentially leave garbage
icache content (possibly instructions from another process) accessible
to userspace. So I don't think we can avoid that one.

> void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
> 		    struct page *pg)
> {
> 	copy_page(vto, vfrom);
> 
> 	/*
> 	 * We should be able to use the following optimisation, however
> 	 * there are two problems.
> 	 * Firstly a bug in some versions of binutils meant PLT sections
> 	 * were not marked executable.
> 	 * Secondly the first word in the GOT section is blrl, used
> 	 * to establish the GOT address. Until recently the GOT was
> 	 * not marked executable.
> 	 * - Anton
> 	 */
> #if 0
> 	if (!vma->vm_file && ((vma->vm_flags & VM_EXEC) == 0))
> 		return;
> #endif

Well, we try not to break userspace.... This doesn't affect newer CPUs
that much because they have CPU_FTR_COHERENT_ICACHE, so
flush_dcache_page is pretty much a nop on them.

Cheers,
Ben.

> 	flush_dcache_page(pg);
> }
> 
> Christophe
