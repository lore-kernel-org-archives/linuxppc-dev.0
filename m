Date: Tue, 29 Jan 2002 21:47:02 +0000 (GMT)
From: Leigh Brown <leigh@solinno.co.uk>
To: <hollis@austin.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: Re: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
In-Reply-To: <20020129165614.GV510@austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0201292138010.3937-100000@fridge.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis,

On Tue, 29 Jan 2002 hollis@austin.ibm.com wrote:

> On Tue, Jan 29, 2002 at 04:08:43PM +0000, Leigh Brown wrote:
> >
> > It works for me.  The comment needs to be changed to say it can't be a
> > module.  I've attached the version I came up with, mainly because I went
> > to some trouble to do it.  Differences:
> >
> > 2. Remove #ifdef __KERNEL__ from header file for use space utility
>
> This encourages user applications to include kernel header files, which has
> been deemed ungood. I believe there should be many lengthy threads on the
> subject in the lkml archives, but more practically speaking Paul has said he'd
> be perfectly happy if all kernel headers were completely protected from user
> space.

Surely that can't be true.  What about asm/errno.h?  I thought you just
put #ifdef __KERNEL__ around stuff you don't want to export to user space.
In the case of asm/residual.h it all needs to be exported to user space.
The alternative is to simply clone the file, which seems a bit silly.

> > 4. Only create entry if residual size > 0 'coz what you can't see won't
> >    hurt you + eliminate chance of people wondering why they are getting an
> >    error trying to read it.
>
> I don't like that, because it leaves you wondering if you compiled in residual
> support at all... I'd much rather have it be 0 length.

Okay.  I think the best behaviour is to simply return 0 bytes if there
is no residual data and let lsresidual interpret that as being no
residual data.

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
