Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN9f80jNDzDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 10:19:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 03/24] powerpc/6xx: Handle DABR match before calling
 do_page_fault
In-Reply-To: <20170719044946.22030-3-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-3-benh@kernel.crashing.org>
Date: Thu, 03 Aug 2017 10:19:10 +1000
Message-ID: <87k22lqz9d.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On legacy 6xx 32-bit procesors, we checked for the DABR match bit
> in DSISR from do_page_fault(), in the middle of a pile of ifdef's
> because all other CPU types do it in assembly prior to calling
> do_page_fault. Fix that.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/entry_32.S | 11 +++++++++++
>  arch/powerpc/mm/fault.c        |  9 ---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 8587059ad848..7331df033804 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -586,6 +586,8 @@ ppc_swapcontext:
>  handle_page_fault:
>  	stw	r4,_DAR(r1)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	andis.  r0,r5,DSISR_DABRMATCH@h
> +	bne-    handle_dabr_fault
>  	bl	do_page_fault
>  	cmpwi	r3,0
>  	beq+	ret_from_except
> @@ -599,6 +601,15 @@ handle_page_fault:
>  	bl	bad_page_fault
>  	b	ret_from_except_full
>  
> +	/* We have a data breakpoint exception - handle it */
> +handle_dabr_fault:
> +	SAVE_NVGPRS(r1)
> +	lwz	r0,_TRAP(r1)
> +	clrrwi	r0,r0,1
> +	stw	r0,_TRAP(r1)
> +	bl      do_break
> +	b	ret_from_except_full

This breaks ~35% of the defconfigs.

eg. ppc44x_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/13113408/

  arch/powerpc/kernel/entry_32.S:(.text+0x7ac): undefined reference to `do_break'

For now I've just wrapped the asm above in:

+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || defined(CONFIG_PPC_8xx))

But would be happy if there was something less gross.

cheers
