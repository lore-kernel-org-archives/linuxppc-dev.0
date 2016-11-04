Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t98lM3KLmzDvYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 15:59:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christopher Covington <cov@codeaurora.org>, criu@openvz.org,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Christopher Covington <cov@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 6/7] mm/powerpc: Use generic VDSO remap and unmap
 functions
In-Reply-To: <20161101171101.24704-6-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
 <20161101171101.24704-6-cov@codeaurora.org>
Date: Fri, 04 Nov 2016 15:59:43 +1100
Message-ID: <87oa1vn8lc.fsf@concordia.ellerman.id.au>
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

> The PowerPC VDSO remap and unmap code was copied to a generic location,
> only modifying the variable name expected in mm->context (vdso instead of
> vdso_base) to match most other architectures. Having adopted this generic
> naming, drop the code in arch/powerpc and use the generic version.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/powerpc/Kconfig                     |  1 +
>  arch/powerpc/include/asm/Kbuild          |  1 +
>  arch/powerpc/include/asm/mm-arch-hooks.h | 28 -------------------------
>  arch/powerpc/include/asm/mmu_context.h   | 35 +-------------------------------
>  4 files changed, 3 insertions(+), 62 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/mm-arch-hooks.h

This looks OK.

Have you tested it on powerpc? I could but I don't know how to actually
trigger these paths, I assume I need a CRIU setup?

Can you flip the subject to "powerpc/mm: ...".

cheers
