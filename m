Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t98jq5WzDzDvXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 15:58:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christopher Covington <cov@codeaurora.org>, criu@openvz.org,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 akpm@linux-foundation.org <akpm@linux-foundation.org>
Cc: Christopher Covington <cov@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/7] powerpc: Rename context.vdso_base to context.vdso
In-Reply-To: <20161101171101.24704-5-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
 <20161101171101.24704-5-cov@codeaurora.org>
Date: Fri, 04 Nov 2016 15:58:22 +1100
Message-ID: <87r36rn8nl.fsf@concordia.ellerman.id.au>
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

Christopher Covington <cov@codeaurora.org> writes:

> Checkpoint/Restore In Userspace (CRIU) needs to be able to unmap and remap
> the VDSO to successfully checkpoint and restore applications in the face of
> changing VDSO addresses due to Address Space Layout Randomization (ASLR,
> randmaps). x86 and PowerPC have had architecture-specific code to support
> this. In order to expand the architectures that support this without
> unnecessary duplication of code, a generic version based on the PowerPC code
> was created. It differs slightly, based on the results of an informal
> survey of all architectures that indicated
>
> 	unsigned long vdso;
>
> is popular (and it's also concise). Therefore, change the variable name in
> powerpc from mm->context.vdso_base to mm->context.vdso.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +-
>  arch/powerpc/include/asm/mm-arch-hooks.h      |  6 +++---
>  arch/powerpc/include/asm/mmu-40x.h            |  2 +-
>  arch/powerpc/include/asm/mmu-44x.h            |  2 +-
>  arch/powerpc/include/asm/mmu-8xx.h            |  2 +-
>  arch/powerpc/include/asm/mmu-book3e.h         |  2 +-
>  arch/powerpc/include/asm/mmu_context.h        |  4 ++--
>  arch/powerpc/include/asm/vdso.h               |  2 +-
>  arch/powerpc/include/uapi/asm/elf.h           |  2 +-
>  arch/powerpc/kernel/signal_32.c               |  8 ++++----
>  arch/powerpc/kernel/signal_64.c               |  4 ++--
>  arch/powerpc/kernel/vdso.c                    |  8 ++++----
>  arch/powerpc/perf/callchain.c                 | 12 ++++++------
>  14 files changed, 29 insertions(+), 29 deletions(-)

This is kind of annoying, but I guess it's worth doing.

It's going to conflict like hell though. Who were you thinking would
merge this series? I think it should go via Andrew Morton's tree, as
that way if we get bad conflicts we can pull it out and redo it.

Assuming we agree on that I'm happy to ack it:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
