Message-ID: <3F3A6EE7.9050704@esteem.com>
Date: Wed, 13 Aug 2003 10:01:27 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Memory map with "holes"... (slightly off-topic)
References: <200308121432.09782.david.jander@protonic.nl> <3F391DA1.4040202@esteem.com> <200308131036.14144.david.jander@protonic.nl>
In-Reply-To: <200308131036.14144.david.jander@protonic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

	I'm glad to see you get the general principal behind the trick. I was
afraid I was going to get mailed data sheets and asked to design it for
you (Note: this has happened). I didn't know you pland on using chips
with differing column sizes, however you have seem to found a solution
to make it work. My hat off to you.

	Now the real challenge begins trying to program the UPM and figuring
out how to detect which memory config you have. I pretty sure that
variable columns will require different UPM programmings. Figguring out
the UPM was the toughest part of the design for us. A good BDM/JTAG
debugger is worth its weight in gold for this. A nice logic analyzer
wouldn't hurt either.

Good Luck,

	Conn
PS.

	Actauly in our design we planned on using different three chips sizes,
its just the largest isn't being built yet. We also found 4 other
manufacturers that made drop in replacements for the MT48LC2M32B2. The
only difference is they just had a higher CS latency and a slightly
diffent but compatible mode register programing sequence.

David Jander wrote:
>
> Thank you for the tip. AFAICS, you plan on using the only two 32-bit
> wide chips available in the same package from Micron. Fortunately,
> these have the same size of columns, and that makes things easy. At
> first we thought this trick wouldn't work with our design, since
> we plan on designing for 4 different 16-bit wide chips in TSOP-54
> housing, using always 2 of them to get a 32-bit bus. The reason:
> TSOP-54, 16-bit wide chips seem to be one of the most popular formats
> out there, used by most important SDRAM manufacturers, and for us it
> is vital to ensure we always get second sources for several years
> to come. The Micron types are MT48LC4M16A2 for the smallest, and
> 8M16, 16M16 up to 32M16 types. The problem is, that for these 4
> types you get 3 different column sizes and 2 different row sizes.
> Dealing with 3 different column sizes makes things a little tricky,
> but it is possible, and after playing around a little bit, we got
> to the following solution: SDRAM A[9:0] are connected straight to
> CPU A[20:29] and are muxed. SDRAM A10 connected to GPL0 that will be
> programmed to work as either A11 (for the 4M16 types), A10 (for the
> 8M16 and 16M16) or A5 (for the 32M16). SDRAM A11 connected to either
> A10 (for 4M16) or A7 (for the rest) selectable via two 0-Ohm resistors
> (place one or the other). Finally SDRAM A12 connects to CPU A6 and the
> bank select lines BA0 and BA1 go to CPU A9 and A8 respectively. You'll
> get half crazy checking this, but I believe it must work, it uses only
> one CS line (certainly not CS0, sorry for the mistake, Wolfgang ;-),
> and makes linux happy with one contiguous block of RAM always.

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
