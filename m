Message-ID: <3B77F684.415638E8@chinook.com>
Date: Mon, 13 Aug 2001 11:47:16 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>,
	Daris A Nevil <dnevil@snmc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108091838380.11077-100000@localhost.localdomain> <3B72E40D.3080600@chinook.com> <3B74AADC.C2CE7B89@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Peter Desnoyers wrote:
>
> > ..... It returns a virtual address plus a DMA
> > address in an arg ptr - throw away the DMA address, as that's
> > PCI-specific, and run the virtual address through virt_to_phys().
>
> Ummm...damn, that's a tricky one.  On 8xx, the intention is to use
> the DMA address for stuffing into the CPM.

Yow.  So the MBX860 setup, for instance, with PCI_DRAM_OFFSET=2gig, just
won't work.

This seems like another case of either too little abstraction, or too
much.  An embedded PPC system with PCI basically has two buses, with
different DMA addressing, and there's no way to tell consistent_alloc(),
etc. about that.

> The virt_to_* functions
> are on their way out (on all platforms), and everyone should use the
> DMA address returned by the consistent_alloc function.

Jeez, you look the other way for a little while :-)  The last time I was
doing Linux driver development was in 1999, and virt_to_* was still
getting phased in, it seemed...

If you wouldn't mind, could you give me a pointer to the discussion of
this phase-out?

> I guess if you
> have a 8xx/PCI that doesn't map PCI masters to system memory at zero,
> you are kind of hosed at the moment........

I wonder if the proper thing to do is to enhance consistent_alloc to
take an argument indicating the bus type?  There are more elegant ways
of doing things, but this wouldn't involve changes to a lot of code.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
