Message-ID: <39FDBC6C.1F6496CF@execpc.com>
Date: Mon, 30 Oct 2000 12:22:36 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Jim Blackburn <blackbjm@jmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC driver issue addressed?
References: <B6231A90.1458%blackbjm@jmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jim Blackburn wrote:
>
> Hi all:
>
> I experience the infamous problems with the bmac driver on my beige g3
> minitower.  A while back there was talk of analyzing Darwin's workaround for
> the bmac's hardware issues and implementing that into Linux's kernel.  Has
> anyone taken on this project since that discussion, or has it been shuffled
> down to the bottom of the deck in light of more pressing issues with the
> kernel?

By which i think you mean the collide-with-self with 100k/s max Xfer w/ errors?
I'd still like to see it fixed :)

I tried to fix it at one point, but didnt get far.  My code only caused the
kernel to panic, but I should mention, it panicked whenever it would normally
have stalled or collided.  Looking closer, it would appear that what I was
doing, which was ignoring packets that aren't for us or our Masq, seems to be
already done in the Linux kernel.  maybe my implementation was doing something
different and more correct, save the panic.

Looking at the darwin kernel, which is where I got the idea, It looks like it
was doing it for a particular revision of the motherboard, which I remember
calling 0x10.  My PDQ i think is a 0x17, and I had the pleasure of running my
Linux setup on a 0x10 at one point.  the 0x10 did not have the collision problem
in linux, while my 0x17 does.  the value refers to some value somewhere in the
device tree.  im sure you can find it after looking at where Darwin gets it. it
might be /proc/device-tree/pci/mac-io/device-id (lsprop)

I'm still puzzled about the whole thing, like if Darwin is filtering those
packets we should be ignoring anyway, and Linux does too, Is this really the
problem?  And what was it I was really doing those months ago?  (sorry, i lost
my old code)  I recall using standard things in the kernel.  just one acception
added that was in the case of it should have been ignored by the chip.

According to the ppclinux sourceforge bug tracker, the problem was fixed for a
patched kernel or two.  <shrug>

Corrections?  Comments?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
