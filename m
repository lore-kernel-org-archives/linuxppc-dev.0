Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C7321A119C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 21:19:12 +1100 (AEDT)
In-Reply-To: <1450263209-11217-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, tuliom@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, murphyp@linux.vnet.ibm.com,
 schwab@linux-m68k.org, sam.bobroff@au1.ibm.com
Subject: Re: Partial revert of "powerpc: Individual System V IPC system calls"
Message-Id: <20151217101912.1BF371402C9@ozlabs.org>
Date: Thu, 17 Dec 2015 21:19:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-16-12 at 10:53:29 UTC, Michael Ellerman wrote:
> This partially reverts commit a34236155afb1cc41945e58388ac988431bcb0b8.
> 
> While reviewing the glibc patch to exploit the individual IPC calls,
> Arnd & Andreas noticed that we were still requiring userspace to pass
> IPC_64 in order to get the new style IPC API.
> 
> With a bit of cleanup in the kernel we can drop that requirement, and
> instead only provide the new style API, which will simplify things for
> userspace.
> 
> Rather than try and sneak that patch into 4.4, instead we will drop the
> individual IPC calls for powerpc, and merge them again in 4.5 once the
> cleanup patch has gone in.
> 
> Because we've already added sys_mlock2() as syscall #378, we don't do a
> full revert of the IPC calls. Instead we drop the __NR #defines, and
> send those now undefined syscall numbers to sys_ni_syscall(). This
> leaves a gap in the syscall numbers, but we'll reuse them when we merge
> the individual IPC calls.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/2475c362134a0fa5309c7b0f

cheers
