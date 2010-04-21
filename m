Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
In-reply-to: <4BCF029B.1020805@linux.vnet.ibm.com>
References: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
	<12054.1271815478@neuling.org>
	<4BCE6DDC.4020902@linux.vnet.ibm.com>
	<1271856929.3832.46.camel@concordia>
	<4BCF029B.1020805@linux.vnet.ibm.com>
Date: Thu, 22 Apr 2010 07:03:36 +1000
Message-ID: <16434.1271883816@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4BCF029B.1020805@linux.vnet.ibm.com> you wrote:
> On 04/21/2010 08:35 AM, Michael Ellerman wrote:
> > On Tue, 2010-04-20 at 22:15 -0500, Brian King wrote:
> >> On 04/20/2010 09:04 PM, Michael Neuling wrote:
> >>> In message <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com> you wrote:
> >>>>
> >>>> Since there is nothing to stop an IPI from occurring to an
> >>>> offline CPU, rather than printing a warning to the logs,
> >>>> just ignore the IPI. This was seen while stress testing
> >>>> SMT enable/disable.
> >>>
> >>> This seems like a recipe for disaster.  Do we at least need a
> >>> WARN_ON_ONCE?
> >>
> >> Actually we are only seeing it once per offlining of a CPU,
> >> and only once in a while.
> >>  
> >> My guess is that once the CPU is marked offline fewer IPIs
> >> get sent to it since its no longer in the online mask.
> > 
> > Hmm, right. Once it's offline it shouldn't get _any_ IPIs, AFAICS.
> > 
> >> Perhaps we should be disabling IPIs to offline CPUs instead?
> > 
> > You mean not sending them? We do:
> > 
> > void smp_xics_message_pass(int target, int msg)
> > {
> >         unsigned int i;
> > 
> >         if (target < NR_CPUS) {
> >                 smp_xics_do_message(target, msg);
> >         } else {
> >                 for_each_online_cpu(i) {
> >                         if (target == MSG_ALL_BUT_SELF
> >                             && i == smp_processor_id())
> >                                 continue;
> >                         smp_xics_do_message(i, msg);
> >                 }
> >         }
> > }      
> > 
> > So it does sound like the IPI was sent while the cpu was online (ie.
> > before pseries_cpu_disable(), but xics_migrate_irqs_away() has not
> > caused the IPI to be cancelled.
> > 
> > Problem is I don't think we can just ignore the IPI. The IPI might have
> > been sent for a smp_call_function() which is waiting for the result, in
> > which case if we ignore it the caller will block for ever.
> > 
> > I don't see how to fix it :/
> 
> Any objections to just removing the warning?

Well someone could be waiting for the result, so it could be a real
problem.  

IMHO the warning should stay.

Mikey
