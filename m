Message-ID: <3B74AADC.C2CE7B89@mvista.com>
Date: Fri, 10 Aug 2001 23:47:40 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>,
	Daris A Nevil <dnevil@snmc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108091838380.11077-100000@localhost.localdomain> <3B72E40D.3080600@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Desnoyers wrote:

> ..... It returns a virtual address plus a DMA
> address in an arg ptr - throw away the DMA address, as that's
> PCI-specific, and run the virtual address through virt_to_phys().

Ummm...damn, that's a tricky one.  On 8xx, the intention is to use
the DMA address for stuffing into the CPM.  The virt_to_* functions
are on their way out (on all platforms), and everyone should use the
DMA address returned by the consistent_alloc function.  I guess if you
have a 8xx/PCI that doesn't map PCI masters to system memory at zero,
you are kind of hosed at the moment........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
