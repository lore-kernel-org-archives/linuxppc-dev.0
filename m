Date: Fri, 2 Apr 2004 11:57:00 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Colin LEROY <colin@colino.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	benh@kernel.crashing.org
Subject: Re: PREEMPT problems
Message-ID: <20040402095700.GB1047@halley.zuhause>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
Mime-Version: 1.0
In-Reply-To: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

On Thu, Apr 01, 2004 at 04:32:18PM +0200, Colin LEROY wrote:
>
> This won't be really helpful, as I have no time to investigate, but I
> seem to have problems with preempt (and latest main-tree BK). After
> a few hours of uptime, I get hanging processes (sed, cvs (can't be
> network related as the CVSROOT is local)) and gcc segfaults while
> compiling kernel.
>
> Maybe it's not completely fixed yet...

Hm, are you sure this is related to PREEMPT? I got this acouple of days
(30 Mar 2004) ago, when I tried to rcompile inkscape, a package I
maintain for debian.
I compiled the package and the recompiled in a chroot, to check
dependencies. sed crashed two times, attaching gdb to told me it was in
glibc-calls. To verify I compiled the same code out of the chroot and
got

if powerpc-linux-g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I.. -I../../src
-DINKSCAPE_ICONS_DIR=\""/usr/share/inkscape"\"
-DINKSCAPE_PIXMAPDIR=\""/usr/share/inkscape"\" -I/usr/include/gtk-2.0
-I/usr/lib/gtk-2.0/include -I/usr/include/atk-1.0
-I/usr/include/pango-1.0 -I/usr/include/freetype2 -I/usr/X11R6/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
-I/usr/include/libart-2.0 -I/usr/include/libxml2
-I/usr/lib/sigc++-1.2/include -I/usr/include/sigc++-1.2      -Wall -W
-Wpointer-arith -Wcast-align -Wsign-compare -Woverloaded-virtual
-Wswitch -Wstrict-prototypes -Wno-unused-parameter -g -O2 -MT
dialog-events.o -Molekular-Dynamik -MP -MF ".deps/dialog-events.Tpo" \
-c -o dialog-events.o `test -f 'dialog-events.cpp' || echo
'./'`dialog-events.cpp; \
then mv -f ".deps/dialog-events.Tpo" ".deps/dialog-events.Po"; \
else rm -f ".deps/dialog-events.Tpo"; exit 1; \
fi
/tmp/ccmgySoN.s: Assembler messages:
/tmp/ccmgySoN.s:17161: Error: value of 40696f11000a3ab8 too large for
field of 4 bytes at 0000000000007be8
make[4]: *** [dialog-events.o] Error 1
make[4]: Leaving directory
`/usr/local/src/packages/inkscape/temp/inkscape-0.37/src/dialogs'
make[3]: *** [all-recursive] Error 1
make[3]: Leaving directory
`/usr/local/src/packages/inkscape/temp/inkscape-0.37/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory
`/usr/local/src/packages/inkscape/temp/inkscape-0.37'
make[1]: *** [all] Error 2
make[1]: Leaving directory
`/usr/local/src/packages/inkscape/temp/inkscape-0.37'
make: *** [build-stamp] Error 2

I had no explanation for this, except the update I did shortly before.
But IIRC I did not get an update of gcc or glibc. Later I went home and
recompiled there (same machine, PB 12", 1Ghz) and all was well. I didn't
have problems since then. Wierd.
My Kernel is still 2.4.24-ben1.

Best regards,

Wolfi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
