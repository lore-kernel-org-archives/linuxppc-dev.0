Return-Path: <mason@postdiluvian.org>
Received: from porklips.postdiluvian.org (postdiluvian.org [128.30.54.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5126FB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 06:26:22 +1100 (EST)
Date: Wed, 8 Dec 2010 14:26:16 -0500
From: Mark Mason <mason@postdiluvian.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208192616.GA24560@postdiluvian.org>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
	<20101208111839.1cf95553@udp111988uds.am.freescale.net>
	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 18:18:39:
> >
> > On Wed, 8 Dec 2010 08:59:49 +0100
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > > >
> > > > On Mon, 6 Dec 2010 22:15:54 -0500
> > > > Mark Mason <mason@postdiluvian.org> wrote:
> > > >
> > > > > A few months ago I ran into some performance problems involving
> > > > > UBI/NAND erases holding other devices off the LBC on an MPC8315.  I
> > > > > found a solution for this, which worked well, at least with the
> > > > > hardware I was working with.  I suspect the same problem affects other
> > > > > PPCs, probably including multicore devices, and maybe other
> > > > > architectures as well.
> > > > >
> > > > > I don't have experience with similar NAND controllers on other
> > > > > devices, so I'd like to explain what I found and see if someone who's
> > > > > more familiar with the family and/or driver can tell if this is
> > > > > useful.
> > > > >
> > > > > The problem cropped up when there was a lot of traffic to the NAND
> > > > > (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> > > > > a video chip that needed constant and prompt attention.
> > > >
> > > > If you attach NAND to the LBC, you should not attach anything else to
> > > > it which is latency-sensitive.
> > >
> > > This "feature" makes the LBC useless to us. Is there some workaround or plan
> > > to address this limitation?
> >
> > Complain to your support or sales contact.
> >
> > I've complained about it in the past, and got a "but pins are a limited
> > resource!" response.  They need to hear that it's a problem from
> > customers.
> 
> Done, lets see what I get in return. I think this problem will be
> a major obstacle for our next generation boards which will be NAND
> based.

It was a big problem, and a big surprise, for me too.  The next
generation of a couple of the chips on the bus have pcie, but those
are noticably more expensive.

Another problem I ran into was that the DMA performance from a
non-incrementing address was abysmal, PIO turned out to be
significantly faster.  I guess internally the bus does an entire
cacheline transfer for every word read from a fixed address, or
something like that.  I was doing DMA from a device that had only six
address bits, it should have been in the middle of the bus with the
bottom address pins not connected, which would have allowed
incrementing address DMA.  The transfer speed wasn't so much of a
problem, but the longer transfers meant that there was that much less
bus bandwidth for the other devices, so we wound up sacrificing CPU to
get more bus bandwidth.
