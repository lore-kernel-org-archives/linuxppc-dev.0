Date: Sat, 16 Sep 2000 18:13:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ati fb memory assignment on Lombard
In-Reply-To: <7736F9DF539.AAA1702@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10009161800100.13459-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can anyone tell me if there are any problems with overlapping memory
> assignments for the ATY Mach64 chip on a Lombard PB? I'm having trouble
> getting my 4.0.1 Xserver to detect the device although the system seems to
> detect the chip alright at bootup. I've been through the Xpert list at
> XFree86 and we've groud to a halt.

With a 2.2 kernel:
You need to use yaboot, or fix up the overlapping PCI resources allocated
by OF or MacOS yourself when using BootX. I've posted a diff to
debian-powerpc that  remaps the MMIO region outside the VRAM region,
without any sanity checks to make sure that region hadn't been mapped
previously. It's a hack, and won't ever make it into the official kernel.

With 2.3:
Use Geert's PCI resource allocation patch, posted here a couple of months
back. Might be in 2.4.0pre already. Or, again, use yaboot.

BTW: in my case, the X server had no problem _detecting_ the chip, but
helpfully removed the PCI mapping for the VRAM region. The resulting
invalid access to MMIO registers aliased at the end of the VRAM region
(that's where atyfb puts them) crashed the kernel hard. If you get away
without a kernel crash, your problem might be different. Using yaboot
instead of BootX is a good idea nonetheless.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
