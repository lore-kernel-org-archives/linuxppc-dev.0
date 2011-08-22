Return-Path: <ivan.djelic@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id DD312B6F68
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 01:35:52 +1000 (EST)
Date: Mon, 22 Aug 2011 17:25:30 +0200
From: Ivan Djelic <ivan.djelic@parrot.com>
To: Scott Wood <scottwood@freescale.com>, LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
Message-ID: <20110822152530.GA16794@parrot.com>
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1314010719.2644.114.camel@sauron>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, LiuShuo <b35362@freescale.com>,
	Matthieu Castet <matthieu.castet@parrot.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2011 at 11:58:33AM +0100, Artem Bityutskiy wrote:
> On Fri, 2011-08-19 at 13:10 -0500, Scott Wood wrote:
> > On 08/19/2011 03:57 AM, Matthieu CASTET wrote:
> > > LiuShuo a écrit :
> > >> ??? 2011???08???19??? 01:00, Matthieu CASTET ??????:
> > >>> b35362@freescale.com a écrit :
> > >>>> From: Liu Shuo<b35362@freescale.com>
> > >>>>
> > >>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
> > >>>> to support the Nand flash chip whose page size is larger than 2K bytes,
> > >>>> we divide a page into multi-2K pages for MTD layer driver. In that case,
> > >>>> we force to set the page size to 2K bytes. We convert the page address of
> > >>>> MTD layer driver to a real page address in flash chips and a column index
> > >>>> in fsl_elbc driver. We can issue any column address by UA instruction of
> > >>>> elbc controller.
> > >>>>
> > >>> Why do you need to do that ?
> > >>>
> > >>> When mtd send you a 4k page, why can't you write it by 2*2k pages write ?
> > >> 1. It's easy to implement.
> > >> 2. We don't need to move the data in buffer more times, because we
> > >> want to use the HW_ECC.
> > >>
> > >> In flash chip per Page:
> > >> ----------------------------------------------------------------
> > >> | first data | first oob | second data | second oob |
> > >> ----------------------------------------------------------------
> > > How the bad block marker are handled with this remapping ?
> > 
> > It has to be migrated prior to first use (this needs to be documented,
> > and ideally a U-Boot command provided do do this), or else special
> > handling would be needed when building the BBT.  The only way around
> > this would be to do ECC in software, and do the buffering needed to let
> > MTD treat it as a 4K chip.

Did you take into account the fact that because MTD thinks this a 2K chip,
you will have to wait twice for the nand busy read time (typically 25 us) per
each 4K read. In other words, to read 4 kBytes you will do:

1. send read0 (00), send address, send read1 (30)
2. wait tRB
3. transfer 2 kBytes
4. send read0 (00), send address, send read1 (30)
5. wait tRB
6. transfer 2 kBytes

Same problem for writes (but rather 100 us instead of 25 us).

How does that compare with hw ecc gain in terms of performance ?

--
Best Regards,

Ivan
