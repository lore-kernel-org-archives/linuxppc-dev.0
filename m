Date: Thu, 25 Jan 2001 20:28:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A705D92.682A6FEF@mvista.com>
Message-ID: <Pine.HPX.4.10.10101251838570.22074-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Jan 2001, Dan Malek wrote:

>
> Roman Zippel wrote:
>
> > And they don't have to.
>
> So, why do we have so damn many ways and hacks to do stuff like
> this?  If a page or I/O is mapped into the VM space, there should
> be a set of common functions to manage this space, and exactly one
> function to do the virt_to_phys.
>
> > .... If you have a highmem page, use kmap to get
> > temporary virtual mapping. On the other hand most of the drivers should
> > never see a highmem page.
>
> On the other hand, if highmem was designed properly the kernel
> should just fault in the needed pages and virt_to_phys and friends
> should just work in this space, too.  Yet another set of functions
> to use and restrictions just because a physical page exists beyond
> some arbitrary boundary?  Geeze, I thought we learned from Mush-DOS
> back in the mid-80's this was not a good design........

It's quite hard when there are more bits in a physical address bits than
in a pointer. The 7450 have 36 address lines (like PPro+ BTW). Has anybody
any docs on how the MMU has been modified to handle the extra bits on the
7450. Motorola has mostly marketing pamphlets on its web site.

The only port which is simple is the 68k AFAICT: use moves instructions
for {get,put}_user and map all physical memory in the kernel even if you
have 3 gigs. Using such a simple trick for processors which do not allow
to (easily or not) access alternate address spaces is not an option. Ah,
if only there were 500MHz 68060 ;-)

Of course, 64 bit architectures will solve the problem ... until bloatware
makes 2^63 bytes too small even for the simplest applications and the
brand new 128 bit architectures start to appear. Now, assuming that you
can store one bit in one atom of hydrogen, the weight of 2^128 bytes of
memory would be in the range of a few 10^9 tons, hardly practical for
mobile systems ;-)

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
