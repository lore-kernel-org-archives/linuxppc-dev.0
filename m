Date: Thu, 29 Mar 2001 02:05:32 -0500 (EST)
From: Daniel Berlin <dan@www.cgsoftware.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <15042.55896.10936.34707@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10103290147210.18522-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, David S. Miller wrote:

>
> Daniel Berlin writes:
>  > Dave, I already took care of most of these. If you remove the selfid
>  > bitfields, the set of patches i sent to the linux1394 list recently to
>  > make it work on a powerbook g3 should work fine on other big-endian
>  > architectures.
>
> Thanks, I was not aware of these patches, I'll check them out.

Be aware they may need some tweaking. Apple does byteswapping in very odd
conditions, (IE if i use firewire's physical dma access for the memory
transfers in SBP-2 , for instance, you get it in a different byte order
than if you turn off physical dma processing for the controller. But it's
not just swapped, only pieces of it are.  Since it's at least consistent
byte order when you let it do the physical dma on the controller, i stuck
with that.) The powerbook g3 firewire controller is known to be buggy
until very recent revisions, and disassembling the apple mac os x
drivers for fun shows they explicitly check for it, so it's likely
a non-broken big-endian firewire controller may act differently.  It would
be a simple matter of not swapping some things i swap, though, not
anything particularly difficult. Most of this stupidity is confined to
the sbp-2 specific stuff, the ohci1394.[ch] (to swap stuff crossing the
pci boundary that wasn't a register read/write)  and
ieee1394_transactions.[ch] (to swap the data in non-quadlet cases, but
not swap the headers)
changes should work pretty well.  If the patches + removing the bitfields
for self-id (which it sounds like you already did) give you the ability to
at least attempt to send packets (IE it runs the dma programs),
you are in very good shape.  I had to get the byteswapping basically
perfect to even get it to not just laugh at me and do nothing when we told
ia dma context to run.

I also assumed readl/writel do byteswapping, and thus, there was no need
to swap the register reads/writes since they would be swapped for us.

At the absolute least, it'll give you an idea of what needs to be swapped
for big endian architectures.

It's also implemented in a way that makes the changes no-ops for LE
architectures. (which is probably the only good thing about the endian
choice of firewire).
>  > I also have a set of endian fixes for the sbp-2 driver that james goodwin
>  > (author of the sbp-2 stuff) is working on integrating, mainly it involves
>  > removal of all of the bitfields, which were screwing up non-LE
>  > architectures.
>  >
>  > I happily use my two 45 gig firewire drives under LinuxPPC, and have been
>  > for weeks.
>
> It won't work on sparc64 until it is fixed to not use
> virt_to_bus/bus_to_virt and uses the PCI dma interfaces instead.

I have
patches to do this somewhere, it didn't matter for powerppc, so it was
only a half hearted attempt.

> I have one of these drives as well :-)

It's very nice to just be able to go to class, come back, and plug back in
one connection, and have access to a 90 gig XFS filesystem without hassle.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
