Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9F8E1A0320
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:15:24 +1100 (AEDT)
Message-ID: <1448273724.3452.10.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add rN aliases to the pt_regs_offset table.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Rashmica Gupta
 <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 Nov 2015 21:15:24 +1100
In-Reply-To: <5652CD42.5010008@linux.vnet.ibm.com>
References: <1448086096-3117-1-git-send-email-rashmicy@gmail.com>
 <5652CD42.5010008@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 13:54 +0530, Anshuman Khandual wrote:

> On 11/21/2015 11:38 AM, Rashmica Gupta wrote:

> > It is common practice with powerpc to use 'rN' to refer to register 'N'. However
> > when using the pt_regs_offset table we have to use 'gprN'.
> > 
> > So add aliases such that both 'rN' and 'gprN' can be used.
> > 
> > For example, we can currently do:
> > $ su -
> > $ echo "p:probe/sys_fchownat .sys_fchownat %gpr3:s32 +0(%gpr4):string %gpr5:s32
> > %gpr6:s32 %gpr7:s32" > /sys/kernel/debug/tracing/kprobe_events
> > $ echo 1 > /sys/kernel/debug/tracing/events/probe/sys_fchownat/enable
> > $ touch /tmp/foo
> > $ chown root /tmp/foo
> > $ echo 0 > /sys/kernel/debug/tracing/events/enable
> > $ cat /sys/kernel/debug/tracing/trace
> >            chown-5040  [001] d... 24800.047211: sys_fchownat:
> > (.SyS_fchownat+0x0/0x190) arg1=-100 arg2="foo" arg3=0 arg4=-1 arg5=0
> > 
> > Instead we'd like to be able to use:
> > $ echo "p:probe/sys_fchownat sys_fchownat %r3:s32 +0(%r4):string %r5:s32
> > %r6:s32 %r7:s32" > /sys/kernel/debug/tracing/kprobe_events
> 
> This makes sense and works for me on a LE guest. Just that the symbol
> should not have the "." before it. 

Yeah that's probably my fault for giving Rashmica an example from a BE system.
I'll fix up the example before I commit it.

cheers
