From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Andrew Sharp <andy@netfall.com>, khendricks@ivey.uwo.ca
Subject: Re: Bug#86356: analog: analog segfaults
Date: Fri, 23 Feb 2001 18:30:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
Cc: Stephen Turner <sret1@cam.ac.uk>,
	Stephen Turner <S.R.E.Turner@statslab.cam.ac.uk>,
	"Marco d'Itri" <md@Linux.IT>, Michel Lanners <mlan@cpu.lu>,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.3.96.1010223202924.7649A-100000@gamma.statslab.cam.ac.uk> <01022316292300.06063@localhost> <3A96DFF2.9737747C@netfall.com>
In-Reply-To: <3A96DFF2.9737747C@netfall.com>
MIME-Version: 1.0
Message-Id: <01022318305301.06077@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Regardless of the interface or code, the compiler should be able to handle
this case properly.  I agree simpler is better but I am more interested in
making sure this bug is fixed in gcc if it hasn't already been.

 If not, I personally want to see it fixed since the code I wrote for
sys_invokeNative in the JDK and the openoffice bridges code and the Mozilla
code, and the libffi code, and ... are wrong and need to be changed since
they all follow the published abi.

Kevin

On Friday 23 February 2001 17:10, Andrew Sharp wrote:
> One look at that interface to printtree is all that is needed to see
> where the real problem is.  Whoever wrote this code is badly in need
> of a long and meaningful "timeout" with _The Elements of Programming
> Style_ by Kernighan & Plauger.  KISS.  Geez, build a structure and
> pass the pointer, rather than the much slower [and apparently
> bugier, and painful to read] method of trying to force the compiler
> and arg passing code to deal with that mountain of ....
>
> a
>
> "Kevin B. Hendricks" wrote:
> >
> > Hi,
> >
> > I think the second double value is confusing the compiler into skipping a
> > stack slot when it really shouldn't be doing that at all!!!!!
> >
> > This is wierd.
> >
> > Here is a quick and dirty way to test.  Move both double parameters to the
> > beginning of the function and caller and the problem should go away.
> >
> > Another solution is to include a "dummy" int variable in both the caller
> > and the function right before the double parameter "unit".  That dummy
will
> > fill a stack slot and force any messed up double alignment issue to become
> > moot.
> >
> > If either of those workarounds work, then please pass all of this info to
> > Franz Sirl's attention on the gcc@gcc.gnu.org site and he can use it to
> > track down the messed up code. It the workarounds fix things, this is a
> > definite bug
> >
> > Okay, here is what should be where:
> >
> > gpr registers
> > r3   outf
> > r4   rep
> > r5   outstyle
> > r6   multibyte
> > r7   tree
> > r8   requests
> > r9   date
> > r10  badp
> >
> > floating point registers
> > f1  totb
> > f2  unit
> > f3
> > f4
> > f5
> > f6
> > f7
> > f8
> >
> > overflow stack (starts aligned to 8 at the previous frame pointer + 8
> > offset  0: badn
> > offset  4: level
> > offset  8: partname
> > offset  c: aliashead
> > offset 10: linkhead
> > offset 14: baseurl
> > offset 18: totr
> > offset 1c: totp
> > offset 20: width
> > offset 24: possrightalign
> > offset 28: bmult
> >  <================== (if passed on the stack the double would have
> >                       been here but there were enough floating point
> >                       registers so it should not be on the stack.)
> >                       (However, if it was on the stack, the compiler
should
> >                        have skipped a stack slot since doubles must be
> >                        passed aligned to 8)
> > offset 2c: sepchar
> > offset 30: rsepchar
> > offset 34: decpt
> > offset 38: compsep
> > offset 3c: rawbytes
> > offset 40: cols
> > offset 44: colhead
> > offset 48: colheadp
> > offset 4c: gender
> > offset 50: html
> > offset 54: monthname
> > offset 58: dayname
> > offset 5c: monthlen
> > offset 60: daylen
> > offset 64: plainmonthend
> > offset 68: plaindaylen
> > offset 6c: lngstr
> >
> > Please let me know if the workaround  "fixes" things.  We will then have a
> > bug.
> >
> > Thanks,
> >
> > Kevin
> >
> > On Friday 23 February 2001 15:46, Stephen Turner wrote:
> > > Thanks for your help with this, Kevin (I'm the upstream author).
> > >
> > > > To see if it is indeed a parameter passing issue, I need to know what
the
> > > > types are for each parameter passed below (specifically if any are
long
> > > > long int or float or double types and what the return type is of that
> > > > function so that I can tell is any structures are returned.
> > > >
> > >
> > > The definition:
> > >
> > > typedef unsigned char logical;
> > > typedef signed char choice;
> > > /* and Strlist, Alias, Include are typedefs to structs */
> > > void printtree(FILE *outf, choice rep, choice outstyle, logical
multibyte,
> > >        Hashtable *tree, choice requests, choice date, Hashentry *badp,
> > >        unsigned long badn, unsigned int level, Strlist *partname,
> > >        Alias *aliashead, Include *linkhead, char *baseurl,
> > >        unsigned long totr, unsigned long totp, double totb,
> > >        unsigned int width[], logical possrightalign,
> > >        unsigned int bmult, double unit, char sepchar, char repsepchar,
> > >        char decpt, char *compsep, logical rawbytes, choice *cols,
> > >        char *colhead, char *colheadp, char gender, logical *html,
> > >        char **monthname, char **dayname, unsigned int monthlen,
> > >        unsigned int daylen, unsigned int plainmonthlen,
> > >        unsigned int plaindaylen, char **lngstr) {
> > >
> > > The call:
> > >
> > > printtree(outf, rep, outstyle, multibyte, tree, requests, date, badp,
badn,
> > >     0, NULL, aliashead, linkhead, baseurl, totr, totp, totb, width,
> > >     possrightalign, bmult, unit, sepchar, repsepchar, decpt, compsep,
> > >     rawbytes, cols, colhead, colheadp, gender, html, monthname,
> > >     dayname, monthlen, daylen, plainmonthlen, plaindaylen, lngstr);
> > >
> > > I've double-checked that all arguments in the call have the correct
types.
> > >
> > > However, notice that printtree() has 38 arguments. The C standard
(Section
> > > 5.2.4.1) only requires implementations to accept 31 arguments. Does gcc
have
> > > this limit?
> > >
> > > > Another (easier solution) is to modify each routine to print the
values
> > of
> > > > all parameters just before the call and just inside the called
routine.
> > >
> > > I've done this. fprintf'ing the values of all the parameters immediately
> > > before the call and immediately on entry to the function gives:
> > >
> > > BEFORE:
> > > 0x100f3f48 9 0 0 0x1007f550 0 4 0xffe859c
> > > 268919984 0 (nil) (nil) 0x100e8498 (nil)
> > > 1 0 88140.000000 0x7ffff8f8 0 0
> > > 1.000000 44 0 46 0x1007e498 0 0x100654de
> > > 0x100e9eb8 0x100e9ec8 n 0x1006543f 0x1006592c 0x10065910
> > > 3 3 3 3 0x100e98b0
> > >
> > > AFTER:
> > > 0x100f3f48 9 0 0 0x1007f550 0 4 0xffe859c
> > > 268919984 0 (nil) (nil) 0x100e8498 (nil)
> > > 1 0 88140.000000 0x7ffff8f8 0 0
> > > 1.000000 0 46 152 (nil) 222 0x100e9eb8
> > > 0x100e9ec8 0x6e ? 0x1006592c 0x10065910 0x3
> > > 3 3 3 269392048 0x100f3f48
> > > Segmentation fault
> > >
> > > Notice how the second half of the arguments appear to have been shifted
up
> > > one. Compare with the same code on an i386/potato machine:
> > >
> > > BEFORE:
> > > 0x8115a80 9 0 0 0x80a1260 0 4 0x80980b0
> > > 1 0 (nil) (nil) 0x8109fc8 (nil)
> > > 1 0 88140.000000 0xbffff884 0 1
> > > 1.000000 44 0 46 0x80a01a8 0 0x808711e
> > > 0x810b9f0 0x810ba00 n 0x808707f 0x80874b0 0x8087494
> > > 3 3 3 3 0x810b318
> > >
> > > AFTER:
> > > 0x8115a80 9 0 0 0x80a1260 0 4 0x80980b0
> > > 1 0 (nil) (nil) 0x8109fc8 (nil)
> > > 1 0 88140.000000 0xbffff884 0 1
> > > 1.000000 44 0 46 0x80a01a8 0 0x808711e
> > > 0x810b9f0 0x810ba00 n 0x808707f 0x80874b0 0x8087494
> > > 3 3 3 3 0x810b318

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
