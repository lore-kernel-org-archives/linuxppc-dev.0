Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B9A31A0025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 13:14:45 +1000 (AEST)
Message-ID: <1429758884.4672.4.camel@ellerman.id.au>
Subject: Re: [PATCH RFC] powerpc/ftrace: add powerpc timebase as a trace
 clock source
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 13:14:44 +1000
In-Reply-To: <20150422051855.GE2327@naverao1-tp.ibm.com>
References: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150421092541.295dd72b@gandalf.local.home>
 <20150422051855.GE2327@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-22 at 10:48 +0530, Naveen N. Rao wrote:
> On 2015/04/21 09:25AM, Steven Rostedt wrote:
> > On Tue, 21 Apr 2015 16:33:36 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > Add a new powerpc-specific trace clock using the timebase register,
> > > similar to x86-tsc. This gives us a fast, monotonic, cross-cpu clock
> > > for trace entries and can be used to correlate events across cpus as
> > > well as across hypervisor and guest (assuming it is not a migrated guest
> > > with a non-zero tb_offset).
> > > 
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > > I have followed the approach used by x86-tsc here, but we could get rid of
> > > trace_clock.c if we directly use get_tb() with perhaps the notrace annotation.
> > > Would that be preferable?
> > > 
> > 
> > Probably. But all clocks used by tracing should be marked by notrace.
> > Don't just wrap it with a notrace. But looking at the code, it seems
> > that get_tb() is a static inline, which wont work as a pointer. Seems
> > you still need the indirect function call.
> > 
> > Note, all "inline" functions are notrace by default, so you do not need
> > to add any notrace annotation to an inlined function.
> 
> Steve,
> Thanks for the clarification - the current approach is better in that 
> case.
> 
> Paul, Mike,
> Can you please let me know your thoughts on this?

What is the value in adding a powerpc specific clock, which requires educating
people to use it, vs just using the global clock?

cheers
