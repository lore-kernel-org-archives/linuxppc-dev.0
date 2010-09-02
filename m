Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
In-reply-to: <1283400367.2356.69.camel@gandalf.stny.rr.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
	<4C7E6CCC.8090700@us.ibm.com> <4C7E9FC1.60004@us.ibm.com>
	<1283371161.2356.53.camel@gandalf.stny.rr.com>
	<4C7EBAA8.7030601@us.ibm.com> <11579.1283389322@neuling.org>
	<1283400367.2356.69.camel@gandalf.stny.rr.com>
Date: Fri, 03 Sep 2010 09:04:53 +1000
Message-ID: <30721.1283468693@neuling.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Darren Hart <dvhltc@us.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Ankita Garg <ankita@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <1283400367.2356.69.camel@gandalf.stny.rr.com> you wrote:
> On Thu, 2010-09-02 at 11:02 +1000, Michael Neuling wrote:
> 
> > We need to call smp_startup_cpu on boot when we the cpus are still in
> > FW.  smp_startup_cpu does this for us on boot.
> > 
> > I'm wondering if we just need to move the test down a bit to make sure
> > the preempt_count is set.  I've not been following this thread, but
> > maybe this might work?
> 
> Egad no! Setting the preempt_count to zero _is_ the bug. I think Darren
> even said that adding the exit prevented the bug (although now he's
> hitting a hard lockup someplace else). The original code he was using
> did not have the condition to return for kexec. It was just a
> coincidence that this code helped in bringing a CPU back online.
> 
> > 
> > Untested patch below...
> > 
> > Mikey
> > 
> > diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/
pseries/smp.c
> > index 0317cce..3afaba4 100644
> > --- a/arch/powerpc/platforms/pseries/smp.c
> > +++ b/arch/powerpc/platforms/pseries/smp.c
> > @@ -104,18 +104,18 @@ static inline int __devinit smp_startup_cpu(unsigned 
int lcpu)
> >  
> >  	pcpu = get_hard_smp_processor_id(lcpu);
> >  
> > -	/* Check to see if the CPU out of FW already for kexec */
> > -	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
> > -		cpumask_set_cpu(lcpu, of_spin_mask);
> > -		return 1;
> > -	}
> > -
> >  	/* Fixup atomic count: it exited inside IRQ handler. */
> >  	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
> 
> We DON'T want to do the above. It's nasty! This is one CPU's task
> touching an intimate part of another CPU's task. It's equivalent of me
> putting my hand down you wife's blouse. It's offensive, and rude.
> 
> OK, if the CPU was never online, then you can do what you want. But what
> we see is that this fails on CPU hotplug.  You stop a CPU, and it goes
> into this cede_processor() call. When you wake it up, suddenly the task
> on that woken CPU has its preempt count fscked up.  This was really
> really hard to debug. We thought it was stack corruption or something.
> But it ended up being that this code has one CPU touching the breasts of
> another CPU. This code is a pervert!
> 
> What the trace clearly showed, was that we take down a CPU, and in doing
> so, the code on that CPU set the preempt count to 1, and it expected to
> have it as 1 when it returned. But the code that kicked started this CPU
> back to life (bring the CPU back online), set the preempt count on the
> task of that CPU to 0, and screwed everything up.

/me goes to checks where this came from...

It's been in the kernel since hotplug CPU support was added to ppc64
back in 2004, so I guess we are all at fault for letting this pervert
get away with this stuff for so long in plain sight. :-)

So I guess we should remove this but we need to audit all the different
paths that go through here to make sure they are OK with preempt.
Normal boot, kexec boot, hotplug with FW stop and hotplug with
extended_cede all hit this.

Mikey
