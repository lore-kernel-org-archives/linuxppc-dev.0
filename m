From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Gabriel Paubert <paubert@iram.es>,
        Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 14:36:44 -0500
Content-Type: text/plain
Cc: David Edelsohn <dje@watson.ibm.com>, khendricks@ivey.uwo.ca,
        linuxppc-dev@lists.linuxppc.org
References: <Pine.HPX.4.10.10001202018380.18916-100000@gra-ux1.iram.es>
In-Reply-To: <Pine.HPX.4.10.10001202018380.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Message-Id: <00012014395300.05824@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Actually if base_addr can be reused by the compiler for other accesses
> to the same area (byte or big endian), it should be written as:
>
> "stwbrx %0,%1,%2": : "r" (regdata), "b" (base_addr), "r" (regindex)
>
> with a volatile qualifier on the asm statement but I disagree on the
> "memory" clobber if this does not access areas the compiler will ever
> touch and does not have side effect.
>
> There are already too many memory clobbers out there, they are bad because
> they basically tell the compiler that it can not keep a single variable
> in a register.

In this particular case, the base address can change (but very very rarely
such as writing to one Aperature or Another on the Rage 128 card) and all of
the writes are made to either the card memory mapped io or the frame buffer
itself.

Should I not include the : "memory" clobber in this case?  Will it hurt
performance much?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
