Date: Tue, 27 Jan 2004 00:50:27 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Root Drive Mirroring and LVM.
Message-ID: <20040127095027.GJ5676@plato.local.lan>
References: <868055F9-5045-11D8-8066-00039382032A@mindspring.com> <200401270801.i0R81HdT022197@kruuna.Helsinki.FI> <20040127093213.GA10049@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040127093213.GA10049@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 27, 2004 at 10:32:13AM +0100, Sven Luther wrote:
>
> On Tue, Jan 27, 2004 at 10:01:17AM +0200, Atro Tossavainen wrote:
> >
> > Sorry about the crossposting.
> >
> > I wrote on the Yellow Dog Linux list when somebody asked about software
> > RAID on YDL about my experiences with it:
> >
> > >> The one really big gotcha is that the Macintosh partitioning scheme
> > >> can't tell the Linux kernel that certain partitions are to be
> > >> considered "Linux RAID autodetect" (as in x86 using the DOS partition
> > >> table type 0xfd). This means that you can't boot a Mac Linux system
> > >> directly from RAID because the kernel won't be able to autostart the
> > >> RAID devices. You have to work around this by creating an initial RAM
> > >> disk that uses the raidstart command to start your metadevices, then
> > >> swaps the initrd out of the way and proceeds to start the real system.
> >
> > to which Tim Seufert replied on the same list:
> >
> > > Hmmm.  That would seem to be a lack in the Linux RAID code, since the
> > > Macintosh partition table has a vastly more flexible partition type
> > > field than DOS: instead of a single byte it's a string.  It would mean
> > > breaking from the convention of using the "Apple_SVR2_UNIX" type for
> > > Linux partitions, but that really is just a convention as far as I know.
> >
> > Perhaps the PPC Linux developers and the Linux RAID developers should
> > get together on this and make some decisions so as to make it happen.
>
> Seems ok for me. Also, i guess that there are other partition types,
> like the amiga partitition table the pegasos boxes mostly use, which has
> a 32bit identifier for partition types. I guess it is the task of the
> RAID code to have some per partition type checking for this RAID autodetect
> magic.

in general we need to stop using Apple_* types for our partitions,
apple clearly documents that the entire Apple_* namespace is reserved
solely for Apple use, and 3rd party developers must use something,
anything else for thier partitions.

the trick is coming up with a generic enough and sensible enough
naming convention.  (i think its quite silly to include specific
filesystem names in partition types, and really it seems silly to
specify "Linux" for filesystems which can and are used by OSes other
then "Linux" (ext2 is used in Hurd for example)).

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
