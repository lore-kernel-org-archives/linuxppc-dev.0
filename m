Subject: Re: fstream on PPC?
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20031117155350.D76B7C5F59@atlas.denx.de>
References: <20031117155350.D76B7C5F59@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1069145908.1006.2.camel@toni>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 09:58:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op ma 17-11-2003, om 16:53 schreef Wolfgang Denk:
> Dear Toni,
>
> in message <1069081757.25853.5.camel@toni> you wrote:
> >
> > But when I allow the functions that use fstream (for saving and loading
> > small files over NFS), I get the following error:
> >
> > Linking test...
> > /opt/eldk/usr/ppc-linux/bin/ld: warning: libstdc++-libc6.2-2.so.3,
> > needed by /opt/PPC_X/usr/X11R6/lib/libGLU.so, not found (try using
> > -rpath or -rpath-link)
> ...
> > and more than a dozen of these errors. It's a linking problem, that's
> > what I know. But I don't know how to get to the problem-core. Can I
>
> Why not? The error message is pretty plain english:
>
> Your  link  step  included   the   /opt/PPC_X/usr/X11R6/lib/libGLU.so
> library,    which    in    turn    tried    to   link   against   the
> libstdc++-libc6.2-2.so.3 library, which was not found by the linker.

Strange. It did found it before. Should check that further then.
Although the resulting binary runs fine on the EP405.

> > solve this by a quick hack? Or is it hopeless to start messing with
> > fstream on PPC?
>
> I don't know where  you  got  the  /opt/PPC_X/usr/X11R6/lib/libGLU.so
> library  from.

Compiled from source, linked against ELDK. Works perfectly.

> > PS: don't mind the warning about libstdc++-libc6.2-2.so.3, it's in place
> > on the embedded system.
>
> You must be joking. Of course you have to mind this.  It's  the  root
> cause  of your problems. And other problems are lurking to hit you as
> libstdc++-libc6.2-2.so.3 is most probably incompatible to  the  ELDK,
> too.

Hmm. Still find it strange. It compiles, it runs, and it only complains
at compile time. Very odd, but I'll try to remove the first warning and
see what happens.

Thanks for your help.
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
