Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGND4nldzDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
In-Reply-To: <20171223164923.10587-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [2/2] powerpc/pseries,
 ps3: panic flush kernel messages before halting system
Message-Id: <3zVGNC6x0Hz9t3H@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-12-23 at 16:49:23 UTC, Nicholas Piggin wrote:
> Platforms with a panic handler that halts the system can have problems
> getting kernel messages out, because the panic notifiers are called
> before kernel/panic.c does its flushing of printk buffers an console
> etc.
> 
> This was attempted to be solved with commit a3b2cb30f252 ("powerpc: Do
> not call ppc_md.panic in fadump panic notifier"), but that wasn't the
> right approach and caused other problems, and was reverted by commit
> ab9dbf771ff9.
> 
> Instead, the powernv shutdown paths have already had a similar
> problem, fixed by taking the message flushing sequence from
> kernel/panic.c. That's a little bit ugly, but while we have the code
> duplicated, it will work for this case as well. So have ppc panic
> handlers do the same flushing before they terminate.
> 
> Without this patch, a qemu pseries_le_defconfig guest stops silently
> when issued the nmi command when xmon is off and no crash dumpers
> enabled. Afterwards, an oops is printed by each CPU as expected.
> 
> Fixes: ab9dbf771ff9 ("Revert "powerpc: Do not call ppc_md.panic in fadump panic notifier"")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35adacd6fc48d658419522f192a3c8

cheers
