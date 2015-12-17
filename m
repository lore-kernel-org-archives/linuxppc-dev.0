Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 354AB1A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:33 +1100 (AEDT)
In-Reply-To: <1450063884-19728-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, ivan@ru.ibm.com
Subject: Re: powerpc/476fpe: Add support for kexec
Message-Id: <20151217115733.19D9C1402ED@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-14-12 at 03:31:24 UTC, Alistair Popple wrote:
> PPC476FPE has a different PVR from previous PPC476 processors. The
> kexec code checks the PVR in order to correctly setup the MMU. When
> the initial support for 476FPE processors was added the corresponding
> change in the kexec code was missed. This patch simply adds the check
> and solves the following bug on kexec:
> 
> kexec: Starting new kernel
> Bye!
> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0xee9a50f8
> cpu 0x0: Vector: 400 (Instruction Access) at [ee9d7d20]
>     pc: ee9a50f8
>     lr: ee9a50e4
>     sp: ee9d7dd0
>     msr: 21020
>     current = 0xee40f000
>     pid   = 960, comm = kexec
> enter ? for help
> [link register   ] ee9a50e4
> [ee9d7dd0] c0013748 default_machine_kexec+0x58/0x70 (unreliable)
> [ee9d7df0] c0012f04 machine_kexec+0x34/0x40
> [ee9d7e00] c00aa1ec kernel_kexec+0x9c/0xb0
> [ee9d7e20] c005d704 SyS_reboot+0x1f4/0x220
> [ee9d7f40] c000db68 ret_from_syscall+0x0/0x3c
> --- Exception: c01 (System Call) at b77b69f4
> SP (bfc4a670) is in userspace
> 0:mon>
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Ivan Mikhaylov <ivan@ru.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4450022b4952ce67d2f3006b4c

cheers
