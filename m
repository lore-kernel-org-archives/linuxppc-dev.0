Date: Mon, 29 Nov 1999 08:12:36 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Dan Malek <dan@netx4.com>
cc: Dan Malek <dan@penguin.netx4.com>, Christian Zankel <chris@mvista.com>,
        cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <3841AF8D.48EDE940@netx4.com>
Message-ID: <Pine.GSO.4.10.9911290804550.859-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 Nov 1999, Dan Malek wrote:
> Geert Uytterhoeven wrote:
> > ...... All unused code will be optimized away
> > by the compiler.
> 
> Maybe.  I haven't seen much dead code elimination by
> the compiler.  I guess one of the bazillion compiler switch
> combinations would do it.  I haven't found a good one yet.

Gcc does since ages, at least for simple cases. Just compile

    extern void f(int);
    extern void g(int);

    void h(int x)
    {
	if (0)
	    g(x);
	else
	    h(x);
    }

with gcc. If you compile with at least -O, the only thing left is the call to
h(). On m68k, we've been using `if (MACH_xxx)' clauses (and also `switch
(MACH_TYPE)' since ages. Remember, the m68k port was the first port and it
started with support for multiple machines nearly in the beginning. In those
times, gcc was not that good yet, but this worked. Take a look at
include/asm-m68k/setup.h to see how we did it.

> I have seen some pretty bad code over the past 20 years of my
> career, and this stuff isn't even close to bad.  That doesn't
> mean I am not going to try to make it better, we just have
> to do it carefully because any changes in these files affect
> lots of people (and other files).  Just remember that one of
> my goals is to build small as possible embedded software that
> reduces Flash ROM requirements.  Carrying along stuff like
> keyboard and ADB drivers just to resolve some symbols doesn't
> help us do this.

Exactly my point. I don't want any ADB stuff compiled in in my kernel neither
:-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
