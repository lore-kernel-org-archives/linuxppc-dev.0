From: hollis@austin.ibm.com
Date: Tue, 29 Jan 2002 10:56:14 -0600
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: Re: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
Message-ID: <20020129165614.GV510@austin.ibm.com>
References: <20020128160822.GH19960@opus.bloom.county> <Pine.LNX.4.33.0201291556160.3031-100000@fridge.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0201291556160.3031-100000@fridge.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 29, 2002 at 04:08:43PM +0000, Leigh Brown wrote:
>
> It works for me.  The comment needs to be changed to say it can't be a
> module.  I've attached the version I came up with, mainly because I went
> to some trouble to do it.  Differences:
>
> 2. Remove #ifdef __KERNEL__ from header file for use space utility

This encourages user applications to include kernel header files, which has
been deemed ungood. I believe there should be many lengthy threads on the
subject in the lkml archives, but more practically speaking Paul has said he'd
be perfectly happy if all kernel headers were completely protected from user
space.

> 4. Only create entry if residual size > 0 'coz what you can't see won't
>    hurt you + eliminate chance of people wondering why they are getting an
>    error trying to read it.

I don't like that, because it leaves you wondering if you compiled in residual
support at all... I'd much rather have it be 0 length.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
