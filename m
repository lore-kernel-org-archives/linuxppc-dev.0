Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18327.51186.788355.453524@cargo.ozlabs.ibm.com>
Date: Thu, 24 Jan 2008 10:04:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] Fix handling of memreserve if the range lands in
	highmem
In-Reply-To: <Pine.LNX.4.64.0801100120290.13810@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801100120290.13810@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> There were several issues if a memreserve range existed and happened
> to be in highmem:
> 
> * The bootmem allocator is only aware of lowmem so calling
>   reserve_bootmem with a highmem address would cause a BUG_ON
> * All highmem pages were provided to the buddy allocator
> 
> Added a lmb_is_reserved() api that we now use to determine if a highem
> page should continue to be PageReserved or provided to the buddy
> allocator.
> 
> Also, we incorrectly reported the amount of pages reserved since all
> highmem pages are initally marked reserved and we clear the
> PageReserved flag as we "free" up the highmem pages.

This patch breaks all the 64-bit configs since 64-bit doesn't have
total_lowmem.  The extra complexity is only needed in the
CONFIG_HIGHMEM case, so an ifdef would be one solution, though an ugly
one.  We do already have an ifdef just above the place you changed in
arch/powerpc/mm/mem.c which you could just enlarge rather than adding
a new ifdef.

And clearly I can't pull your tree until this is sorted somehow...

Paul.
