Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 09328B7D29
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 19:18:58 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH RT] ehea: make receive irq handler non-threaded
	(IRQF_NODELAY)
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1274318916.22892.35.camel@concordia>
References: <4BF30793.5070300@us.ibm.com> <4BF30C32.1020403@linux.vnet.ibm.com>
	<4BF31322.5090206@us.ibm.com> <1274232324.29980.9.camel@concordia>
	<4BF3F2DB.7030701@us.ibm.com> <1274318916.22892.35.camel@concordia>
Date: Fri, 21 May 2010 04:02:20 -0500
Message-ID: <1274432540_6937@mail4.comsite.net>
Cc: Darren Hart <dvhltc@us.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	dvhltc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>, niv@linux.vnet.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>, Doug Maxey <doug.maxey@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu May 20 at 11:28:36 EST in 2010, Michael Ellerman wrote:
> On Wed, 2010-05-19 at 07:16 -0700, Darren Hart wrote:
> > On 05/18/2010 06:25 PM, Michael Ellerman wrote:
> > > On Tue, 2010-05-18 at 15:22 -0700, Darren Hart wrote:
> > > > On 05/18/2010 02:52 PM, Brian King wrote:
> > > > > Is IRQF_NODELAY something specific to the RT kernel?
> > > > > I don't see it in mainline...
> > > > Yes, it basically says "don't make this handler threaded".
> > >
> > > That is a good fix for EHEA, but the threaded handling is still broken
> > > for anything else that is edge triggered isn't it?
> > 
> > No, I don't believe so. Edge triggered interrupts that are reported as 
> > edge triggered interrupts will use the edge handler (which was the 
> > approach Sebastien took to make this work back in 2008). Since XICS 
> > presents all interrupts as Level Triggered, they use the fasteoi path.
> 
> But that's the point, no interrupts on XICS are reported as edge, even
> if they are actually edge somewhere deep in the hardware. I don't think
> we have any reliable way to determine what is what.
> 

The platform doesn't tell us this information.  The driver might know
but we don't need this information.

> > > The result of the discussion about two years ago on this was that we
> > > needed a custom flow handler for XICS on RT.
> > 
> > I'm still not clear on why the ultimate solution wasn't to have XICS 
> > report edge triggered as edge triggered. Probably some complexity of the 
> > entire power stack that I am ignorant of.
> 
> I'm not really sure either, but I think it's a case of a leaky
> abstraction on the part of the hypervisor. Edge interrupts behave as
> level as long as you handle the irq before EOI, but if you mask they
> don't. But Milton's the expert on that.
> 

More like the hardware actually converts them.  They are all handled
with the same presentation.

The XICS interrupt system is highly scalable and distributed in
implementation, with multiple priority delivery and unlimited nesting.

First, a few features and description:

The hardware has two bits of storage for every LSI interrupt source in the
system to say that interrupt is idle, pending, or was rejected and will
be retried later.  The hardware also stores a destination and delivery
priority, settable by software.  The destination can be a specific cpu
thread, or a global distribution queue of all (online) threads (in the
partition).  While the hardware used to have 256 priority levels available
(255 usable, one for cpu not interrupted), some bits have been stolen
and today we only guarantee 16 levels are avalabile to the OS (15 for
delivery and one for source disabled / cpu not processing any interrupt).
[The current linux kernel delivers all device interrupts at one level
but IPIs at a higher level.  To avoid overflowing the irq stack we don't
allow device interrupts while processing any external interrupt.]

The interrupt presentation layer likewise scales, with a seperate instance
for each cpu thread in the system.  A single IPI source per thread is
part of this instance; when a cpu wants to interrupt another it writes
the priority of the IPI to that cpus presentation logic.

When an interrupt is signaled, the hardware checks the state of that
interrupt, and if previously idle it sends an interrupt request with its
source number and priority towards the programmed destination, either a
specific cpu thread or the global queue of all processors in the system.
If that cpu is already handling an interrupt of the same or higher (lower
valued) priority either the incoming interrupt will be passed to the next
cpu (if the destnation was global) or it will be rejected and the isu will
update its state and try again later.  If the cpu had a prior interrupt
pending at a lower priority then the old interrupt will be rejected back
to its isu instead.

