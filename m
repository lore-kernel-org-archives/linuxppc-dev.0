Message-ID: <20011102140024.7830.qmail@dag.newtech.fi>
To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC Vs MontaVista 
In-Reply-To: Message from "Sarnath Kannan" <sparc64@rediffmail.com>
   of "02 Nov 2001 13:47:54 GMT." <20011102134754.29665.qmail@mailweb16.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Date: Fri, 02 Nov 2001 16:00:24 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Guys,
>   I ran into some accidental discoveries
> while scanning EPIC code written by Mvista.
>   As I said b4 there is a descrepancy with
> the OpenPIC register layout and EPIC layout.
> But the way Mvista people have programmed EPIC is
> good in one sense, bad in other.
>   The reason for assigning vector of 16 to PCI
> interrupts is because each entry in the "Interrupt Source" is 32 bytes long, 16 * 32 = 512 = 0x200
> which equals the difference in offsets between
> the std openPIC layout and EPIC register layout.
> This 16 has got NOTHING TO DO with NUM_8259_INTERRUPTS.
> But Mvista code seems to assume that this feature
> is because of NUM_8259_INTERRUPTS. ( See the
> #define for SANDPOINT_SIO_IRQ ).
> Thus while writing into  Sources[16], mvista code
> writes into "sources[0]" in the EPIC reigster layout.
> Thus IRQ0 gets initialized to vector 16.
>  The "offset" field in "openpic_init" code,
> is mainly used to seperate of vector spaces of
> various interrupt controllers in the system.
>   EPIC manual clearly says that the "Interrupt
> Sources" register offset start at 0x50200. mvista
> code overwrites the 0x50000-0x50200 fields ( which are
> actually reserved as per EPIC manual ). Thus the
> reliablity of MVISTA code is a question mark .
> I have come across some "Bogus interrupts" while
> runing MVISTA code in my box. The above
> explan may very well be the reason of why such bogus
> interrupts are being generated.

Hi,

Funny you should write about this.!
I am just trying to fix it in a reasonable way
for my EPIC-board.

I would like to suggest a global variable ie.
OpenPIC_RegOffset
which would be inited to 0 and could be changed to
16 for a MPC107 (EPIC).
This wouldn't (shouldn't) break anything existing
and will enable the port of a EPIC-board to use
all the generic openpic routines.

Even if I don't like touching "generic" code, I even
more dislike code-duplication

I could submit the patches, if your are interested,
they are noe too big, and a review from the masses
should do the code good.

BRGDS



--
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
