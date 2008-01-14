Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 81EC8DDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 16:13:56 +1100 (EST)
Date: Sun, 13 Jan 2008 23:24:02 -0600
From: Olof Johansson <olof@lixom.net>
To: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
Message-ID: <20080114052402.GA23786@lixom.net>
References: <3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
	<20080110162120.GA4831@lixom.net>
	<3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
	<4786923E.9090902@austin.ibm.com>
	<20080111012641.GX14201@localdomain>
	<3ae3aa420801110857l5e43fd56s5bd1c24ffac939f3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ae3aa420801110857l5e43fd56s5bd1c24ffac939f3@mail.gmail.com>
Cc: lkessler@us.ibm.com, linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	mahuja@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2008 at 10:57:51AM -0600, Linas Vepstas wrote:
> On 10/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> > Mike Strosaker wrote:
> > >
> > > At the risk of repeating what others have already said, the PHYP-assistance
> > > method provides some advantages that the kexec method cannot:
> > >  - Availability of the system for production use before the dump data is
> > > collected.  As was mentioned before, some production systems may choose not
> > > to operate with the limited memory initially available after the reboot,
> > > but it sure is nice to provide the option.
> >
> > I'm more concerned that this design encourages the user to resume a
> > workload *which is almost certainly known to result in a system crash*
> > before collection of crash data is complete.  Maybe the gamble will
> > pay off most of the time, but I wouldn't want to be working support
> > when it doesn't.
> 
> Workloads that cause crashes within hours of startup tend to be
> weeded-out/discovered during pre-production test of the system
> to be deployed. Since its pre-production test, dumps can be
> taken in a leisurely manner. Heck, even a session at the
> xmon prompt can be contemplated.
> 
> The problem is when the crash only reproduces after days or
> weeks of uptime, on a production machine.  Since the machine
> is in production, its got to be brought back up ASAP.  Since
> its crashing only after days/weeks, the dump should have
> plenty of time to complete.  (And if it crashes quickly after
> that reboot ... well, support people always welcome ways
> in which a bug can be reproduced more quickly/easily).

How do you expect to have it in full production if you don't have all
resources available for it? It's not until the dump has finished that you
can return all memory to the production environment and use it.

This can very easily be argued in both direction, with no clear winner:
If the crash is stress-induced (say a slashdotted website), for those
cases it seems more rational to take the time, collect _good data_ even
if it takes a little longer, and then go back into production. Especially
if the alternative is to go back into production immediately, collect
about half of the data, and then crash again. Rinse and repeat.

Anyway -- I can agree that some of the arguments w.r.t robustness and
reliability of collecting dumps can be higher using this approach. It
really surprises me that there's no way to reset a device through PHYP
though. Seems like such a fundamental feature.

I think people are overly optimistic if they think it'll be possible
to do all of this reliably (as in with consistent performance) without
a second reboot though. At least without similar amounts of work being
done as it would have taken to fix kdump's reliability in the first place.

Speaking of reboots. PHYP isn't known for being quick at rebooting a
partition, it used to take in the order of minutes even on a small
machine. Has that been fixed? If not, the avoiding an extra reboot
argument hardly seems like a benefit versus kdump+kexec, which reboots
nearly instantly and without involvement from PHYP.


-Olof
