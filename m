Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3939F1A15ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:47:50 +1100 (AEDT)
In-Reply-To: <20151210204439.393ce017@kryten>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, cyrilbur@gmail.com, scottwood@freescale.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Rashmica <rashmicy@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc: Call restore_sprs() before _switch()
Message-Id: <20151214094750.1E3C5140323@ozlabs.org>
Date: Mon, 14 Dec 2015 20:47:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-12 at 09:44:39 UTC, Anton Blanchard wrote:
> commit 152d523e6307 ("powerpc: Create context switch helpers save_sprs()
> and restore_sprs()") moved the restore of SPRs after the call to _switch().
> 
> There is an issue with this approach - new tasks do not return through
> _switch(), they are set up by copy_thread() to directly return through
> ret_from_fork() or ret_from_kernel_thread(). This means restore_sprs() is
> not getting called for new tasks.
> 
> Fix this by moving restore_sprs() before _switch().
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Fixes: 152d523e6307 ("powerpc: Create context switch helpers save_sprs() and restore_sprs()")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/20dbe67062062c2a790832f0

cheers
