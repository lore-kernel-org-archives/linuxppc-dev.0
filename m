Return-Path: <geert@linux-m68k.org>
Received: from monty.telenet-ops.be (monty.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id E75D4DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 23:39:23 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by monty.telenet-ops.be (Postfix) with SMTP id C9C0054020
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 13:39:21 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by monty.telenet-ops.be (Postfix) with ESMTP id B2EBF5404D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 13:39:21 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id mA4CdLjF011125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Nov 2008 13:39:21 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id mA4CdKFN011122
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Nov 2008 13:39:21 +0100
Date: Tue, 4 Nov 2008 13:39:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] kernel/cpu.c: Section mismatch warning fix. (fwd)
Message-ID: <Pine.LNX.4.64.0811041339010.8925@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---------- Forwarded message ----------
Date: Tue, 4 Nov 2008 12:02:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Rakib Mullick <rakib.mullick@gmail.com>, linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org
Subject: Re: [PATCH] kernel/cpu.c: Section mismatch warning fix.

On Tue, Nov 04, 2008 at 11:22:52AM +0100, Ingo Molnar wrote:
> 
> * Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Tue, Nov 04, 2008 at 10:48:31AM +0100, Ingo Molnar wrote:
> > > 
> > > * Andrew Morton <akpm@linux-foundation.org> wrote:
> > > 
> > > > On Thu, 30 Oct 2008 10:04:54 +0600
> > > > "Rakib Mullick" <rakib.mullick@gmail.com> wrote:
> > > > 
> > > > >  LD      kernel/built-in.o
> > > > > WARNING: kernel/built-in.o(.text+0xb7c8): Section mismatch in
> > > > > reference from the function notify_cpu_starting() to the variable
> > > > > .cpuinit.data:cpu_chain
> > > > > The function notify_cpu_starting() references
> > > > > the variable __cpuinitdata cpu_chain.
> > > > > This is often because notify_cpu_starting lacks a __cpuinitdata
> > > > > annotation or the annotation of cpu_chain is wrong.
> > > > > 
> > > > > This patch fixes the above section mismatch warning. If anything else
> > > > > please notice.
> > > > > Thanks.
> > > > > 
> > > > > Signed-off-by: Md.Rakib H. Mullick <rakib.mullick@gmail.com>
> > > > > 
> > > > > --- linux-2.6-orig/kernel/cpu.c	2008-10-28 20:52:38.000000000 +0600
> > > > > +++ linux-2.6/kernel/cpu.c	2008-10-28 22:46:22.000000000 +0600
> > > > > @@ -462,7 +462,7 @@ out:
> > > > >   * It must be called by the arch code on the new cpu, before the new cpu
> > > > >   * enables interrupts and before the "boot" cpu returns from __cpu_up().
> > > > >   */
> > > > > -void notify_cpu_starting(unsigned int cpu)
> > > > > +void __cpuinit notify_cpu_starting(unsigned int cpu)
> > > > >  {
> > > > >  	unsigned long val = CPU_STARTING;
> > > > 
> > > > arch/alpha/kernel/smp.c calls notify_cpu_starting() from __init code.
> > > > 
> > > > arch/cris/arch-v32/kernel/smp.c calls notify_cpu_starting() from __init code.
> > > > 
> > > > arch/x86/mach-voyager/voyager_smp.c calls notify_cpu_starting() from
> > > > __init code.
> > > > 
> > > > arch/m32r/kernel/smpboot.c calls notify_cpu_starting() from __init code.
> > > > 
> > > > arch/sparc/kernel/sun4d_smp.c calls notify_cpu_starting() from __init code.
> > > > 
> > > > arch/powerpc/kernel/smp.c calls notify_cpu_starting() from __devinit
> > > > code.
> > > > 
> > > > arch/um/kernel/smp.c calls notify_cpu_starting() from .text code.
> > > > 
> > > > 
> > > > The other nine callers call notify_cpu_starting() from __cpuinit code.
> > > > 
> > > > 
> > > > What a mess.
> > > 
> > > __cpuinit seems safe for all but UML.
> > > 
> > > But even for UML it appears to be de-facto safe: as after bootup we 
> > > never return back into arch/um/kernel/smp.c::idle_proc(). (as UML's 
> > >From the list Andrew provided powerpc needs to be looked after.
> > We cannot call an __init function from __devinit context.
> > If you already checked that then no objections.
> 
> the patch/context in question is attached below - in that we weaken 
> the persistency of notify_cpu_starting() from .text to __cpuinit. 
> Which should be safe, right?

The problem is powerpc where we have a __devinit function that
now calls a __cpuinit function.
And last I looked it was possible to tweak the configuration
so we had HOTPLUG enabled but HOTPLUG_CPU disabled in which
case we could end up in a situation where we call
notify_cpu_starting() from __devinit context but we have freed
the __cpuinit memory where notify_cpu_starting() was living.

>From a quick look the annotation in powerpc is wrong
but as it is used from assembler and I did not look carefully
I cannot say for sure.

So until the powerpc case is properly analysed we should hold
on this patch. If this patch is correct then we should also
get powerpc fixed.

	Sam
