Return-Path: <linasvepstas@gmail.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 4A4CEDE4EC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:31:49 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so207779agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:31:48 -0800 (PST)
Message-ID: <3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
Date: Wed, 9 Jan 2008 09:31:48 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Nathan Lynch" <ntl@pobox.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080109042911.GT14201@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
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

Hi Nathan,

Thank you for looking at this.

On 08/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> Manish Ahuja wrote:
> > +
> > +                   Hypervisor-Assisted Dump
> > +                   ------------------------
> > +                       November 2007
>
> Date is unneeded (and, uhm, dated :)

I'll argue very very strongly against this. One of the worst things
I deal with is undated documents. Google pulls up multiple
versions of a document, and you start wondering: "which one
of these is the *right one*?"  Its only after trying some suggested
sequence of commands that aren't working, and more time googling
and effort wasted, that you finallly realize that you are reading
the version 0.1 of documentation from 1999 that some idiot
did not have the decency to put a date on. (A version number
is acceptable).  Documentation is often in mediocre state,
don't compound the problem be leaving off critical info.

> > +The goal of hypervisor-assisted dump is to enable the dump of
> > +a crashed system, and to do so from a fully-reset system, and
> > +to minimize the total elapsed time until the system is back
> > +in production use.
>
> Is it actually faster than kdump?

This is a basic presumption; it should blow it away, as, after all,
it requires one less reboot!  As a side effect, the system is in
production *while* the dump is being taken; with kdump,
you can't go into production until after the dump is finished,
and the system has been rebooted a second time.  On
systems with terabytes of RAM, the time difference can be
hours.

> > +-- As the userspace tools complete saving a portion of
> > +   dump, they echo an offset and size to
> > +   /sys/kernel/release_region to release the reserved
> > +   memory back to general use.
> > +
> > +   An example of this is:
> > +     "echo 0x40000000 0x10000000 > /sys/kernel/release_region"
> > +   which will release 256MB at the 1GB boundary.
>
> This violates the "one file, one value" rule of sysfs, but nobody
> really takes that seriously, I guess.  In any case, consider
> documenting this in Documentation/ABI.

This interface will almost certainly be changed, in order to allow
phyp dump to work with the kdump user-space tools.  Its provisional
right now, until the details of user-space is hammered out.

> > +Please note that the hypervisor-assisted dump feature
> > +is only available on Power6-based systems with recent
> > +firmware versions.
>
> This statement will of course become dated/incorrect so I recommend
> removing it.

A provisional statement. I figure it should get taken out after
a few years.

> > +Implementation details:
> > +----------------------
> > +In order for this scheme to work, memory needs to be reserved
> > +quite early in the boot cycle. However, access to the device
> > +tree this early in the boot cycle is difficult, and device-tree
> > +access is needed to determine if there is a crash data waiting.
>
> I don't think this bit about early device tree access is correct.  By
> the time your code is reserving memory (from early_init_devtree(), I
> think), RTAS has been instantiated and you are able to test for the
> existence of /rtas/ibm,dump-kernel.

If I remember right, it was still too early to look up this token directly,
so we wrote some code to crawl the flat device tree to find it.  But
not only was that a lot of work, but I somehow decided that doing this
to the flat tree was wrong, as otherwise someone would surely have
written the access code.  If this can be made to work, that would be
great, but we couldn't make it work at the time.

> > +To work around this problem, all but 256MB of RAM is reserved
> > +during early boot. A short while later in boot, a check is made
> > +to determine if there is dump data waiting. If there isn't,
> > +then the reserved memory is released to general kernel use.
>
> So I think these gymnastics are unneeded -- unless I'm
> misunderstanding something, you should be able to determine very early
> whether to reserve that memory.

Only if you can get at rtas, but you can't get at rtas at that point.
I think we would have been the earliest users of rtas at that point.
Possibly the order of how things are initialized could be changed.

> > +Open issues/ToDo:
> > +------------
> > + o The various code paths that tell the hypervisor that a crash
> > +   occurred, vs. it simply being a normal reboot, should be
> > +   reviewed, and possibly clarified/fixed.
> > +
> > + o Instead of using /sys/kernel, should there be a /sys/dump
> > +   instead? There is a dump_subsys being created by the s390 code,
> > +   perhaps the pseries code should use a similar layout as well.
>
> Well, it seems to me that there's little reason to duplicate the s390
> layout unless we can actually share code.

I'm thinking "user-space tools".  This could probably be decided very
quickly after a short chat with the s390 architects about tools and
standardization and dump formats and the support process. In the
end, its some third-level support people who will be dissecting the
dump using god-knows-what tool (a hacked kdgb ???), so things
should get standardized as much as possible so that we don't
duplicate work.

> FWIW, I've been thinking about making a /sys/firmware/phyp hierarchy
> which could contain much of the System P-specific functions (DLPAR,
> lparcfg, other crud in /proc/ppc64)... seems suited to this
> platform-specific dump mechanism.

Works for me. I was always unclear what /sys/firmware was supposed
to contain.

--linas
