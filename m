Subject: Re: Final question: best wasy to move /, /usr, /home, etc?
From: Bastien Nocera <hadess@hadess.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	yellowdog-devel@lists.yellowdoglinux.com,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20020218161603.GB25078@opus.bloom.county>
References: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
	<p05101401b895b9cbee49@[10.0.0.42]>
	<20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
	<20020218021717.EDHQ21433.tomts12-srv.bellnexxia.net@there>
	<1013999761.436.2.camel@dozo>  <20020218161603.GB25078@opus.bloom.county>
Date: 18 Feb 2002 16:20:18 +0000
Message-Id: <1014049219.24786.12.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-02-18 at 16:16, Tom Rini wrote:
> On Mon, Feb 18, 2002 at 02:36:01AM +0000, Bastien Nocera wrote:
> >
> > On Mon, 2002-02-18 at 02:17, Kevin B. Hendricks wrote:
> > >
> > > I am finally at the point I want to give up my old external scsi hard
> > > drives.  Unfrotunately, my current /, /usr, /home, etc all exist on scsi
> > > drives.
> > >
> > > I recently purchased a 60 gig hard drive (ide) and have now installed it.
> > >
> > > What is the best way to move all of the files and directories, and special
> > > device files, and etc from the scsi drive to new partitions on the IDE
> > > drives?
> > >
> > > Can I simply use a recursive "cp" with -a?  Should I use "tar"?  What
> > > about "parted" and its partition copies?
> > >
> > > Or is there some way I can run an linux distribution installer from within
> > > linux and make it install to the ide drive instead of the scsi?
> > >
> > > Or is there some way to make "rpm" nicely redirect where it installs
> > > things?
> > >
> > >
> > > In fact, with som much space, I would love to have Debian, SuSE, and
> > > YellowDog distribution sets so I can run and test OpenOffice.org against
> > > those distributions easily (shared build drives) with different
> > > distribution installations.
> > >
> > > This is my last step to get a working system so any hints on the best way
> > > to move so much data (and special device files) from one partition to
> > > another preserving the owner,group,word, permissions, file ownership,
> > > setuid root bits, etc. would be greatly appreciated.
> >
> > I've done this several times, to install xfs support on live machines
> > (ie. on my desktop and laptop that were already full of crap junk and
> > other kind of files).
> >
> > rsync -av --exclude /proc --exclude /home/ / /newroot/
> >
> > Exclude every mount point from the rsync and do this for every
> > partition. Best is to do this from a separate root, or a rescue/boot
> > disk, in which case rsync -av /oldroot/ /newroot/ is easy enough without
> > having to care.
> >
>
> I _think:
> rsync -av -x / /newroot/
> will get just the / partition (-x means one fs, cp and a few others take
> this arg).

the man page has it indeed. The good thing is that you can run it
multiple times, or stop it in the middle and restart where you left off,
which you can't with the other solutions.

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
