Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGs1VG0zDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:57 +1000 (AEST)
In-Reply-To: <1500905415-32225-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/udbg: Reduce the footgun potential of
 EARLY_DEBUG_LPAR(_HVSI)
Message-Id: <3xQvGr4cKrz9sR9@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-24 at 14:10:15 UTC, Michael Ellerman wrote:
> For debugging very early boot problems we have CONFIG_PPC_EARLY_DEBUG,
> which allows configuring the kernel such that it unconditionally writes
> to a particular type of console, regardless of whether that console
> exists or not. This is useful sometimes when the kernel crashes before
> it can even determine what platform it's on, and therefore what consoles
> exist.
> 
> However if you boot a kernel built this way on a different platform, it
> will generally crash because it writes to a console that doesn't exist.
> 
> A particularly nasty instance of this is if you enable the hypervisor
> console early debug, and then boot that kernel on bare metal. The result
> is that the kernel calls "the hypervisor" very early in boot, but the
> kernel *is* the hypervisor, so we jump to the system call handler and
> start executing all sorts of code that isn't ready to be run. This may
> lead to a machine check or check stop depending on how lucky you are.
> 
> Luckily there is an easy way to avoid this particular case. We simply
> read the MSR before installing the hooks, and if we see MSR_HV is set
> then we are the hypervisor and we definitely should not use the
> hypervisor console.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/9227f0431435c9d664771b112c230e

cheers
