Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18445.11801.422321.151268@cargo.ozlabs.ibm.com>
Date: Tue, 22 Apr 2008 10:15:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
In-Reply-To: <C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
	<9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
	<18441.58154.608911.337978@cargo.ozlabs.ibm.com>
	<C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > Once again I want to go through it carefully and understand how it all
> > works, and in particular understand things like the way it ensures
> > that the base address for the kmap region is aligned to a 4M boundary
> > so all the kmap ptes are in a single page (assuming it does :).
> 
> I'm not clear on why this is needed.  I can see value in having the  
> PGD entry in place but the pte PAs would be changing all the time so I  
> don't see what benefit there is in keeping them in one page.

Have a look at map_new_virtual in mm/highmem.c.  In particular:

        set_pte_at(&init_mm, vaddr,
                   &(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));

assumes that the ptes that kmap uses are in a contiguous array whose
base is pkmap_page_table.

> For normal kmap ptes we cover things in one PGD via:
> 
> #define PKMAP_BASE      ((FIXADDR_BOOT_START - PAGE_SIZE*(LAST_PKMAP +  
> 1)) & PMD_MASK)

OK, that probably does the trick ... <checks> ... yes it does.

We seem to have a distinction without a difference between
FIXADDR_START and FIXADDR_BOOT_START, and similarly between
__FIXADDR_SIZE and __FIXADDR_BOOT_SIZE.  Is there any actual
difference and if not why do we have two names for the same thing?

Also, we seem to have an unnecessary distinction (and unnecessary
casting) between __FIXADDR_TOP and FIXADDR_TOP.

Regards,
Paul.
