Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkw0w3TzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:16 +1000 (AEST)
In-Reply-To: <1467354039-16832-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>,
 Jack Miller <jack@codezen.org>
Subject: Re: [v6] powerpc/timer - large decrementer support
Message-Id: <3rkQkv6rMwz9t1K@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-01-07 at 06:20:39 UTC, Oliver O'Halloran wrote:
> Power ISAv3 adds a large decrementer (LD) mode which increases the size
> of the decrementer register. The size of the enlarged decrementer
> register is between 32 and 64 bits with the exact size being dependent
> on the implementation. When in LD mode, reads are sign extended to 64
> bits and a decrementer exception is raised when the high bit is set (i.e
> the value goes below zero). Writes however are truncated to the physical
> register width so some care needs to be taken to ensure that the high
> bit is not set when reloading the decrementer. This patch adds support
> for using the LD inside the host kernel on processors that support it.
> 
> When LD mode is supported firmware will supply the ibm,dec-bits property
> for CPU nodes to allow the kernel to determine the maximum decrementer
> value. Enabling LD mode is a hypervisor privileged operation so the kernel
> can only enable it manually when running in hypervisor mode. Guests that
> support LD mode can request it using the "ibm,client-architecture-support"
> firmware call (not implemented in this patch) or some other platform
> specific method. If this property is not supplied then the traditional
> decrementer width of 32 bit is assumed and LD mode will not be enabled.
> 
> This patch was based on initial work by Jack Miller.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/799010244685334b34e674d354

cheers
