Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3261D1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:57 +1100 (AEDT)
In-Reply-To: <1448086096-3117-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Add rN aliases to the pt_regs_offset table.
Message-Id: <20151126121556.D348D14031C@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-21-11 at 06:08:16 UTC, Rashmica Gupta wrote:
> It is common practice with powerpc to use 'rN' to refer to register 'N'. However
> when using the pt_regs_offset table we have to use 'gprN'.
> 
> So add aliases such that both 'rN' and 'gprN' can be used.
> 
> For example, we can currently do:
> $ su -
> $ echo "p:probe/sys_fchownat .sys_fchownat %gpr3:s32 +0(%gpr4):string %gpr5:s32
> %gpr6:s32 %gpr7:s32" > /sys/kernel/debug/tracing/kprobe_events
> $ echo 1 > /sys/kernel/debug/tracing/events/probe/sys_fchownat/enable
> $ touch /tmp/foo
> $ chown root /tmp/foo
> $ echo 0 > /sys/kernel/debug/tracing/events/enable
> $ cat /sys/kernel/debug/tracing/trace
>            chown-5040  [001] d... 24800.047211: sys_fchownat:
> (.SyS_fchownat+0x0/0x190) arg1=-100 arg2="foo" arg3=0 arg4=-1 arg5=0
> 
> Instead we'd like to be able to use:
> $ echo "p:probe/sys_fchownat sys_fchownat %r3:s32 +0(%r4):string %r5:s32
> %r6:s32 %r7:s32" > /sys/kernel/debug/tracing/kprobe_events
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/343c3327c12b136551929830

cheers
