From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Stephen Turner <sret1@cam.ac.uk>,
	Stephen Turner <S.R.E.Turner@statslab.cam.ac.uk>
Subject: Re: Bug#86356: analog: analog segfaults
Date: Fri, 23 Feb 2001 17:44:12 -0500
Content-Type: text/plain;
  charset="US-ASCII"
Cc: "Marco d'Itri" <md@Linux.IT>, Michel Lanners <mlan@cpu.lu>,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.3.96.1010223213706.8247B-100000@gamma.statslab.cam.ac.uk>
In-Reply-To: <Pine.LNX.3.96.1010223213706.8247B-100000@gamma.statslab.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <01022317441200.06077@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a working gcc HEAD build from about 2 weeks ago.  If you send me some
standalone test code, I would be happy to test it.

I also have 2.95.3 too and will test with both.

Just create a main with a call to printtrace and have printtrace print all
the values and just return and I will test it for you.

Take care,

Kevin

On Friday 23 February 2001 16:59, Stephen Turner wrote:
> On Fri, 23 Feb 2001, Kevin B. Hendricks wrote:
> >
> > Here is a quick and dirty way to test.  Move both double parameters to
the
> > beginning of the function and caller and the problem should go away.
> >
> > Another solution is to include a "dummy" int variable in both the caller
> > and the function right before the double parameter "unit".  That dummy
will
> > fill a stack slot and force any messed up double alignment issue to become
> > moot.
> >
>
> The second fix got it past the call to printtree(). Then it crashed when
> calling another function, printcols(), which I fixed with the first fix.
> This allowed it to run without crashing, but the resultant output was
> obviously wrong, with what could have been a related bug.
>
> Anyway, I think this proves that your hypothesis was correct.
>
> > If either of those workarounds work, then please pass all of this info to
> > Franz Sirl's attention on the gcc@gcc.gnu.org site and he can use it to
> > track down the messed up code. It the workarounds fix things, this is a
> > definite bug
> >
>
> You said these were mostly fixed in the 2.95.3 series. The original bug
> filer is using 2.95.2. Should I still file a bug? Or has someone got a
> nightly build or something that they could test it on first, in case it's
> already been fixed?
>
> --
> Stephen Turner               http://www.statslab.cam.ac.uk/~sret1/
>   Statistical Laboratory, Wilberforce Road, Cambridge, CB3 0WB, England
>   "Your account can only be used for a single internet session at any one
>    time and for no more than 24 hours in any one day." (NTL terms of use)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
