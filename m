Date: Wed, 24 May 2000 14:39:17 -0400
From: Simon Piette <spiette@generation.net>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Promise Ultra/66
Message-ID: <20000524143917.I1169@xim.bellglobal.com>
Reply-To: spiette@generation.net
References: <20000524130410.C1169@xim.bellglobal.com> <200005241756.TAA00723@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200005241756.TAA00723@piglet.grunz.lu>; from mlan@cpu.lu on Wed, May 24, 2000 at 07:56:00PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Michel Lanners (mlan@cpu.lu) [000524 13:59]:
> Hi Simon,
>
> On  24 May, this message from Simon Piette echoed through cyberspace:
> [about the promise/66 in a Mac]
> >> Forget about these old patches. Go to my PCI page:
> >>
> >> http://www.cpu.lu/~mlan/linux/dev/pci.html
> >>
> >> and get yourself my latest patches for either 2.2.15 (kernel.org) or
> >> 2.3.99-pre7 (linuxcare.au) kernels. For 2.2.15, you need Andre's patches
> >> in addition to mine. Apply his IDE patches first.
>
> To all those interested: there are new patches up for 2.2.15; I screwed
> up with the older ones. Went back to an old version of my PCI patches.
> Damn ;-)
>
> > Great! It's working without a hitch (but with a few kernel args!).
>
> Which ones are those? I need none; I could do with idebus=xx for bus
> frequency; but the default is ok...

I use an IMS TwinTurbo card driver that I can't get to work in 2.2.15, so I'm
stuck with 2.2.12. I've had to add some hde=noautotune and
hde=4092,13,63 for an old Seagate ST32122A. None of those was needed
with 2.2.15.

>
> > I have to say that I can't put my card in slot 3 or 4, but only in 1 or
> > 2. Not an issue for me but you may want to know ...
>
> What was your machine again? There might be an issue either with bus
> mastering (some brain-dead designs don't allow bus masters in all slots;
> the Promise is a bus master) or with multiple PCI buses. In the first
> case there's nothing you can do; in the second case I might have screwed
> up my patches....

It's a Umax J700/180. lspci:

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d38 (rev 01)
00:0e.0 Display controller: Integrated Micro Solutions Inc. IMS9129 (rev 01)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)

>
> > Also, the Promise Card is the only one IDE controller on my Mac, but it
> > gets detected at ide2 and ide3. Not an isssue for me neither :-)
>
> CONFIG_BLK_DEV_OFFBOARD=y in your .config; the option is 'Boot off-board
> chipsets first'. I guess reserving two IDE buses that are not actually
> probed is braindamaged PC legacy ;-)
>
> Be carefull when actually activating this, as your disks will change
> devices, and your /etc/fstab will be out of sync!

OK. thanks.

Simon

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
