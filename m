Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <93f533baba2b2f73ac9ec46b5401747e@freescale.com>
References: <93f533baba2b2f73ac9ec46b5401747e@freescale.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 16:53:38 +1000
Message-Id: <1112770418.9567.137.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 01:51 -0500, Kumar Gala wrote:
> Paul,
> 
> I've tracked down a bug I've been having to the fact that pte_update 
> assumes a pte is a unsigned long.  I need to look into what the exact 
> implications this has.  I was wondering what the thoughts were with 
> respect to how this is suppose to work properly on 440 with its 64-bit 
> pte?  I'm looking at a 64-bit pte for some Freescale book-e parts as we 
> move to 36-bit physical address support.
> 
> The problem I found was ptep_get_and_clear() would return back only a 
> 32-bit value and thus we loose any information in the upper 32-bits.  I 
> found the call in sys_mprotect ... -> change_pte_range -> 
> ptep_get_and_clear()
> 
> Will provide some update on this tomorrow.

It's quite important for the flags to all be together in a single 32
bits entity so that atomic operations can be done on them. The RPN
should be able to extend beyond the initial 32 bits provided we are
careful about the way we manipulate the PTEs. When setting a PTE, we
should always first set the "other" part, then the PTE present bit last
or a CPU would possibly get a stale PTE. The problem with that scheme is
that I can see possible races on dual page faults trying to fill in the
same PTE if we drop the page table lock (christoph lameter stuff) but it
should work for us now.

Ben.
