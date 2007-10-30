Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D6D2DE135
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 14:20:53 +1100 (EST)
In-Reply-To: <20071029224624.68205DE157@ozlabs.org>
References: <20071029224624.68205DE157@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <94E7B69E-5ED0-4805-AD31-DB98119A3DC7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix 4xx flush_tlb_page()
Date: Mon, 29 Oct 2007 22:22:01 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 29, 2007, at 5:46 PM, Benjamin Herrenschmidt wrote:

> On 4xx CPUs, the current implementation of flush_tlb_page() uses
> a low level _tlbie() assembly function that only works for the
> current PID. Thus, invalidations caused by, for example, a COW
> fault triggered by get_user_pages() from a different context will
> not work properly, causing among other things, gdb breakpoints
> to fail.
>
> This patch adds a "pid" argument to _tlbie() on 4xx processors,
> and uses it to flush entries in the right context. FSL BookE
> also gets the argument but it seems they don't need it (their
> tlbivax form ignores the PID when invalidating according to the
> document I have).
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
>  arch/powerpc/kernel/misc_32.S    |   23 ++++++++++++++++-------
>  arch/powerpc/mm/fault.c          |    2 +-
>  arch/powerpc/mm/mmu_decl.h       |    4 ++--
>  arch/ppc/kernel/misc.S           |   22 +++++++++++++++-------
>  arch/ppc/mm/fault.c              |    2 +-
>  arch/ppc/mm/mmu_decl.h           |    4 ++--
>  arch/ppc/platforms/4xx/ebony.c   |    2 +-
>  arch/ppc/platforms/4xx/ocotea.c  |    2 +-
>  arch/ppc/platforms/4xx/taishan.c |    2 +-
>  include/asm-powerpc/tlbflush.h   |   12 ++++++------
>  10 files changed, 46 insertions(+), 29 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
