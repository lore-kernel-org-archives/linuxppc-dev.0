Date: Wed, 15 Sep 1999 22:42:04 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Sean <picasso@madflower.com>
cc: Tom Rini <trini@kernel.crashing.org>, Ethan Benson <erbenson@alaska.net>,
        Peter Bierman <bierman@apple.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
In-Reply-To: <37E06BB2.27916B03@madflower.com>
Message-ID: <Pine.LNX.3.96.990915223308.1458C-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Sep 1999, Sean wrote:

> *plays the devil's advocate*
> 
> "David A. Gatwood" wrote:
> > 
> > On Wed, 15 Sep 1999, Tom Rini wrote:
> > 
> > > > >So I'm not sure what you mean then by the "bootblock of the disk".
> > > >
> > > > on intel machines disks are typically use the very first 512 bytes on
> > > > a disk as a bootblock and partition table, the bootblock portion of
> > > > this is something like 446 bytes long, the BIOS when booting the
> > > > machine has a boot device specified all it does it load that 446
> > > > bytes into memory and execute it that code could be the NT loader the
> > > > old DOS/win95 loader or it could be LILO, that code then can do
> > > > whatever it need to do.  in lilos case it loads its second stage
> > > > loader from the root filesystem and that takes care of loading the
> > > > kernel, if you replace ext2fs with xfs all that needs updating is
> > > > possibly the second stage LILO.  no specific partition or filesystem
> > > > is needed and the BIOS does not care what filesystem you use.
> > >
> > > But a good loader knows how to deal w/ FSes.  The FreeBSD loader is
> > > wonderful, and can boot any kernel on the disk, unlike lilo.
> 
> How many times do you compile your Linux kernel under say windows or the
> macos so it would actually be on a different type of FS where this would
> actually be an issue? *ponders*

Build... never.  Download... frequently.


> > Any booter that doesn't understand filesystems and has to have a list of
> > blocks is a serious kludge.  For instance, who is to say that you want to
> > boot off a block device at all?  And what if I wanted to replace a kernel
> > from within another OS?  Can you say pain in the...
> 
> if you dont have a block device, and your not going to boot from it than
> why would you worry about whether you have a bootloader installed on a
> block device? 

True enough.


> weird i have installed on dozens of systems and lilo has worked
> flawlessy, although I have had problems with WD E-Z drive writing over
> the boot block stuff a few times(but only windows people are stupid
> enough to use it), and I have had to wrestle with some scsi drives, though.

Try making it share a large disk with FreeDOS, and you'll find one
problem.  Try using a large ramdisk and you'll find a second.  Those are
the ones that come to mind immediately.


> >Depending on
> > a particular block to be always unused is more than a kludge, it's
> > downright dangerous.  What if two architectures share a drive?  What if
> > they happen to pick the same critical boot block?  Baaaad idea.  At least
> > if it's a filesystem at a particular location, you can read it and say
> > "hey, that's not a valid fs" or "hey, that partition table is bogus".
> > With a boot block, there are no second chances.  You just crash.
> 
> Lilo, can handle at least 3 OS's.

I was referring more to setting up  a system in which a driveis shared
between different machine types, like PPC and x86, for example.  Probably
not a good example, and difficult to do in practice, at least with current
hardware.


> and it also gives errors as best it
> can when it crashes.

LI

;-)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
