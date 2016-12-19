Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjCnv68ZrzDxcZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 07:54:11 +1100 (AEDT)
Message-ID: <1482180827.15937.30.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/5] powerpc/mm: set the radix linear page mapping size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Date: Tue, 20 Dec 2016 07:53:47 +1100
In-Reply-To: <8760mguwfx.fsf@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-2-git-send-email-arbab@linux.vnet.ibm.com>
 <8760mguwfx.fsf@linux.vnet.ibm.com>
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

On Mon, 2016-12-19 at 14:28 +0530, Aneesh Kumar K.V wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
> > This was defaulting to 4K, regardless of PAGE_SIZE.
> > 
> > Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/mm/pgtable-radix.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c
> > b/arch/powerpc/mm/pgtable-radix.c
> > index 623a0dc..54bd70e 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -351,8 +351,10 @@ void __init radix__early_init_mmu(void)
> >  #ifdef CONFIG_PPC_64K_PAGES
> >  	/* PAGE_SIZE mappings */
> >  	mmu_virtual_psize = MMU_PAGE_64K;
> > +	mmu_linear_psize = MMU_PAGE_64K;
> 
> That is not clearly correct, we map the linear address with either
> 64K,
> 2M or 1G depending on the memory available. Take a look at
> static void __init radix_init_pgtable(void)
> 

So should we fix that initialization regardless or take it out ?
> 
> >  #else
> >  	mmu_virtual_psize = MMU_PAGE_4K;
> > +	mmu_linear_psize = MMU_PAGE_4K;
> >  #endif
> > 
> >  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> > -- 
> > 1.8.3.1
