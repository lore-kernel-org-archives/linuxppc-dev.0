Date: Thu, 20 Jan 2000 20:31:08 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
cc: David Edelsohn <dje@watson.ibm.com>, khendricks@ivey.uwo.ca,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <4.2.2.20000120195050.00c796f0@mail.munich.netsurf.de>
Message-ID: <Pine.HPX.4.10.10001202018380.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 20 Jan 2000, Franz Sirl wrote:

>
> At 19:26 20.01.00 , David Edelsohn wrote:
>
> >         The "b" constraint should be associated with "base_addr", not with
> >"regindex":
> >
> >         asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex),
> > "b"(base_addr));
>
> Uhm, David, that's wrong. "b" has to be assigned to %1!

Actually if base_addr can be reused by the compiler for other accesses
to the same area (byte or big endian), it should be written as:

"stwbrx %0,%1,%2": : "r" (regdata), "b" (base_addr), "r" (regindex)

with a volatile qualifier on the asm statement but I disagree on the
"memory" clobber if this does not access areas the compiler will ever
touch and does not have side effect.

There are already too many memory clobbers out there, they are bad because
they basically tell the compiler that it can not keep a single variable
in a register. Have a look at the effect of in and out instructions
in the linux kernel which reload isa_io_base repeatedly when there is no
need for it, that's not exactly a speed issue but a icache footprint
and bloat issue.

This is an effect which is important on all machines which have a
resonable number of registers (all modern ones in practice and perhaps
even the 68k).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
