To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compilation question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Sep 2003 09:44:54 +0200."
             <1063093493.12979.4.camel@toni>
Date: Tue, 09 Sep 2003 18:18:42 +0200
Message-Id: <20030909161847.7D088C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1063093493.12979.4.camel@toni> you wrote:
>
> Hi all,
>
> I've installed ELDK as compiler-set, and it is successfully used to
> compile linuxppc_2_4_devel, rtai and FLTK for my EP405 board.
>
> Now I have a FLTK-based program which I like to cross-compile, but I get
> stuck to one error I cannot solve right now:
>
> ppc_4xx-g++ -static -g test.cxx -I/ppc/fltk-1.1.4rc2 -o test
> -L/opt/eldk/ppc_4xx/lib -L/opt/eldk/ppc_4xx/usr/lib
> -L/ppc/fltk-1.1.4rc2/lib -L/opt/PPC_X/usr/X11R6/lib -L/opt/PPC_X/usr/lib
> -lfltk -lXext -lX11
> /opt/eldk/usr/ppc-linux/bin/ld: cannot find -lstdc++
> collect2: ld returned 1 exit status
>
> As far as I know, is libstdc++.so in /opt/eldk/ppc_4xx/usr/lib, which is
> added as -L.
>
> Anyone who know the solution (which will probably be easy).

First, your list of "-L" options makes little sense to me.  There  is
no need to add /opt/eldk/ppc_4xx/lib or -L/opt/eldk/ppc_4xx/usr/lib.

Second: did you try what happens when you omit the "-static" argument?


If you really must link with "-static", try something like this:

GCCLIBDIR=/opt/eldk/ppc_4xx/usr/lib/gcc-lib/ppc-linux/2.95.4
${CROSS_COMPILE}g++ -static -L${GCCLIBDIR} ...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No journaling file system can recover your data if the disk dies.
                                 - Steve Rago in <D4Cw1p.L9E@plc.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
