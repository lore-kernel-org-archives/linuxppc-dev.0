Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWnzZ0B0BzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 03:01:13 +1100 (AEDT)
Subject: Re: [bug report] powerpc/mm/radix: Add tlbflush routines
To: Dan Carpenter <dan.carpenter@oracle.com>, aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180131154521.GA21698@mwanda>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <8ada45aa-9b29-408c-ba6f-c0938dce047b@c-s.fr>
Date: Wed, 31 Jan 2018 17:01:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180131154521.GA21698@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 31/01/2018 à 16:45, Dan Carpenter a écrit :
> Hello Aneesh Kumar K.V,
> 
> The patch 1a472c9dba6b: "powerpc/mm/radix: Add tlbflush routines"
> from Apr 29, 2016, leads to the following static checker warning:
> 
> 	arch/powerpc/mm/tlb_nohash.c:218 __local_flush_tlb_page()
> 	warn: always true condition '(pid != ~0) => (0-u32max != u64max)'
> 
> arch/powerpc/mm/tlb_nohash.c
>     211  void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
>     212                              int tsize, int ind)
>     213  {
>     214          unsigned int pid;
>     215
>     216          preempt_disable();
>     217          pid = mm ? mm->context.id : 0;
>     218          if (pid != MMU_NO_CONTEXT)
>                      ^^^^^^^^^^^^^^^^^^^^^
>     219                  _tlbil_va(vmaddr, pid, tsize, ind);
>     220          preempt_enable();
>     221  }
> 
> I don't know very much about PowerPC.  The static checker is guessing
> which headers to pull in instead of relying on the build system so there
> are a lot of false positives.  It's apparently using the
> arch/powerpc/include/asm/book3s/64/tlbflush.h header which does:
> 
> #define MMU_NO_CONTEXT ~0UL
> 
> so it's UINT_MAX vs U64_MAX which is making the checker complain.

As far as I can see from arch/powerpc/include/asm/mmu-hash64.h, 
mm->context.id is an unsigned long, so pid should also be an unsigned 
long, not an unsigned int ?

Christophe

> 
> regards,
> dan carpenter
> 
