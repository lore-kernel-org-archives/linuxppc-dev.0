Message-ID: <38CE1B4A.7BC9AFD5@iiic.ethz.ch>
Date: Tue, 14 Mar 2000 11:58:18 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
References: <Pine.LNX.4.10.10003131729540.1152-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> There's a lot more going on: in 32 bit mode the X server complains about
> invalid weight (000) and refuses to probe OK. In 16 bit mode some part of
> the server assumes 565 bit weighting but the kernel code only ever sees
> 000.

I don't know for sure, but I guess the fbdev driver gets the weight from
atyfb? That would strongly point to a bug there.


> I'm a bit confused here. In 8 bit mode, I get the X server to print a
> message like:
>
> fbdev trace: FBDevScreenInit: before screeninit8/16/32
> fbdevHW: fbScreenInit: before fbSetupScreen             < my trace message
>
>         This should not happen!
>         An unresolved function was called!
>
> That's in programs/Xserver/fb/fbscreen.c. fbSetupScreen ought to print
> another message on entry but that never happens. fbSetupScreen is defined
> in the very same source file. Funny.

Indeed... Looks like fbSetupScreen is the unresolved function, or is there an
earlier warning about unresolved symbols?


Michel


--
Columbus had a fourth ship. It sailed over the edge.
______________________________________________________________________________
Michel Dänzer                             ///           mdaenzer@earthling.net
                                     __  /// 	     AmigaOS/Linux(Debian/PPC)
Student of computer science at the   \\\///   Team *AMIGA*      ICQ #: 5675698
Swiss Federal Institute of Technology \\\/   AUGS member #163      IRC: CoOpER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
