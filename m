Date: Tue, 5 Dec 2000 02:39:36 -0500 (EST)
From: Alex Avriette <alex@macachu.yi.org>
Reply-To: alex@cosmo.allay.net
To: linuxppc-dev@lists.linuxppc.org
cc: max@trega.com
Subject: lots of questions (va_list, embedded perl, cvsd, introduction - sort
 of)
In-Reply-To: <200012050600.AAA21723@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.10012050215570.22364-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


first i wanted to give everyone a brief introduction so somebody can tell
me to go away if im in the wrong place. the description on
lists.linuxppc.org says that its for linuxppc developers. well, im a
developer, and i use linuxppc, but im not developing linuxppc. im actively
participating in the development of a couple items. opennap
(opennap.sourceforge.net), which is an opensource napster server. tear
(tear.sourceforge.net), which is a perl script that rips and encodes
cds->mp3's very easily. im also developing a much-less-public foray into
artificial intelligence that covers all the bases (c, perl, lisp, and
bash). somebody tell me to go away if im in the wrong place.

okay, so to the real meat of this post. ive been having some problems with
the opennap server. i find that the va_list functions (primarily v*printf)
are giving me segfaults and data corruption. this, however, is *not*
happening on an x86 bsd machine. i have limited machines to test this on,
so im not quite sure that its glibc, but i have my suspicions. the general
behaviour is thus:

if i have one va_list and i use it twice, with two separate
va_start-va_end clauses, the second one segfaults. i believe this is
because the string in the second clause gets null'ed and strlen()
segfaults. gdb falsely reports soinit.c:59, but i tracked down that issue
on google. :)

i wrote a chassis to reproduce this, and have added it to the bottom of
this message. the actual code which causes problems is here:

void
log (const char *fmt, ...)
{
    va_list ap;

    char buf[1024];

    va_start (ap, fmt); vsnprintf ( buf, 1022, fmt, ap ); va_end (ap);
    va_start (ap, fmt); vprintf ( fmt, ap ); va_end (ap);

    fputc ('\n', stdout);
    fflush (stdout);

    putchan ( "#log", "logd", buf );
}

in the above code, buf is null. furthermore, in the second va_start-end
clause, ap is clobbered. so putchan never has anything to "put." because
the chassis is so thorough, i am adding it to the bottom of the message so
my next question actually gets read. but i would really love it if people
would take it and run it and tell me what they get.

there is an irc server written in perl. its called pircd, and i believe
its available at pircd.sourceforge.net. at any rate, the author makes the
excellent observation "well, if youre going to make a server that is based
on chat and text, what *better* language to write it in than perl?" so,
because this napster server is so string-heavy, i have decided i'd like to
embed perl into it. i have every perl book oreilly makes and a few others.
_advanced_perl_programming_ has two chapters on embedded perl. the most
promising part of it is the Ext::Embed module. my main difficulty here is
that the code in APP is non-object oriented and monolithic. i had amazon
send me a few books, notably the oreilly _make_ book and a book on c++
authoring in gnu. these should help but im looking for some nudges in the
right direction. has anyone on the list used embedded perl?

okay, next question. i want to run cvs. our network is comprised of six
servers at the moment, and i would like my fellow administrators to be
able to sync up my current source tree. i havent found any rpms for cvsd,
and i would preferr a tarball. in fact, i dont have rpm. so a tarball
would be, er, necessary. :) i suppose rsync would work too, but i dont
know about the server-side of that transaction.


sorry to ask so many questions at once. but i trust you all have the
smarts and patience to help (or tell me to go away! heh!).

anyway, here's the chassis for va_list and v*printf (use gcc filename.c -o
filename):

/* begin */
#include <stdarg.h>
#include <stdio.h>

void vsn_test ( const char *fmt, ...)
{
  va_list ap; char buf [1024]; int i;

  va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap ); va_end ( ap );

  for (i = 1; i < 5; i++)
  { printf ( "pass [%d] %s\n", i, buf );
    va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap ); va_end ( ap ); }
}

void v_test ( const char *fmt, ...)
{
  va_list ap; int i;

  for (i = 1; i != 5; i++)
  { printf ( "pass [%d] ", i );
    va_start ( ap, fmt ); vprintf ( fmt, ap ); va_end ( ap ); printf ("\n"); }
}

void vs_test ( const char *fmt, ...)
{
  va_list ap; char buf[1024]; int i;

  for (i = 1; i != 5; i++)
  { printf ("pass [%d] %s\n", i );
    va_start ( ap, fmt ); vsprintf ( buf, fmt, ap ); va_end ( ap ); }
}


void dual_va_test ( const char *fmt, ...)
{
  va_list ap; char buf [1024]; int i;

  for (i = 1; i < 5; i++)
  { va_start ( ap, fmt ); vsnprintf ( buf, 1022, fmt, ap); va_end ( ap ) ;
    printf ( "dual-run pass [%d][vsn] %s\n", i, buf );
    printf ( "dual-run pass [%d][v] ", i);
    va_start ( ap, fmt ); vprintf ( fmt, ap ); va_end ( ap ); printf ("\n"); }
}

void nested_test ( const char *fmt, ...)
{
  va_list ap; char bufa [1024]; char bufb [1024]; int i;

  for (i = 1; i < 5; i++)
  { va_start ( ap, fmt );
    vsnprintf ( bufa, 1022, fmt, ap );
    vsnprintf ( bufb, 1022, fmt, ap );
    va_end ( ap );

    printf ("buffer [a] pass [%d]: %s\n", i, bufa);
    printf ("buffer [b] pass [%d]: %s\n", i, bufb); }
}

void main (void)
{
  int tf = 25;   char string[256] = "somestring";
  vsn_test     ( "int: %d string: %s", tf, string );
  vs_test      ( "int: %d string: %s", tf, string );
  v_test       ( "int: %d string: %s", tf, string );
  dual_va_test ( "int: %d string: %s", tf, string );
  nested_test  ( "int: %d string: %s", tf, string );
}
/* end */

anyhow. thanks everyone.

alex

--
alex avriette [alex@cosmo.allay.net]

"No man who uses EMACS is deserving of love."
	Tom Christiansen <tchrist@perl.com>,
	_Perl Cookbook_, pp. 653


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
