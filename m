Date: Fri, 23 Feb 2001 20:46:30 +0000 (GMT)
From: Stephen Turner <S.R.E.Turner@statslab.cam.ac.uk>
Reply-To: Stephen Turner <sret1@cam.ac.uk>
To: "Marco d'Itri" <md@Linux.IT>
Cc: khendricks@ivey.uwo.ca, Michel Lanners <mlan@cpu.lu>,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug#86356: analog: analog segfaults
In-Reply-To: <20010223195620.F4145@wonderland.linux.it>
Message-ID: <Pine.LNX.3.96.1010223202924.7649A-100000@gamma.statslab.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for your help with this, Kevin (I'm the upstream author).

> To see if it is indeed a parameter passing issue, I need to know what the
> types are for each parameter passed below (specifically if any are long
> long int or float or double types and what the return type is of that
> function so that I can tell is any structures are returned.
>

The definition:

typedef unsigned char logical;
typedef signed char choice;
/* and Strlist, Alias, Include are typedefs to structs */
void printtree(FILE *outf, choice rep, choice outstyle, logical multibyte,
       Hashtable *tree, choice requests, choice date, Hashentry *badp,
       unsigned long badn, unsigned int level, Strlist *partname,
       Alias *aliashead, Include *linkhead, char *baseurl,
       unsigned long totr, unsigned long totp, double totb,
       unsigned int width[], logical possrightalign,
       unsigned int bmult, double unit, char sepchar, char repsepchar,
       char decpt, char *compsep, logical rawbytes, choice *cols,
       char *colhead, char *colheadp, char gender, logical *html,
       char **monthname, char **dayname, unsigned int monthlen,
       unsigned int daylen, unsigned int plainmonthlen,
       unsigned int plaindaylen, char **lngstr) {

The call:

printtree(outf, rep, outstyle, multibyte, tree, requests, date, badp, badn,
    0, NULL, aliashead, linkhead, baseurl, totr, totp, totb, width,
    possrightalign, bmult, unit, sepchar, repsepchar, decpt, compsep,
    rawbytes, cols, colhead, colheadp, gender, html, monthname,
    dayname, monthlen, daylen, plainmonthlen, plaindaylen, lngstr);

I've double-checked that all arguments in the call have the correct types.

However, notice that printtree() has 38 arguments. The C standard (Section
5.2.4.1) only requires implementations to accept 31 arguments. Does gcc have
this limit?

> Another (easier solution) is to modify each routine to print the values of
> all parameters just before the call and just inside the called routine.

I've done this. fprintf'ing the values of all the parameters immediately
before the call and immediately on entry to the function gives:

BEFORE:
0x100f3f48 9 0 0 0x1007f550 0 4 0xffe859c
268919984 0 (nil) (nil) 0x100e8498 (nil)
1 0 88140.000000 0x7ffff8f8 0 0
1.000000 44 0 46 0x1007e498 0 0x100654de
0x100e9eb8 0x100e9ec8 n 0x1006543f 0x1006592c 0x10065910
3 3 3 3 0x100e98b0

AFTER:
0x100f3f48 9 0 0 0x1007f550 0 4 0xffe859c
268919984 0 (nil) (nil) 0x100e8498 (nil)
1 0 88140.000000 0x7ffff8f8 0 0
1.000000 0 46 152 (nil) 222 0x100e9eb8
0x100e9ec8 0x6e ? 0x1006592c 0x10065910 0x3
3 3 3 269392048 0x100f3f48
Segmentation fault

Notice how the second half of the arguments appear to have been shifted up
one. Compare with the same code on an i386/potato machine:

BEFORE:
0x8115a80 9 0 0 0x80a1260 0 4 0x80980b0
1 0 (nil) (nil) 0x8109fc8 (nil)
1 0 88140.000000 0xbffff884 0 1
1.000000 44 0 46 0x80a01a8 0 0x808711e
0x810b9f0 0x810ba00 n 0x808707f 0x80874b0 0x8087494
3 3 3 3 0x810b318

AFTER:
0x8115a80 9 0 0 0x80a1260 0 4 0x80980b0
1 0 (nil) (nil) 0x8109fc8 (nil)
1 0 88140.000000 0xbffff884 0 1
1.000000 44 0 46 0x80a01a8 0 0x808711e
0x810b9f0 0x810ba00 n 0x808707f 0x80874b0 0x8087494
3 3 3 3 0x810b318

Thanks again,

--
Stephen Turner               http://www.statslab.cam.ac.uk/~sret1/
  Statistical Laboratory, Wilberforce Road, Cambridge, CB3 0WB, England
  "Your account can only be used for a single internet session at any one
   time and for no more than 24 hours in any one day." (NTL terms of use)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
