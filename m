Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-02.nyroc.rr.com (ms-smtp-02.nyroc.rr.com [24.24.2.56])
	by ozlabs.org (Postfix) with ESMTP id 79EB9679F9
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 08:12:49 +1000 (EST)
Date: Fri, 14 Apr 2006 18:12:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <20060414150625.3ba369d2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604141806480.18329@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<20060414150625.3ba369d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
	mj@atrey.karlin.mff.cuni.cz, spyro@f2s.com, joe@tensilica.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, mingo@elte.hu,
	grundler@parisc-linux.org, starvik@axis.com, torvalds@osdl.org,
	tglx@linutronix.de, rth@twiddle.net, chris@zankel.net,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, marc@tensilica.com, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 14 Apr 2006, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Example:
> >
> >  DEFINE_PER_CPU(int, myint);
> >
> >  would now create a variable called per_cpu_offset__myint in
> > the .data.percpu_offset section.
>
> Suppose two .c files each have
>
> 	DEFINE_STATIC_PER_CPU(myint)
>
> Do we end up with two per_cpu_offset__myint's in the same section?
>

Both variables are defined as static:

ie.
  #define DEFINE_STATIC_PER_CPU(type, name) \
    static __attribute__((__section__(".data.percpu_offset"))) unsigned long *per_cpu_offset__##name; \
    static __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name

So the per_cpu_offset__myint is also static, and gcc should treat it
properly.  Although, yes there are probably going to be two variables
named per_cpu_offset__myint in the same section, but the scope of those
should only be visible by who sees the static.

Works like any other variable that's static, and even the current way
DEFINE_PER_CPU works with statics.

Thanks,

-- Steve
