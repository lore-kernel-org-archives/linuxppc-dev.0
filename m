Message-ID: <3C03E5E9.A9C49A4A@mvista.com>
Date: Tue, 27 Nov 2001 12:13:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: gratuitous complexity
References: <15363.33009.545085.87868@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I was innocently browsing through include/asm-ppc/gt64260.h when I
> came across this:
>
> #ifndef TRUE
> #define TRUE    (0 == 0)
> #endif
>
> #ifndef FALSE
> #define FALSE   (0 != 0)
> #endif
>
> I nearly lost my dinner!  It's just not fair to spring something that
> awful on people without at least a warning for those with weak
> stomachs. :)
>
> Seriously though, it is unnecessarily complex.  If you want to use TRUE
> and FALSE, define them as 1 and 0.  The C language standard specifies
> that 0 is false and anything non-zero is true.

Hmm, yeah, not sure why that ended up in there but I'll get rid of it.

> I also wonder why we need so many functions to access the gt64260 -
> there are 19 different functions of the form gt64250*_set_*, which
> seems completely over the top to me.  How many of them actually get
> used?

Well, the gt64260 is a complicated bridges/chip with many windows to
different "entities" only one type of which are to the PCI buses (and lots
of other things).  There are also windows from each PCI bus back to each
of the other "entities" PLUS a P2P bridge between the 2 PCI buses.  Each
window has its own quirks so there is a separate routine for each type of
window.

Yes, many of the gt64260_*_set_* routines are used but some aren't.  I
provided all of them because there will undoubtedly be someone who wants
to use ones not used now.  I provided gt64260_bridge_init() that would do
what I expect to be a typical bridge set up but there is certainly no
requirement to use that routine.

I'm open to suggestions, if you have some.

Also, if you still don't like what I did, perhaps you should take a look
at what was available before... :)

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
