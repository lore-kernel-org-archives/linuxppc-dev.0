Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18429.33325.923972.430150@cargo.ozlabs.ibm.com>
Date: Thu, 10 Apr 2008 12:57:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Status of patches (ppc32 mm init clean and 85xx kernel reloc)
In-Reply-To: <88C63CCF-7ED6-486F-8E95-FABD6CEE92E0@kernel.crashing.org>
References: <88C63CCF-7ED6-486F-8E95-FABD6CEE92E0@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> [POWERPC] bootwrapper: Allow specifying of image physical offset
> 
> reworked to look at PHDR (needs linker script update patch).  Still  
> open question on how best to do that (objdump, readelf, C program,  
> suggestions)

Just replied about that one.

> [POWERPC] Remove Kconfig option BOOT_LOAD
> 
> should be acceptable.

Looks OK.

> [POWERPC] Provide access to arch/powerpc include path on ppc64

Looks OK.

> [POWERPC] Remove and replace uses of PPC_MEMSTART with memstart_addr
> 
> You had some questions about _stext and the PAGE_OFFSET vs  
> KERNELBASE.  Not sure if you are satisfied with the answers.

The kdump guys don't seem to be concerned, so I guess it's OK.

> [POWERPC] Introduce lowmem_end_addr to distiguish from total_lowmem

OK.

> [POWERPC] 85xx: Cleanup TLB initialization
> 
> Only effects 85xx and I don't have issues with it :)

Cool :)

> [POWERPC] Use lowmem_end_addr to limit lmb allocations on ppc32

Looks fine.

> [POWERPC] Rename __initial_memory_limit to __initial_memory_limit_addr

Looks OK, though it seems a tad unnecessary.

> [POWERPC] Clean up some linker and symbol usage
> 
> No comments.  Straight forward patch.

Well, it is changing behaviour.  In particular, klimit is not
necessarily the same as _end.  It starts out initialized to &_end but
then gets advanced by some allocations very early in the boot IIRC.
It might be true by now that nothing reserves memory by advancing
klimit any more, but if that is true then the patch description needs
to mention that klimit is no longer used and this patch makes it no
longer usable.  In fact in that case you should remove all mention of
klimit.

Also, this patch means that the region from PHYSICAL_START to
__pa(stext) is no longer reserved, which is another behaviour change
that deserves to be mentioned.

> [POWERPC] Move phys_addr_t definition into asm/types.h
> 
> I had an open question if the Kconfig for PHYS_64BIT should get set on  
> PPC64 as well (has not effect).
> 
> I reworked the asm/types.h bits to look like:
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
> +typedef __u64 phys_addr_t;
> +#else
> +typedef __u32 phys_addr_t;
> +#endif

That looks OK.

> [POWERPC] 85xx: Add support for relocatble kernel (and booting at non- 
> zero
> 
> Should probably get a bit more review.
> 
> [POWERPC] Update linker script to properly set physical addresses
> 
> You felt LOAD_OFFSET should be (CONFIG_PAGE_OFFSET -  
> CONFIG_PHYSICAL_START).  I disagreed.  We need to resolve.

I think you're right, actually, now, assuming that
CONFIG_PHYSICAL_START is the physical address of the start of the
kernel (actually, why don't you use that instead of __pa(stext) in
your patch [9/11]?).

> I think we should be able to quickly resolve and get into powerpc-next  
> all but the '85xx: Add support for relocatable kernel' and  
> 'bootwrapper: Allow specifying of image..' patches.  If we can close  
> on the phys_addr_t and linker script patches that would be great.

I'll put in the ones that look OK, and wait for you to resend the
others.

Paul.
