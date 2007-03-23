Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:30:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/10] Port 44x MMU definitions to ARCH=powerpc
Message-ID: <20070323233034.GB4459@localhost.localdomain>
References: <20070322092202.20D73DDF32@ozlabs.org>
	<DB443D82-5C88-45F9-BF32-F12AA11244AA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB443D82-5C88-45F9-BF32-F12AA11244AA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 09:09:11AM -0500, Kumar Gala wrote:
> 
> On Mar 22, 2007, at 4:22 AM, David Gibson wrote:
> 
> > This patch moves the mmu.h definitions which are still relevant for
> > ARCH=powerpc from include/asm-ppc/mmu.h to their own file,
> > include/asm-powerpc/mmu_44x.h.  The new file is included from
> > asm-powerpc/mmu.h, and a couple of other tweaks to correct mmu
> > definitions for 44x are made.
> >
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > ---
> >
> >  arch/powerpc/kernel/head_44x.S    |    4 -
> >  arch/powerpc/mm/44x_mmu.c         |   81 ++++++ 
> > +-------------------------------
> >  arch/powerpc/mm/mmu_decl.h        |    2
> >  include/asm-powerpc/mmu-44x/mmu.h |   75 ++++++++++++++++++++++++++ 
> > +++++++++
> >  include/asm-powerpc/mmu.h         |   11 ++++-
> >  5 files changed, 105 insertions(+), 68 deletions(-)
> 
> Any reason you are creating a new directory in include/asm-powerpc  
> for 44x mmu defn?  why not just mmu_44x.h or something like that?

Heh, Stephen asked me that too, in person.

Originally I did use mmu_44x.h, but I'm looking ahead.  In the middle
term, I want to purge the last dependencies on include/asm-ppc from
include/asm-powerpc, which currently includes all the mm headers:
mmu.h, pgtable.h, pgalloc.h, possibly a couple of others.

It seems most sensible to me to have a subdirectory for each mmu
family (32-bit has, 64-bit hash, 40x, 44x, FSL Book E, etc..) , with
the relevant version of each of these files.  This patch is a first
tiny step in that direction.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
