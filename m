From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Michel Lanners <mlan@cpu.lu>, md@linux.it
Subject: Re: [S.R.E.Turner@statslab.cam.ac.uk: Re: Bug#86356: analog: analog segfaults]
Date: Fri, 23 Feb 2001 11:05:45 -0500
Content-Type: text/plain;
  charset="us-ascii"
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
References: <200102220655.HAA00821@piglet.grunz.lu>
In-Reply-To: <200102220655.HAA00821@piglet.grunz.lu>
MIME-Version: 1.0
Message-Id: <01022311054500.05125@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Most of the bugs in passing parameters have been fixed by the 2.95.3 series
Franz Sirl has created.

To see if it is indeed a parameter passing issue, I need to know what the
types are for each parameter passed below (specifically if any are long long
int or float or double types and what the return type is of that function so
that I can tell is any structures are returned.

With that info, I can tell you which registers should have which values on
entry to printtree, and what the contents of the overflow stack should look
like.

You can then set a breakpoint just inside the printtree frame and do an info
registers and an x/30x on the previous frames stack pointer (where the
outgoing overflow parameters are actually stored) to check the remaining
parameters.

Another (easier solution) is to modify each routine to print the values of
all parameters just before the call and just inside the called routine.

That will tell you if gcc miscompiled anything.

Kevin


On Thursday 22 February 2001 01:55, Michel Lanners wrote:
> [cross-posted to linuxppc-dev]
>
> On  20 Feb, this message from md@linux.it echoed through cyberspace:
> > Background: analog segfaults when using a custom config file.
> > The author tried debugging the program on my B50 and replied with this
> > message.
> > Is gcc known to be buggy for powerpc? I'm running 2.95.2-17 and the
> > program has been compiled without optimizations.
>
> No idea whether it _is_ buggy or not. However, the list of arguments to
> that function below seems rather long to me, so if it is a bug in gcc,
> it might not have been noticed before.
>
> Anyway, one thing to look at might be the fact that not all function
> arguments are passed the same way according to the ABI we are using. The
> first few are passed in registers, the rest on the stack (IIRC).
> However, I don't know exactly how many are passed in registers. But it
> would seem that 22 (the arguments coming through OK below) is a bit high
> a number...
>
> Any of the gcc gurus around?
>
> Michel
>
> > ----- Forwarded message from Stephen Turner
<S.R.E.Turner@statslab.cam.ac.uk> -----
> >
> > OK, I've discovered what's going on, but I have no idea WHY it's going on.
> >
> > The problem comes at line 736 of output.c. That line calls printtree, as
> > follows:
> >
> > printtree(outf, rep, outstyle, multibyte, tree, requests, date, badp,
badn,
> >           0, NULL, aliashead, linkhead, baseurl, totr, totp, totb, width,
> >           possrightalign, bmult, unit, sepchar, repsepchar, decpt,
compsep,
> >           rawbytes, cols, colhead, colheadp, gender, html, monthname,
> >           dayname, monthlen, daylen, plainmonthlen, plaindaylen, lngstr);
> >
> > But by the time we reach printtree, several of the values are wrong.
> > Everything is fine up to unit. But sepchar got repsepchar's true value
(0),
> > repsepchar got decpt's true value ('.'), etc., until plaindaylen got
> > lngstr's value (0x100e93c0 = 269390784) and lngstr got a random value.
> >
> > As I say, I don't really see how this can have happened. Have you
> > encountered anything like this before?
> >
> > ----- End forwarded message -----
>
>
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
