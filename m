Date: Tue, 19 Mar 2002 00:21:24 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bi_rec interface (was Re: [Ppcboot-users] Re: EV-64260 booting)
Message-ID: <20020319002124.C26309@plato.local.lan>
References: <20020318143326.B26309@plato.local.lan> <20020319002454.80D42109F1@denx.denx.de>
Mime-Version: 1.0
In-Reply-To: <20020319002454.80D42109F1@denx.denx.de>; from wd@denx.de on Tue, Mar 19, 2002 at 01:24:49AM +0100
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 19, 2002 at 01:24:49AM +0100, Wolfgang Denk wrote:
>
> In message <20020318143326.B26309@plato.local.lan> you wrote:
> >
> > > What happened to the idea (paulus' idea?) of creating some wrapper
> > > code (eg, zimage) that would build the bootinfo and pass it into
> > > the kernel, so yaboot doesn't need to do much other than pass in
> > > boot params?  This would force us to only boot zimages though
> > > (or whatever wrapper code we create).
> >
> > from a logistical point of view this really seems to be the best
> > approach.  keeping all the details in a kernel wrapper of sorts gives
>
> >From the point of view of someone who is working mostly with embedded
> systems this is definitely the WORST approach (YMMV).

fine, see the last part of my message.

> > the kernel maintainers much more freedom to make changes in the
> > future, whereas if its kept in yaboot (rather $bootloader) you have to
>
> The interfaces, once defined, should remain unchanged.

yeah perfect world and all...

> > deal with backword compatibility and endless luser error due to using
> > the wrong bootloader versions with wrong kernels.
>
> There is no need to create such problems in the first place, so don;t
> do it then.

well linux has a piss poor history of following that guidline, every
major kernel version has required several userspace utility
replacments (modutils, firewalling utils etc).

> > of course if someone doesn't want to use the wrapper they can just use
> > the vmlinux and write thier own bootloader to handle all this stuff
> > and take on the effort of ensuring its up to date with what the kernel
> > wants.
>
> What makes you think that kernel interfaces are  somthing  to  change
> that  often?  From  the  current  discussion  about bi_recs I got the
> impression that we have some kind of  agreement  (in  pronciple,  not
> [yet]  in  detail), but what you propose sounds like a full roll-back
> to position zero???

i don't know why you are getting so pissy, all i suggested was the
zImage wrapper handle all the gory details of this bi_rec crap rather
then $bootloader, if you don't want the wrapper then use the plain
flat vmlinux and write your own bootloader to handle the gory
details.  it sounds like you don't want to use the zImage wrapper no
matter what, so why the hell do you care what it does or does
not do?

either way hopefully the interfaces will not change, but excuse me for
not having much confidence in that being the case.

in the end i really don't much care how it ends up being done, however
i am not willing to add all sorts of kludge config options to yaboot
that you have to use to tell it what flavor kernel your booting,
users will NEVER get that right.  so if yaboot has to be responsible
for the gory details damn well get the interfaces done right the first
time and consider them engraved on stone tablets never to be altered
again.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
