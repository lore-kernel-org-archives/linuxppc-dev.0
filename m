Message-ID: <38D1D864.B98EEBA2@redhat.com>
Date: Fri, 17 Mar 2000 02:01:56 -0500
From: Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need reports about PCI I/O conflicts
References: <20000303115513.005167@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> On Fri, Mar 3, 2000, Doug Ledford <dledford@redhat.com> wrote:
>
> >The driver wants to see a valid IO region in the config registers or else it
> >interprets the card as disabled.  It also wants to see a unique value on each
> >card or else it interprets everything but the first instance as duplicates of
> >the first and ignores them (certain PCI busses have resulted in devices being
> >in the list multiple times, and certain BIOSes use setting the IO space to 0
> >to signal a card that is disabled in the BIOS).  The driver already
> knows that
> >on PPC it needs to use MMAP I/O registers, so there isn't any hints needed
> >from the OF, and those hints only complicate matters further when trying to
> >keep the driver uniform across multiple architectures.  If this is going
> to be
> >an ongoing problem, then I can make changes to the driver, it just means
> >having a few more #ifdef(__powerpc__) type stuff (ick).
>
> In our case, I beleive we need to change the driver so that it ignores
> the PIO addresses when they have not been assigned and there's a valid
> MMIO address. I'll look at the driver again but I beleive the only place
> where it can be a problem is the code that detects multiple instances of
> the card. We can probably safely disable that code on all PPCs, or
> eventually make it use MMIO when PIO are not available.
>
> I'll see what I can do on my side but I don't have an Adaptec card to
> test with.

I've made changes to the driver to make this work.  However, it does not
compensate for multiple cards that have the same PIO address in the pdev
struct.  That is as much a PPC PCI code bug as anything, and not something I
care to work around.  It will use MMAPed I/O on PPC and if no PIO is available
and MMAP I/O isn't working then it skips the controller.  It also won't detect
multiple instances of a card if the base address (with the PIO bit masked out)
is 0 (at least not based on PIO address, but it will still detect multiple
cards with the same MMAP I/O address).  That should solve the problem as long
as the PCI code is fixed so it doesn't put out multiple cards with the same
PIO address any more.

--

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
