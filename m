Date: Sat, 29 Jul 2000 16:40:11 +0200
From: Olaf Hering <olh@suse.de>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bogus dmasound.o module (was: Re: 2.4.0-test4 success (Re: affs))
Message-ID: <20000729164011.A11090@suse.de>
Reply-To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <3981DBA6.7203A5B9@student.ethz.ch> <Pine.LNX.4.10.10007291437400.1201-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10007291437400.1201-100000@cassiopeia.home>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 29, Geert Uytterhoeven wrote:

[ ... some patches ... ]

can someone check if the ./include/linux/soundcard.h is correct?
This looks bogus to us:

+178
/*
 * Some big endian/little endian handling macros
 */

#if defined(_AIX) || defined(AIX) || defined(sparc) || defined(HPPA) ||
defined(PPC)
/* Big endian machines */
#  define _PATCHKEY(id) (0xfd00|id)
#  define AFMT_S16_NE AFMT_S16_BE
#else
#  define _PATCHKEY(id) ((id<<8)|0xfd)
#  define AFMT_S16_NE AFMT_S16_LE
#endif


Is PPC really defined? At least (sparc) is wrong and should be
__sparc__. PPC should proably be __powerpc__.
It is from current benh tree.


Gruss Olaf


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
