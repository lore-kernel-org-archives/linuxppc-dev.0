From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 24 Aug 2004 09:10:10 -0700
To: Andrey Volkov <avolkov@varma-el.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] Re: BestComm and fec
Message-ID: <20040824161010.GA9379@zenos.farnsworth.org>
References: <412A4B69.7000305@246tNt.com> <149461203.20040824120707@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149461203.20040824120707@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 24, 2004 at 08:07:07AM +0000, Andrey Volkov wrote:
>
> Hi all,
>
> > Andrey: Gabor has a working fec.c implementation.
>
> > Apparently, you've both worked out a version of bestcomm for 2.6. But
> > you both based it on old code. (even non GPL).
>
> Terrible, may be its time to create special project for MPC5200 (if it
> doesn't exist in somewhere in I-net)? First intention - sourceforge.
> Comments/suggestions?

Yes, useless duplication of work is sad, especially if it is using
obsolete code.  However, the use of special source tree for MPC5200
is neither necessary nor sufficient to avoid that.  It could have been
avoided by talking with Sylvain or me.  I have learned that it
is almost essential to discuss linux ppc development on #mklinux
on IRC.

BTW, the code you ported looks like an early development version that
I never intended for distribution.  Motorola begged me to let them use
it for a "demo", then distributed it without notifying me.

> Sylvain, Wolfgang I know you already have projects. But in case of
> Sylvain, as I understand, his project on his homepage.
> In case of Wolfgang, I'm not sure that DENX will happy to share their
> internal CVS with all I-net for write access. Am I right?

Write access is overrated and not necessary, particularly with
bitkeeper's ability to pull changesets from other trees.  Sylvain
and I have each maintainend our own list of patches pending to the
official trees, and have shared those patches back and forth.

However, with more than 2 active developers, it may be useful to have
a temporary tree in which pending support for the various mpc5200
peripherals is coalesced.  If so, I think it makes sense for Sylvain
to do that if he's willing, since he's the mpc5200 maintainer.

> > I've just tried just taking the newer one and stick it in 2.6 with the
> > fec Gabor sent, but it just crashes so it need more work ;) Dale
> > Farnsworth just said it'll look into it and porting new bestcomm as well.
>
> My fec port work ok.

It may appear to work, but from previous discussions here and on
linuxppc-devel, the fec and bestcomm code is not good enough to be
accepted into the main linux trees.  The BestComm API code, in
particular, is hopeless and a complete rewrite will be required.

I'm addressing that now.  I have separated out fec code that interfaces
to the BestComm API code in preparation for replacement of the BestComm
API code.  I'm now separating out and cleaning up the PHY support code.
Next, I plan to replace the BestComm API code, but I may hand that back
to Sylvain if he's available and willing.

Anyway, the fec code will be a lot cleaner in a couple of weeks.
I guarantee I'll post something before then.

> > To resume the "close" future I'm planning :
>
> > I'm busy for two weeks ( I was planning on finishing other stuff earlier
> > and didn't work out finally ;( ). So I work less on the MPC but after
> > that, that's a full time assignment.
>
> >  - USB: Dale's patch are on their way to the official kernel. Once they
> > are in, He or I will send the necessary MPC5200 dependent stuff.
> >  - PCI: I'm working on that now, just brushing it up then I'll put it on
> > my tree and require testing
> >  - I2C: Waiting Adrian Cox patches to be in official tree ( they are in
> > -mm ), then apply mpc5200 specifics.
> >  - BestComm : Dale (the original fec writing among other things) is
> > adapting the newer bestcommcode and cleaning the fec driver as well.
> >  - IDE: Once  I get PCI in my tree, I'll look at IDE, a DMA-less version
> > at first.
>
> And CAN, RTC, and possible CRC32/16 (if it will fast enough) :).
>
> Best regards,
>  Andrey Volkov

Welcome to the team Andrey.  There is plenty of work to go around.
Check with Sylvain if there's something not being done that you'd
like to take on.

-Dale Farnsworth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
