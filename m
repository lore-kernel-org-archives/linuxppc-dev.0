From: David Jander <david.jander@protonic.nl>
To: Conn Clark <clark@esteem.com>
Subject: Re: Memory map with "holes"... (slightly off-topic)
Date: Wed, 13 Aug 2003 10:36:14 +0200
References: <200308121432.09782.david.jander@protonic.nl> <3F391DA1.4040202@esteem.com>
In-Reply-To: <3F391DA1.4040202@esteem.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308131036.14144.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Conn,

Thank you for the tip. AFAICS, you plan on using the only two 32-bit wide
chips available in the same package from Micron. Fortunately, these have the
same size of columns, and that makes things easy.
At first we thought this trick wouldn't work with our design, since we plan on
designing for 4 different 16-bit wide chips in TSOP-54 housing, using always
2 of them to get a 32-bit bus. The reason: TSOP-54, 16-bit wide chips seem to
be one of the most popular formats out there, used by most important SDRAM
manufacturers, and for us it is vital to ensure we always get second sources
for several years to come. The Micron types are MT48LC4M16A2 for the
smallest, and 8M16, 16M16 up to 32M16 types. The problem is, that for these 4
types you get 3 different column sizes and 2 different row sizes. Dealing
with 3 different column sizes makes things a little tricky, but it is
possible, and after playing around a little bit, we got to the following
solution:
SDRAM A[9:0] are connected straight to CPU A[20:29] and are muxed.
SDRAM A10 connected to GPL0 that will be programmed to work as either A11 (for
the 4M16 types), A10 (for the 8M16 and 16M16) or A5 (for the 32M16).
SDRAM A11 connected to either A10 (for 4M16) or A7 (for the rest) selectable
via two 0-Ohm resistors (place one or the other).
Finally SDRAM A12 connects to CPU A6 and the bank select lines BA0 and BA1 go
to CPU A9 and A8 respectively.
You'll get half crazy checking this, but I believe it must work, it uses only
one CS line (certainly not CS0, sorry for the mistake, Wolfgang ;-), and
makes linux happy with one contiguous block of RAM always.

Sincerely,

--
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1628 AL Zwaag

On Tuesday 12 August 2003 19:02, you wrote:
>
>  It is possible to design a system to accomidate larger ram chips for
> future expansion with out leaving holes in your memory map. We did
> this on our ESTeem 192E. What you need to do is design your memory
> system around the samllest chip in the memory family you intend
> to use. connect the bank selects lines to the address immediately
> following the highest address line used by the smallest memory part.
> Then following the bank selects place the other address lines to the
> larger memory parts
>
> This is how we did ours ( and it works with the larger parts )
>
> We designed our board using a Micron part MT48LC2M32B2. But we
> decieded to include an extra clock cycle so we could use other
> manufacturers parts, Such as Toshiba TC59S6432CFT and Samsung
> K4S643232C(not tested)
>
> Micron has said that they will make a bigger parts in the same foot
> print.
>
> This is how we hooked up our ram to make provisions for the larger
> parts. (Note that the two additional address lines have an * next to
> them)
>
> MPC850                    SDRAM
> =============================
> A29                        A0
> A28                        A1
> A27                        A2
> A26                        A3
> A25                        A4
> A24                        A5
> A23                        A6
> A22                        A7
> A13                        A8
> A12                        A9
> GPL_A0                     A10
> *A8                        A11 (pin 71)
> *A7                        A12 (pin 69)
> A10                        BA0
> A9                         BA1
> OE_GPL_A1                  RAS
> GPL_A2                     CAS
> GPL_A3                     WE
>
> This design will probably work with little modification on all of the
> MPC860 family.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
