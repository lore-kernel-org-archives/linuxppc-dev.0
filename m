Subject: Re: Cross compilation question
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030909161847.7D088C59E4@atlas.denx.de>
References: <20030909161847.7D088C59E4@atlas.denx.de>
Message-Id: <1063186199.32501.3.camel@toni>
Mime-Version: 1.0
Date: Wed, 10 Sep 2003 11:30:00 +0200
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op di 09-09-2003, om 18:18 schreef Wolfgang Denk:
> In message <1063093493.12979.4.camel@toni> you wrote:
> >
> > I've installed ELDK as compiler-set, and it is successfully used to
> > compile linuxppc_2_4_devel, rtai and FLTK for my EP405 board.
> >
> > Now I have a FLTK-based program which I like to cross-compile, but I
> > get stuck to one error I cannot solve right now:
> >
> > ppc_4xx-g++ -static -g test.cxx -I/ppc/fltk-1.1.4rc2 -o test
> > -L/opt/eldk/ppc_4xx/lib -L/opt/eldk/ppc_4xx/usr/lib
> > -L/ppc/fltk-1.1.4rc2/lib -L/opt/PPC_X/usr/X11R6/lib -L/opt/PPC_X/usr/lib
> > -lfltk -lXext -lX11
> > /opt/eldk/usr/ppc-linux/bin/ld: cannot find -lstdc++
> > collect2: ld returned 1 exit status
> >
> > As far as I know, is libstdc++.so in /opt/eldk/ppc_4xx/usr/lib,
> > which is added as -L.
> >
> > Anyone who know the solution (which will probably be easy).
>
> First, your list of "-L" options makes little sense to me. There is no
> need to add /opt/eldk/ppc_4xx/lib or -L/opt/eldk/ppc_4xx/usr/lib.
>
> Second: did you try what happens when you omit the "-static" argument?
>
> If you really must link with "-static", try something like this:
>
> GCCLIBDIR=/opt/eldk/ppc_4xx/usr/lib/gcc-lib/ppc-linux/2.95.4
> ${CROSS_COMPILE}g++ -static -L${GCCLIBDIR} ...

I removed the eldk-lib stuff, and added the GCCLIBDIR.
Now, it compiles, but doesn't link. A lot of 'undefined reference to'
which I don't understand (they all are about FLTK though).

Thank you for your help already.

PS: I need the -static, but without it, it gives me some more undefined
references to the X-libs.
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
