Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 4A321DE08A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:45:03 +1100 (EST)
Date: Wed, 9 Jan 2008 12:44:37 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
Message-ID: <20080109184437.GU14201@localdomain>
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linas,

Linas Vepstas wrote:
> 
> On 08/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> > Manish Ahuja wrote:
> > > +
> > > +The goal of hypervisor-assisted dump is to enable the dump of
> > > +a crashed system, and to do so from a fully-reset system, and
> > > +to minimize the total elapsed time until the system is back
> > > +in production use.
> >
> > Is it actually faster than kdump?
> 
> This is a basic presumption;

I used the word "actually".  I already know that it is intended to be
faster.  :)


> it should blow it away, as, after all,
> it requires one less reboot!

There's more than rebooting going on during system dump processing.
Depending on the system type, booting may not be where most time is
spent.


> As a side effect, the system is in
> production *while* the dump is being taken;

A dubious feature IMO.  Seems that the design potentially trades
reliability of first failure data capture for availability.
E.g. system crashes, reboots, resumes processing while copying dump,
crashes again before dump procedure is complete.  How is that handled,
if at all?


> with kdump,
> you can't go into production until after the dump is finished,
> and the system has been rebooted a second time.  On
> systems with terabytes of RAM, the time difference can be
> hours.

The difference in time it takes to resume the normal workload may be
significant, yes.  But the time it takes to get a usable dump image
would seem to be the basically the same.

Since you bring up large systems... a system with terabytes of RAM is
practically guaranteed to be a NUMA configuration with dozens of cpus.
When processing a dump on such a system, I wonder how well we fare:
can we successfully boot with (say) 128 cpus and 256MB of usable
memory?  Do we have to hot-online nodes as system memory is freed up
(and does that even work)?  We need to be able to restore the system
to its optimal topology when the dump is finished; if the best we can
do is a degraded configuration, the workload will suffer and the
system admin is likely to just reboot the machine again so the kernel
will have the right NUMA topology.


> > > +Implementation details:
> > > +----------------------
> > > +In order for this scheme to work, memory needs to be reserved
> > > +quite early in the boot cycle. However, access to the device
> > > +tree this early in the boot cycle is difficult, and device-tree
> > > +access is needed to determine if there is a crash data waiting.
> >
> > I don't think this bit about early device tree access is correct.  By
> > the time your code is reserving memory (from early_init_devtree(), I
> > think), RTAS has been instantiated and you are able to test for the
> > existence of /rtas/ibm,dump-kernel.
> 
> If I remember right, it was still too early to look up this token directly,
> so we wrote some code to crawl the flat device tree to find it.  But
> not only was that a lot of work, but I somehow decided that doing this
> to the flat tree was wrong, as otherwise someone would surely have
> written the access code.  If this can be made to work, that would be
> great, but we couldn't make it work at the time.
> 
> > > +To work around this problem, all but 256MB of RAM is reserved
> > > +during early boot. A short while later in boot, a check is made
> > > +to determine if there is dump data waiting. If there isn't,
> > > +then the reserved memory is released to general kernel use.
> >
> > So I think these gymnastics are unneeded -- unless I'm
> > misunderstanding something, you should be able to determine very early
> > whether to reserve that memory.
> 
> Only if you can get at rtas, but you can't get at rtas at that point.

Sorry, but I think you are mistaken (see Michael's earlier reply).
