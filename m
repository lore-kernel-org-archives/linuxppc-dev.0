Message-ID: <37E06BB2.27916B03@madflower.com>
Date: Thu, 16 Sep 1999 00:02:08 -0400
From: Sean <picasso@madflower.com>
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@mvista.com>
CC: Tom Rini <trini@kernel.crashing.org>, Ethan Benson <erbenson@alaska.net>,
        Peter Bierman <bierman@apple.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
References: <Pine.LNX.3.96.990915171236.32318R-100000@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


*plays the devil's advocate*

"David A. Gatwood" wrote:
> 
> On Wed, 15 Sep 1999, Tom Rini wrote:
> 
> > > >So I'm not sure what you mean then by the "bootblock of the disk".
> > >
> > > on intel machines disks are typically use the very first 512 bytes on
> > > a disk as a bootblock and partition table, the bootblock portion of
> > > this is something like 446 bytes long, the BIOS when booting the
> > > machine has a boot device specified all it does it load that 446
> > > bytes into memory and execute it that code could be the NT loader the
> > > old DOS/win95 loader or it could be LILO, that code then can do
> > > whatever it need to do.  in lilos case it loads its second stage
> > > loader from the root filesystem and that takes care of loading the
> > > kernel, if you replace ext2fs with xfs all that needs updating is
> > > possibly the second stage LILO.  no specific partition or filesystem
> > > is needed and the BIOS does not care what filesystem you use.
> >
> > But a good loader knows how to deal w/ FSes.  The FreeBSD loader is
> > wonderful, and can boot any kernel on the disk, unlike lilo.

How many times do you compile your Linux kernel under say windows or the
macos so it would actually be on a different type of FS where this would
actually be an issue? *ponders*

> Agreed.  In fact, I'd go so far as to say that lilo on PCs is a kludge.
> After all, it's a program that has to fit into a little 512 byte chunk of
> tightly coded assembly that has a number of bugs that are, as a result,
> hard as heck to fix.  Further, it requires you to have a running linux
> system to configure lilo to be able to boot.  What?  You don't have a
> running linux system?  Your lilo.conf stuff got hosed?  Go fetch a rescue
> disk.

Actually, if your MBR bootloader gets hosed on any PC your running for a bootdisk
regardless of OS. Its a problem with the architechure not lilo.
 
> Any booter that doesn't understand filesystems and has to have a list of
> blocks is a serious kludge.  For instance, who is to say that you want to
> boot off a block device at all?  And what if I wanted to replace a kernel
> from within another OS?  Can you say pain in the...

if you dont have a block device, and your not going to boot from it than
why would you worry about whether you have a bootloader installed on a
block device? 

> As for the contention that lilo works for 90% of the cases, in only a few
> weeks working with x86 machines, I've already run across a case where it
> couldn't be installed.  Perhaps a fluke that I'd run across it that
> quickly, but a _good_ boot mechanism works 100% of the time.  

weird i have installed on dozens of systems and lilo has worked
flawlessy, although I have had problems with WD E-Z drive writing over
the boot block stuff a few times(but only windows people are stupid
enough to use it), and I have had to wrestle with some scsi drives, though.

>Depending on
> a particular block to be always unused is more than a kludge, it's
> downright dangerous.  What if two architectures share a drive?  What if
> they happen to pick the same critical boot block?  Baaaad idea.  At least
> if it's a filesystem at a particular location, you can read it and say
> "hey, that's not a valid fs" or "hey, that partition table is bogus".
> With a boot block, there are no second chances.  You just crash.

Lilo, can handle at least 3 OS's. and it also gives errors as best it
can when it crashes.
if the partition table is mucked up.. chances are your MBR is all mucked
up and your not even going to get to the "let's check the partition
table stage"

Don't get me wrong, Im not saying LILO is the be all and end all of
bootloaders, Im not saying its perfect, bugfree or even the best type of
solution for the PPC platform, but at least take fair stabs at it. 

___________

The major advantages I can see to NOT using a boot block type of
bootloader are:

=>you want to netboot and you dont have a net-boot capable nic card than
you could boot into loader type of thing and be able "netboot" it
cheaply =)

=> eliminate architechure differences and be able to have enough room on
the partition to hold all kinds of system specific information.
(depending on the partition dedicated to it)

=> easier to work on since you dont _have_ to do it all in assembly.

The major disadvantages:

=> its still gonna suck for x86 systems since they do look at the boot
block by architechure default and it can be overwritten by other os
installations (such as BeOS, etc) since the hardware _always_ looks at
that spot (but than again x86 has always sucked IMHO) 

=> probably easier to drop a "boot partition" virus on the system
especially from another OS like the MacOS especially if the partition is
hfs it still be affected by things like the hong kong virus and would
still be mounted as a partition when running the MacOS (and if its not
HFS we are still stuck with the OF problems arent we?)

=> still need a separate partition for booting.

=> you would need a "utility" to edit the parameters partition.

=> assembly is a good thing to know =) 

=> the need to repartiton (very slight) i have to repartition and
reinstall anyway *lol*


Did I miss anything?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
