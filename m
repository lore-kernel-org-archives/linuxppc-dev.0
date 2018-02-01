Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX7Dq6zXczDrHM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 15:58:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>, aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] powerpc/mm/radix: Add tlbflush routines
In-Reply-To: <20180131154521.GA21698@mwanda>
References: <20180131154521.GA21698@mwanda>
Date: Thu, 01 Feb 2018 15:58:50 +1100
Message-ID: <87fu6le25x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Aneesh Kumar K.V,
>
> The patch 1a472c9dba6b: "powerpc/mm/radix: Add tlbflush routines"
> from Apr 29, 2016, leads to the following static checker warning:
>
> 	arch/powerpc/mm/tlb_nohash.c:218 __local_flush_tlb_page()
> 	warn: always true condition '(pid != ~0) => (0-u32max != u64max)'
>
> arch/powerpc/mm/tlb_nohash.c
>    211  void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
>    212                              int tsize, int ind)
>    213  {
>    214          unsigned int pid;
>    215  
>    216          preempt_disable();
>    217          pid = mm ? mm->context.id : 0;
>    218          if (pid != MMU_NO_CONTEXT)
>                     ^^^^^^^^^^^^^^^^^^^^^
>    219                  _tlbil_va(vmaddr, pid, tsize, ind);
>    220          preempt_enable();
>    221  }
>
> I don't know very much about PowerPC.  The static checker is guessing
> which headers to pull in instead of relying on the build system so there
> are a lot of false positives.

O_o 

That's a bit nuts ... :)

> It's apparently using the arch/powerpc/include/asm/book3s/64/tlbflush.h header which does:
>
> #define MMU_NO_CONTEXT ~0UL
>
> so it's UINT_MAX vs U64_MAX which is making the checker complain.

That's the wrong header for that file.

It should be arch/powerpc/include/asm/tlbflush.h, which does one of:

  #define MMU_NO_CONTEXT      ((unsigned int)-1)
  #define MMU_NO_CONTEXT      (0)


So I think the code is OK in this case.

The clue is that the code is in tlb_nohash.c, but the header is
book3s/64, and Book3S doesn't use the nohash style MMUs.

Thanks for trying, powerpc has the unfortunate feature of supporting
feature of supporting about 5 different MMUs, which means this area of
the code is pretty gross.

cheers
