From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15363.33009.545085.87868@gargle.gargle.HOWL>
Date: Tue, 27 Nov 2001 23:02:57 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: gratuitous complexity
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was innocently browsing through include/asm-ppc/gt64260.h when I
came across this:

#ifndef	TRUE
#define	TRUE	(0 == 0)
#endif

#ifndef	FALSE
#define	FALSE	(0 != 0)
#endif

I nearly lost my dinner!  It's just not fair to spring something that
awful on people without at least a warning for those with weak
stomachs. :)

Seriously though, it is unnecessarily complex.  If you want to use TRUE
and FALSE, define them as 1 and 0.  The C language standard specifies
that 0 is false and anything non-zero is true.

I also wonder why we need so many functions to access the gt64260 -
there are 19 different functions of the form gt64250*_set_*, which
seems completely over the top to me.  How many of them actually get
used?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
