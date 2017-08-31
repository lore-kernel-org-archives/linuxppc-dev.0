Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgL96dzrzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:01 +1000 (AEST)
In-Reply-To: <20170614154400.17377-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, zsun@redhat.com,
 Gustavo Luiz Duarte <gduarte@redhat.com>
Subject: Re: powerpc/uprobes: Implement arch_uretprobe_is_alive()
Message-Id: <3xjgL939vXz9t1t@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 15:44:00 UTC, "Naveen N. Rao" wrote:
> This helper is used to detect if a uprobe'd function has returned
> through a setjmp/longjmp, rather than branching to the LR that was
> updated previously by us. This fixes a SIGSEGV that gets generated when
> programs use setjmp/longjmp with uretprobes.
> 
> We use the arm64 model (arch/arm64/kernel/probes/uprobes.c:
> arch_uretprobe_is_alive()) for detecting when stack frames have been
> removed from under us.
> 
> Reference:
> https://marc.info/?l=linux-kernel&m=143748610330073
> commit 7b868e4802a86 ("uprobes/x86: Reimplement arch_uretprobe_is_alive()")
> commit db087ef69a2b1 ("uprobes/x86: Make arch_uretprobe_is_alive(RP_CHECK_CALL) more
> clever")
> 
> Tested with the test program from:
> https://sourceware.org/git/gitweb.cgi?p=systemtap.git;a=blob;f=testsuite/systemtap.base/bz5274.c;hb=HEAD
> 
> And this script:
>     $ cat test.sh
>     #!/bin/bash
> 
>     perf probe -x ./bz5274 -a bz5274_main_return=main%return
>     perf probe -x ./bz5274 -a bz5274_funca_return=funca%return
>     perf probe -x ./bz5274 -a bz5274_funcb_return=funcb%return
>     perf probe -x ./bz5274 -a bz5274_funcc_return=funcc%return
>     perf probe -x ./bz5274 -a bz5274_funcd_return=funcd%return
> 
>     perf record -e 'probe_bz5274:*' -aR ./bz5274
> 
> Reported-by: Gustavo Luiz Duarte <gduarte@redhat.com>
> Reported-by: zsun@redhat.com
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2dea1d9c38e481051fa0e62807e518

cheers
