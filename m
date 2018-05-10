Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZld1ccgzF2CH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:37 +1000 (AEST)
In-Reply-To: <20180504123834.GA16581@lst.de>
To: Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-Id: <40hZlc4mBGz9s1B@ozlabs.org>
Date: Fri, 11 May 2018 00:06:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-04 at 12:38:34 UTC, Torsten Duwe wrote:
> The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> 
> [...] There are several rules that must be adhered to in order to ensure
> reliable and consistent call chain backtracing:
> 
> * Before a function calls any other function, it shall establish its
>   own stack frame, whose size shall be a multiple of 16 bytes.
> 
>  – In instances where a function’s prologue creates a stack frame, the
>    back-chain word of the stack frame shall be updated atomically with
>    the value of the stack pointer (r1) when a back chain is implemented.
>    (This must be supported as default by all ELF V2 ABI-compliant
>    environments.)
> [...]
>  – The function shall save the link register that contains its return
>    address in the LR save doubleword of its caller’s stack frame before
>    calling another function.
> 
> To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> This patch may be unneccessarily limited to ppc64le, but OTOH the only
> user of this flag so far is livepatching, which is only implemented on
> PPCs with 64-LE, a.k.a. ELF ABI v2.
> 
> Feel free to add other ppc variants, but so far only ppc64le got tested.
> 
> This change also implements save_stack_trace_tsk_reliable() for ppc64le
> that checks for the above conditions, where possible.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/df78d3f6148092d33a9a24c7a9cfac

cheers
