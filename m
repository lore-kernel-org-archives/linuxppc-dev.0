Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t9Y1q6xpQzDvcp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 07:13:35 +1100 (AEDT)
Date: Fri, 4 Nov 2016 20:13:32 +0000
From: Will Deacon <will.deacon@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christopher Covington <cov@codeaurora.org>, criu@openvz.org,
 linux-mm@kvack.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/7] powerpc: Rename context.vdso_base to context.vdso
Message-ID: <20161104201332.GB22791@arm.com>
References: <20161101171101.24704-1-cov@codeaurora.org>
 <20161101171101.24704-5-cov@codeaurora.org>
 <87r36rn8nl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r36rn8nl.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[fixing akpm's email address]

On Fri, Nov 04, 2016 at 03:58:22PM +1100, Michael Ellerman wrote:
> Christopher Covington <cov@codeaurora.org> writes:
> 
> > Checkpoint/Restore In Userspace (CRIU) needs to be able to unmap and remap
> > the VDSO to successfully checkpoint and restore applications in the face of
> > changing VDSO addresses due to Address Space Layout Randomization (ASLR,
> > randmaps). x86 and PowerPC have had architecture-specific code to support
> > this. In order to expand the architectures that support this without
> > unnecessary duplication of code, a generic version based on the PowerPC code
> > was created. It differs slightly, based on the results of an informal
> > survey of all architectures that indicated
> >
> > 	unsigned long vdso;
> >
> > is popular (and it's also concise). Therefore, change the variable name in
> > powerpc from mm->context.vdso_base to mm->context.vdso.
> >
> > Signed-off-by: Christopher Covington <cov@codeaurora.org>
> > ---
> >  arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 +-
> >  arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
> >  arch/powerpc/include/asm/mm-arch-hooks.h      |  6 +++---
> >  arch/powerpc/include/asm/mmu-40x.h            |  2 +-
> >  arch/powerpc/include/asm/mmu-44x.h            |  2 +-
> >  arch/powerpc/include/asm/mmu-8xx.h            |  2 +-
> >  arch/powerpc/include/asm/mmu-book3e.h         |  2 +-
> >  arch/powerpc/include/asm/mmu_context.h        |  4 ++--
> >  arch/powerpc/include/asm/vdso.h               |  2 +-
> >  arch/powerpc/include/uapi/asm/elf.h           |  2 +-
> >  arch/powerpc/kernel/signal_32.c               |  8 ++++----
> >  arch/powerpc/kernel/signal_64.c               |  4 ++--
> >  arch/powerpc/kernel/vdso.c                    |  8 ++++----
> >  arch/powerpc/perf/callchain.c                 | 12 ++++++------
> >  14 files changed, 29 insertions(+), 29 deletions(-)
> 
> This is kind of annoying, but I guess it's worth doing.
> 
> It's going to conflict like hell though. Who were you thinking would
> merge this series? I think it should go via Andrew Morton's tree, as
> that way if we get bad conflicts we can pull it out and redo it.

The other thing you can do is generate the patch towards the end of the
merge window and send it as a separate pull request. The disadvantage of
that is that it can't spend any time in -next, but that might be ok for a
mechanical rename.

Will
