Date: Tue, 24 Apr 2001 18:19:15 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pte entries for the 440
In-Reply-To: <3AE5A354.9A82E5DA@raleigh.ibm.com>
Message-ID: <Pine.HPX.4.10.10104241810010.23250-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 24 Apr 2001, Ralph Blach wrote:

> I am starting a port of linux to the IBM440 processor.  The 440 has an
> 36 bit address space.  Reading the kernel sources, I see two options for
> the page tables.
> 1)One, make it a structure with the permissions being in the second
> word.
> 2)Make it a long long.

Make it a structure, gcc is (or at least was) not very good at
manipulating 64 bit integers on 32 bit machines. I suspect that you need
to shift/mask the physical address to put the bits in the correct place,
in this case gcc prefers a stucture for sure.

It is much easier on the compiler and the register allocation routines to
consider single register quantities.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
