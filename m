Message-ID: <3C7A99EF.1AF2F99@mvista.com>
Date: Mon, 25 Feb 2002 12:09:19 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 405 DMA api
References: <Pine.LNX.4.33.0202251548350.22001-100000@gra-lx1.iram.es>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Mon, 25 Feb 2002, Benjamin Herrenschmidt wrote:
>
> >
> > >Hello,
> > >
> > >I would like to have the 405 dma share the same dma api as the current
> > >pmac. I propose to make the asm/dma.h _generic_ and move all the power
> > >Mac unique stuff into a seperate file such as "pmac_dma.h".  The dma.h
> > >would then be the gateway for other ppc archs by using "CONFIG_<arch>"
> > >to determine which hearder to pull in.  I made the pmac_pma.h as the
> > >default.  I have tested this on the  walnut and can only compile for the
> > >pmac.  I have included a patch and I  would like some feedback and to
> > >have the pmac_dma verified.
> > >
> > >files:
> > >include/asm-ppc/dma.h <- generic defines and config selection
> > >include/asm-ppc/pmac_dma.h     <- most code from dma.h
> > >include/asm-ppc/ppc405_dma.h <- changed func names
> > >arch/ppc/kernel/ppc405_dma.c <- changes to refect new header scheme
> >
> > Well... except this isn't pmac dma. The pmac has a DBDMA controller
> > which is much different from the legacy DMA controller used here. What
> > you see in this dma.h file is, I bet, prep stuff.
>
> True. It´s the legacy ISA DMA controller which can be found on PreP and
> CHRP, almost always in the PCI-ISA bridge. However these are not all
> created equal: the one in the WinBond 83C553 in my MVME boards, which is
> almost identical to some Intel model (82378ZB), is actually capable of 32
> bit addressing and can do descripto based scatter-gather DMA. However,
> since I never used anything that needed DMA on these boards (the floppy
> actually) I did not bother to improve the dma driver.
>
> Some historical note: the 82378ZB, with its improved DMA engine, is AFAICS
> the only Intel PCI<->ISA bridge with enhanced DMA capabilities. Also AFAIR
> this chip was exactly the one specified in the PreP documentation,
> strangely enough, the 82378 production was stopped and the enhanced DMA
> capability disappeared from all later Intel PCI<->ISA bridge. My 82378ZB
> doc is from March 1996 BTW...
>
>         Regards,
>         Gabriel.


Ok ... thanks for the info.  where do we go from here?  Can it get push
in after a better name is selected?

-- armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
