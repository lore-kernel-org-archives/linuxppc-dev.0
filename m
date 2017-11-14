Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG401LjzDqpX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:12 +1100 (AEDT)
In-Reply-To: <20171030110112.17634-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5] powerpc/xmon: Support dumping software pagetables
Message-Id: <3yblG366Vqz9t16@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-30 at 11:01:12 UTC, Balbir Singh wrote:
> It would be nice to be able to dump page tables in a particular
> context.
> 
> eg: dumping vmalloc space:
> 
>   0:mon> dv 0xd00037fffff00000
>   pgd  @ 0xc0000000017c0000
>   pgdp @ 0xc0000000017c00d8 = 0x00000000f10b1000
>   pudp @ 0xc0000000f10b13f8 = 0x00000000f10d0000
>   pmdp @ 0xc0000000f10d1ff8 = 0x00000000f1102000
>   ptep @ 0xc0000000f1102780 = 0xc0000000f1ba018e
>   Maps physical address = 0x00000000f1ba0000
>   Flags = Accessed Dirty Read Write
> 
> This patch does not replicate the complex code of dump_pagetable and
> has no support for bolted linear mapping, thats why I've it's called
> dump virtual page table support. The format of the PTE can be expanded
> even further to add more useful information about the flags in the PTE
> if required.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> [mpe: Bike shed the output format, show the pgdir]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/80eff6c484799722736471d15ff9cc

cheers
