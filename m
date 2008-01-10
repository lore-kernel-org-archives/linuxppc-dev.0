Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 43675DE01B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 13:33:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so109876anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 18:33:53 -0800 (PST)
Message-ID: <3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
Date: Wed, 9 Jan 2008 20:33:53 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Nathan Lynch" <ntl@pobox.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080109184437.GU14201@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> Hi Linas,
>
> Linas Vepstas wrote:
> >
> > As a side effect, the system is in
> > production *while* the dump is being taken;
>
> A dubious feature IMO.

Hmm.  Take it up with Ken Rozendal, this is supposed to be
one of the two main selling points of this thing.

> Seems that the design potentially trades
> reliability of first failure data capture for availability.
> E.g. system crashes, reboots, resumes processing while copying dump,
> crashes again before dump procedure is complete.  How is that handled,
> if at all?

Its handled by the hypervisor.  phyp maintains the copy of the
RMO of  first crash, until such time that the OS declares the
dump of the RMO to be complete. So you'll always have
the RMO of the first crash.

For the rest of RAM, it will come in two parts: some portion
will have been dumped already. The rest has not yet been dumped,
and it will still be there, preserved across the second crash.

So you get both RMO and all of RAM from the first crash.

> > with kdump,
> > you can't go into production until after the dump is finished,
> > and the system has been rebooted a second time.  On
> > systems with terabytes of RAM, the time difference can be
> > hours.
>
> The difference in time it takes to resume the normal workload may be
> significant, yes.  But the time it takes to get a usable dump image
> would seem to be the basically the same.

Yes.

> Since you bring up large systems... a system with terabytes of RAM is
> practically guaranteed to be a NUMA configuration with dozens of cpus.
> When processing a dump on such a system, I wonder how well we fare:
> can we successfully boot with (say) 128 cpus and 256MB of usable
> memory?  Do we have to hot-online nodes as system memory is freed up
> (and does that even work)?  We need to be able to restore the system
> to its optimal topology when the dump is finished; if the best we can
> do is a degraded configuration, the workload will suffer and the
> system admin is likely to just reboot the machine again so the kernel
> will have the right NUMA topology.

Heh. That's the elbow-grease of this thing.  The easy part is to get
the core function working. The hard part is to test these various configs,
and when they don't work, figure out what went wrong. That will take
perseverence and brains.

--linas
