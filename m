Date: Thu, 4 Dec 2003 09:03:00 -0500 (EST)
From: "Verberk, Bep" <verberk@nortelnetworks.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtdcr and mfdcr macros
In-Reply-To: <20031203200257.GA30768@gate.ebshome.net>
Message-ID: <Pine.LNX.4.44.0312040902050.3113-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ah yes, I see what you're saying. That is a bummer.

Thanks.
Bep

On Wed, 3 Dec 2003, Eugene Surovegin wrote:
>
> On Wed, Dec 03, 2003 at 10:25:18AM -0500, Verberk, Bep wrote:
> >
> > I'd like a sanity check on a change I am considering to these
> > macros....
> >
> > I had some difficulty executing these macros (found in
> > include/asm/processor.h) in a loop, eg:
> >
> > #define DMA0_BANKS 	4
> > #define DCRN_DMA0_BASE	0x100
> > #define DCRN_DMA0_CR(bank)  (DCRN_DMA0_BASE + (8 * (bank)))
> >
> > 		for(i=0;i<DMA0_BANKS;i++){
> > 			dma0_cr = mfdcr(DCRN_DMA0_CR(i));
> > 			CLEARBITS(dma0_cr, DMA0_CR_PCE);
> > 			mtdcr(DCRN_DMA0_CR(i), dma0_cr);
> > 		};
>
> You cannot use mtdcr/mfdcr with DCR number changed on run-time. These
> instructions encode DCR number in their body (look at the instruction
> format in any 4xx manual).
>
> And, yes this is major PITA.
>
> The only way (I know) to use dynamic DCR numbers is to have a table
> with mfdcr/mtdcr instructions for every possible DCR number and jump
> on the correct one depending on supplied DCR number.

--
Bep Verberk
verberk@nortelnetworks.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
