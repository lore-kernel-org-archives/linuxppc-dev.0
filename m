Date: Mon, 18 Feb 2002 09:31:21 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: RE: Final question: best wasy to move /, /usr, /home, etc?
In-Reply-To: <XFMail.20020218094253.pochini@shiny.it>
Message-ID: <Pine.LNX.3.96.1020218092106.6585B-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 18 Feb 2002, Giuliano Pochini wrote:

> > I am finally at the point I want to give up my old external scsi hard
> > drives.  Unfrotunately, my current /, /usr, /home, etc all exist on scsi
> > drives.
> >
> > I recently purchased a 60 gig hard drive (ide) and have now installed it.
>
> IDE ?!?  Bleah !!

Yeah.  Be forewarned.  Some IDE drives over 34 gigs, particularly when
attached to ATA cards, behave badly under Linux, causing horrible file
system corruption caused by high block numbers being stupidly remapped
over the top of lower block numbers.

After adding an hdg=x,y,z line, it worked until I shut the machine off, at
which point it said that the file systems that were above the 34 gig limit
weren't there.  So it had failed again.  Several reboots later, it
magically started working.

Long story short, in its power-on state, the Maxtor drive gave incorrect
fictitious geometry, indicating that it was a 2 gig drive.  The Linux
kernel code was ignoring the boot arguments and was proceeding to
overwrite them with data from an inquiry on the drive.  The problem was
that since the drive reported itself as having 4092 cylinders instead of
the 16,653 cylinders that large drives are -supposed- to report as their
fictitious BIOS geometry, the Linux kernel didn't realize that the
geometry was fictitious, and refused to allow the LBA size information to
override the drive-returned geometry.

It took me a couple of days to debug the IDE code in the kernel to create
a workaround.  This is probably the result of a firmware bug in my Maxtor
drive, but if people run into problems where partitions above the 34 gig
limit will fail to work correctly for the first several boots but then
magically start working, I have a possible patch against the 2.2.21
prepatch kernels (should work against any of them, as the code hasn't
changed much).


Later,
David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
