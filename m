Date: Thu, 20 Jan 2000 20:59:06 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Franz Sirl <Franz.Sirl@munich.netsurf.de>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012014395300.05824@localhost.localdomain>
Message-ID: <Pine.HPX.4.10.10001202043560.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	Hi,

> In this particular case, the base address can change (but very very rarely
> such as writing to one Aperature or Another on the Rage 128 card) and all of
> the writes are made to either the card memory mapped io or the frame buffer
> itself.

Then the memory clobber would force the compiler to reload base_addr
between 2 writes to the frame buffer.

> Should I not include the : "memory" clobber in this case?  Will it hurt
> performance much?

I think that it is not necessary: the best thing with a compiler which
performs alias analysis might be to tell the truth

asm ("stwbrx %1,%2,%3"
     : "=m" (*(volatile unsigned *)(base_addr+regindex))
     : "r" (regdata), "b" (base_addr), "r" (regindex));

Note we don't use %0, and it won't produce any aditional code. You may
want to check what the compiler would have generated as addressing mode
by appending " # %0" at the end of the code string.

I truly wish there were a constraint for indexed addressing modes (anyway
this will be necessary for proper Altivec support).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