The normal behavior is a load to a presentation logic register causes
the interrupt source number and previous priority of the cpu to be
delivered to the cpu and the cpu priority to be raised to that of the
incoming interrupt.  The external interrupt indication to the cpu is
removed.  At this point the presentation hardware forgets all history
of this interrupt.  A store to the same register resets the priority of
the cpu (which would naturally be the level before it was interrupted
if it stores the value loaded) and sends an EOI (end of interrupt) to
the interrupt source specified in the write.  This resets the two bits
from pending to idle.

The software is allowed to reset the cpu priority to allow other
interrupts of equal (or even lower) priority to be presented independently
of creating the EOI for this source.  However, until software creates
an EOI for a specific source it will not be presented until the machine
is reset.  The only rule is you can't raise your priority (which might
have to reject a pending interrupt) when you send create (write) the EOI.

A cpu can also change its priority to tell the hardware to reject
this interrupt (possibly representing to another cpu) if it was really
working at a higher priority and it just didn't do the MMIO store to the
interrupt controller (which is slow compared to memory).  There is also
a polling register that you can see what interrupt would be presented,
but its racy as a new interrupt could come in, displace that one, and
the first one might be represented to another cpu.

To avoid overloading any single cpu, interrupts targeting the global
queue are distributed fairly.  Through POWER5 the hardware remembers
the cpu that accepted the previous interrupt and starts considering
the next oneline cpu.  Starting with POWER6, the presentation layer
was distributed to the processor chips (for natural scaling) and the
global queue replaced with a forwarding list.  The ISU is told (by the
hypervisor) to start its next presentation search with the next cpu in
the list when it accepts the interrupt from the presentation logic.

When MSI interrupts were added, logic was needed to handle reciving the
trigger store, presenting it, and representing the rejected interrupts
the edge when cpus were busy with prior or higher priority interrupts.
So the same state was created for each possible MSI, distributed to the
PCI host bridge logic or other io device like the HEA.  These state bits
per MSI convert the incoming store edge trigger into a replayable level,
which will be presented to cpus until one consumes it with the load.
If it gets rejected, it will try again.  But unlike an LSI which is still
present from the device, if it gets EOId it waits for a new trigger.
Actually, there is one additional bit in the ISU hardware for MSI sources
that keeps track that an MSI trigger was seen while it is in the pending
state because the path of the EOI from the interrupt presentation logic to
the ISU is not ordered with the MMIOs from the processor to the PCI bus.
However, if the interrupt is disabled, the hardware will not set this bit
or otherwise remember it was triggred.  The disable is done by setting
the priority to least favored (FF) as that level could never be higher
than any cpus.

In addition, the OS is not aware where or how the priority, destination,
and enable are are stored.  This is hidden via the Run Time Abstraction
Services (RTAS), which is a firmware supplied library for infrequent
calls and is called under a global lock.  The platform is not designed
for this to be fast, and the hypwervisor couldn't securely give access
to the registers even if the os knew where they were.  (The interrupt
presentation layer is accessed with a fast hypervisor call).

So, with this description, it should be clear that XICS threaded delivery
in the realtime kernel should use the hardware implicit masking per
source and never play games disabling the interrupt at the ISU, which
will be racy for edge sources and pure overhead for true level sources.

This was proposed here: http://lkml.org/lkml/2008/9/24/226 .

The threaded interrupt services in mainline assume the initial interrupt
handler will disable the interrupt at the device and therefore does not
call the irq mask and unmask functions.

> > > Apart from the issue of loosing interrupts there is also the fact that
> > > masking on the XICS requires an RTAS call which takes a global lock.
> > 
> > Right, one of may reasons why we felt this was the right fix. The other 
> > is that there is no real additional overhead in running this as 
> > non-threaded since the receive handler is so short (just napi_schedule()).
> 
> True. It's not a fix in general though. I'm worried that we're going to
> see the exact same bug for MSI(-X) interrupts.
> 
> cheers
> 
> 

and hca and ...

milton
