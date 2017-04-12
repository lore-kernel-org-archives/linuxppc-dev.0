Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w38mx3LbjzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 02:40:49 +1000 (AEST)
Subject: Re: [v3,1/2] powerpc/mm: Dump linux pagetables
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Rashmica Gupta <rashmicy@gmail.com>
References: <3tKKXq67gcz9t1T@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e858f33a-ee89-7a7c-02d6-de4e8ac32e26@c-s.fr>
Date: Wed, 12 Apr 2017 18:40:45 +0200
MIME-Version: 1.0
In-Reply-To: <3tKKXq67gcz9t1T@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rashmica,

Le 17/11/2016 à 13:03, Michael Ellerman a écrit :
> On Fri, 2016-27-05 at 05:48:59 UTC, Rashmica Gupta wrote:
>> Useful to be able to dump the kernels page tables to check permissions
>> and memory types - derived from arm64's implementation.
>>
>> Add a debugfs file to check the page tables. To use this the PPC_PTDUMP
>> config option must be selected.
>>
>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/8eb07b187000d48152c4ef97f075bd

For your information, compilation fails on mpc885_ads_defconfig when we 
activate PPC_PTDUMP:

   CC      arch/powerpc/mm/dump_linuxpagetables.o
arch/powerpc/mm/dump_linuxpagetables.c: In function 'walk_pagetables':
arch/powerpc/mm/dump_linuxpagetables.c:369:10: error: 'KERN_VIRT_START' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:369:10: note: each undeclared 
identifier is reported only once for each function it appears in
arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
arch/powerpc/mm/dump_linuxpagetables.c:383:37: error: 'ISA_IO_BASE' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:384:37: error: 'ISA_IO_END' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:385:37: error: 'PHB_IO_BASE' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:386:37: error: 'PHB_IO_END' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:387:37: error: 'IOREMAP_BASE' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:388:37: error: 'IOREMAP_END' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:392:38: error: 'VMEMMAP_BASE' 
undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c: In function 'ptdump_show':
arch/powerpc/mm/dump_linuxpagetables.c:400:20: error: 'KERN_VIRT_START' 
undeclared (first use in this function)
make[1]: *** [arch/powerpc/mm/dump_linuxpagetables.o] Error 1
make: *** [arch/powerpc/mm] Error 2



Christophe
