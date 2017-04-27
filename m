Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsB27FpzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:54 +1000 (AEST)
In-Reply-To: <20170418062013.954766E624@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/mm: Fix page table dump build on PPC32
Message-Id: <3wDCsB1WYZz9sNN@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 06:20:13 UTC, Christophe Leroy wrote:
> On PPC32 (ex: mpc885_ads_defconfig), page table dump compilation
> fails as follows. This is because the memory layout is slightly
> different on PPC32. This patch adapts it.
> 
>   CC      arch/powerpc/mm/dump_linuxpagetables.o
> arch/powerpc/mm/dump_linuxpagetables.c: In function 'walk_pagetables':
> arch/powerpc/mm/dump_linuxpagetables.c:369:10: error: 'KERN_VIRT_START' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:369:10: note: each undeclared identifier is reported only once for each function it appears in
> arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
> arch/powerpc/mm/dump_linuxpagetables.c:383:37: error: 'ISA_IO_BASE' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:384:37: error: 'ISA_IO_END' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:385:37: error: 'PHB_IO_BASE' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:386:37: error: 'PHB_IO_END' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:387:37: error: 'IOREMAP_BASE' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:388:37: error: 'IOREMAP_END' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c:392:38: error: 'VMEMMAP_BASE' undeclared (first use in this function)
> arch/powerpc/mm/dump_linuxpagetables.c: In function 'ptdump_show':
> arch/powerpc/mm/dump_linuxpagetables.c:400:20: error: 'KERN_VIRT_START' undeclared (first use in this function)
> make[1]: *** [arch/powerpc/mm/dump_linuxpagetables.o] Error 1
> make: *** [arch/powerpc/mm] Error 2
> 
> Fixes: 8eb07b187000d ("powerpc/mm: Dump linux pagetables")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fab9fe1f9ff6836a82bf8bdb26e67

cheers
