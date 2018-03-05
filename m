Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw5wy19tHzF0kj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 04:09:21 +1100 (AEDT)
Date: Mon, 5 Mar 2018 11:09:01 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180305170901.GS21977@gate.crashing.org>
References: <20180305164928.GA17953@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180305164928.GA17953@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2018 at 05:49:28PM +0100, Torsten Duwe wrote:
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

All of this is also true for the other PowerPC ABIs, fwiw (both 32-bit
and 64-bit; the offset of the LR save slot isn't the same in all ABIs).


Segher
