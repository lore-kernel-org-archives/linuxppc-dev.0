Date: Tue, 29 Jan 2002 15:03:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: hollis@austin.ibm.com, linuxppc-dev@lists.linuxppc.org,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: Re: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
Message-ID: <20020129220337.GG25973@opus.bloom.county>
References: <20020129165614.GV510@austin.ibm.com> <Pine.LNX.4.33.0201292138010.3937-100000@fridge.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0201292138010.3937-100000@fridge.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 29, 2002 at 09:47:02PM +0000, Leigh Brown wrote:

> On Tue, 29 Jan 2002 hollis@austin.ibm.com wrote:
>
> > On Tue, Jan 29, 2002 at 04:08:43PM +0000, Leigh Brown wrote:
> > >
> > > It works for me.  The comment needs to be changed to say it can't be a
> > > module.  I've attached the version I came up with, mainly because I went
> > > to some trouble to do it.  Differences:
> > >
> > > 2. Remove #ifdef __KERNEL__ from header file for use space utility
> >
> > This encourages user applications to include kernel header files, which has
> > been deemed ungood. I believe there should be many lengthy threads on the
> > subject in the lkml archives, but more practically speaking Paul has said he'd
> > be perfectly happy if all kernel headers were completely protected from user
> > space.
>
> Surely that can't be true.  What about asm/errno.h?  I thought you just
> put #ifdef __KERNEL__ around stuff you don't want to export to user space.
> In the case of asm/residual.h it all needs to be exported to user space.
> The alternative is to simply clone the file, which seems a bit silly.

There's a few legacy files which unfortunatly can't be clamped down on.
In general you are supposed to copy the file and be done with it.  In
fact, if I ever wanted to read the residual image from my PReP box
(usually off) on my x86 (which I'm typing on right now), I'd need to do
this anyways since x86 won't have '<asm/residual.h>'.

> > > 4. Only create entry if residual size > 0 'coz what you can't see won't
> > >    hurt you + eliminate chance of people wondering why they are getting an
> > >    error trying to read it.
> >
> > I don't like that, because it leaves you wondering if you compiled in residual
> > support at all... I'd much rather have it be 0 length.
>
> Okay.  I think the best behaviour is to simply return 0 bytes if there
> is no residual data and let lsresidual interpret that as being no
> residual data.

If we don't have any residual data, shouldn't we be returning a 0 byte
file anyhow?  I didn't explicitly test this, but in the original version
I got from Sven/Hollis, no residual data gave me an empty
/proc/residual.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
