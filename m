Message-Id: <4.3.2.20010223110456.00bd13e0@falcon.si.com>
Date: Fri, 23 Feb 2001 11:08:58 -0500
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: [S.R.E.Turner@statslab.cam.ac.uk: Re: Bug#86356: analog:
  analog segfaults]
In-Reply-To: <200102220655.HAA00821@piglet.grunz.lu>
References: <20010220160910.B20027@attila.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not a gcc guru either, but what is the function prototype for
printtree()?  The rules for passing parameters vary by what kind of
parameters are passed.  Also, make SURE you have the CORRECT function
prototype for printtree() in the function that calls it.  A classic
problem is not having a function prototype so the caller sets up the
parameters one way but the actual code uses the parameters a different way.

gvb


At 07:55 AM 2/22/01 +0100, Michel Lanners wrote:

>[cross-posted to linuxppc-dev]
>
>On  20 Feb, this message from md@linux.it echoed through cyberspace:
> > Background: analog segfaults when using a custom config file.
> > The author tried debugging the program on my B50 and replied with this
> > message.
> > Is gcc known to be buggy for powerpc? I'm running 2.95.2-17 and the
> > program has been compiled without optimizations.
>
>No idea whether it _is_ buggy or not. However, the list of arguments to
>that function below seems rather long to me, so if it is a bug in gcc,
>it might not have been noticed before.
>
>Anyway, one thing to look at might be the fact that not all function
>arguments are passed the same way according to the ABI we are using. The
>first few are passed in registers, the rest on the stack (IIRC).
>However, I don't know exactly how many are passed in registers. But it
>would seem that 22 (the arguments coming through OK below) is a bit high
>a number...
>
>Any of the gcc gurus around?
>
>Michel
>
> > ----- Forwarded message from Stephen Turner
> <S.R.E.Turner@statslab.cam.ac.uk> -----
> >
> > OK, I've discovered what's going on, but I have no idea WHY it's
> going on.
> >
> > The problem comes at line 736 of output.c. That line calls
> printtree, as
> > follows:
> >
> > printtree(outf, rep, outstyle, multibyte, tree, requests, date,
> badp, badn,
> >           0, NULL, aliashead, linkhead, baseurl, totr, totp, totb,
> width,
> >           possrightalign, bmult, unit, sepchar, repsepchar, decpt,
> compsep,
> >           rawbytes, cols, colhead, colheadp, gender, html, monthname,
> >           dayname, monthlen, daylen, plainmonthlen, plaindaylen,
> lngstr);
> >
> > But by the time we reach printtree, several of the values are wrong.
> > Everything is fine up to unit. But sepchar got repsepchar's true
> value (0),
> > repsepchar got decpt's true value ('.'), etc., until plaindaylen got
> > lngstr's value (0x100e93c0 = 269390784) and lngstr got a random value.
> >
> > As I say, I don't really see how this can have happened. Have you
> > encountered anything like this before?
> >
> > ----- End forwarded message -----
>
>
>-------------------------------------------------------------------------
>Michel Lanners                 |  " Read Philosophy.  Study Art.
>23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
>L-1710 Luxembourg              |
>email   mlan@cpu.lu            |
>http://www.cpu.lu/~mlan        |                     Learn Always. "
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
