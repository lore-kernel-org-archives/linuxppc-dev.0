To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fstream on PPC? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 16:09:18 +0100."
             <1069081757.25853.5.camel@toni>
Date: Mon, 17 Nov 2003 16:53:45 +0100
Message-Id: <20031117155350.D76B7C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Toni,

in message <1069081757.25853.5.camel@toni> you wrote:
>
> But when I allow the functions that use fstream (for saving and loading
> small files over NFS), I get the following error:
>
> Linking test...
> /opt/eldk/usr/ppc-linux/bin/ld: warning: libstdc++-libc6.2-2.so.3,
> needed by /opt/PPC_X/usr/X11R6/lib/libGLU.so, not found (try using
> -rpath or -rpath-link)
...
> and more than a dozen of these errors. It's a linking problem, that's
> what I know. But I don't know how to get to the problem-core. Can I

Why not? The error message is pretty plain english:

Your  link  step  included   the   /opt/PPC_X/usr/X11R6/lib/libGLU.so
library,    which    in    turn    tried    to   link   against   the
libstdc++-libc6.2-2.so.3 library, which was not found by the linker.

This is not a big surprise, as the current version of the ELDK  ships
with libstdc++-libc6.1-2.a.3


> solve this by a quick hack? Or is it hopeless to start messing with
> fstream on PPC?

I don't know where  you  got  the  /opt/PPC_X/usr/X11R6/lib/libGLU.so
library  from. I guess you copied if from a standard PowerPC release.
This is very risky in itself, as it may have been built in a way wich
is incompatible to the ELDK libraries (or  are  you  absolutely  sure
that  they  use  the  same  settings  for  FPU support and cache line
sizes?).

You should probably rebuild libGLU using the ELDK tools, and link  it
against the ELDK provided C/C++ libs.


> PS: don't mind the warning about libstdc++-libc6.2-2.so.3, it's in place
> on the embedded system.

You must be joking. Of course you have to mind this.  It's  the  root
cause  of your problems. And other problems are lurking to hit you as
libstdc++-libc6.2-2.so.3 is most probably incompatible to  the  ELDK,
too.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ninety-Ninety Rule of Project Schedules:
        The first ninety percent of the task takes ninety percent of
the time, and the last ten percent takes the other ninety percent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
