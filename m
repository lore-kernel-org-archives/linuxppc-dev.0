Date: Sat, 03 Apr 2004 19:59:26 -0500
From: ERIC NORTHUP <eric.northup@jhu.edu>
Subject: Re: 4way smp on ppc32
To: Mark Guertin <mguertin@macdiscussion.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Message-id: <a85093a81050.a81050a85093@jhumail.jhu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, March 31, 2004 12:56 pm, Mark Guertin wrote:
> I'll try and find some time to test this stuff on my daystar quad
> as
> well.  I know that right up to latest 2.4.x all 4 of my CPU's are
> still
> working fine.

OK, I have just gotten a 2.4 smp kernel booted, and it does find all 4 cpus.  However, the machine is far from stable.  GCC dies on a fatal signal or reports an "internal compiler error", but when re-inovked on the same file it works.  Other times, it takes the ssh connection down with it.  I was trying to build LTP or some other code to narrow down the problem areas, but gcc is too flaky for this to work.

> On 31-Mar-04, at 3:17 AM, Benjamin Herrenschmidt wrote:
>
> >
> > Actually, there is at least one problem, can you try this patch:
> >
> > ===== arch/ppc/platforms/pmac_smp.c 1.30 vs edited =====
> > --- 1.30/arch/ppc/platforms/pmac_smp.c	Tue Mar 23 12:46:59 2004
> > +++ edited/arch/ppc/platforms/pmac_smp.c	Wed Mar 31 18:16:54 2004
> > @@ -316,6 +316,8 @@
> >
> >  	psurge_type = psurge_quad_probe();
> >  	if (psurge_type != PSURGE_DUAL) {
> > +        	psurge_smp_ops.take_timebase = smp_generic_take_timebase;
> > +        	psurge_smp_ops.give_timebase = smp_generic_give_timebase;
> >          	psurge_quad_init();
> >          	/* All released cards using this HW design have 4 CPUs */
> >          	ncpus = 4;

I applied this patch with the addition of a forward declaration

struct smp_ops_t psurge_smp_ops;

The system did not boot (it crashed earler than without the patchbut i did not get an oops on the serial console)

--Eric


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
