Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBg47BQzF1pZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:55 +1000 (AEST)
In-Reply-To: <20180404104116.27819-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/hw_breakpoint: Only disable hw breakpoint if cpu supports
 it
Message-Id: <40GTBg2P0sz9s31@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-04 at 10:41:16 UTC, "Naveen N. Rao" wrote:
> We get the below warning if we try to use kexec on P9:
>     kexec_core: Starting new kernel
>     WARNING: CPU: 0 PID: 1223 at arch/powerpc/kernel/process.c:826 __set_breakpoint+0xb4/0x140
>     [snip]
>     NIP [c00000000001bf44] __set_breakpoint+0xb4/0x140
>     LR [c000000000061268] kexec_prepare_cpus_wait+0x58/0x150
>     Call Trace:
>     [c0000000ee70fad0] [c0000000ee70fb20] 0xc0000000ee70fb20 (unreliable)
>     [c0000000ee70faf0] [c0000000ee70fb20] 0xc0000000ee70fb20
>     [c0000000ee70fbb0] [c000000000061884] default_machine_kexec+0x234/0x2c0
>     [c0000000ee70fc40] [c0000000000605c4] machine_kexec+0x84/0x90
>     [c0000000ee70fc70] [c000000000206548] kernel_kexec+0xd8/0xe0
>     [c0000000ee70fce0] [c000000000169e74] SyS_reboot+0x214/0x2c0
>     [c0000000ee70fe30] [c00000000000bd60] system_call+0x58/0x6c
> 
> This happens since we are trying to clear hw breakpoint on POWER9, though
> we don't have CPU_FTR_DAWR enabled. Guard __set_breakpoint() within
> hw_breakpoint_disable() with ppc_breakpoint_available() to address this.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5d6a03ebc88f82b0b0adcec24eabb9

cheers
