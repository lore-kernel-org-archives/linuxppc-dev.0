Date: Thu, 3 Jun 2004 09:04:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Matt Porter <mporter@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: new dma API questions
Message-ID: <20040603090421.A7347@home.com>
References: <40BEEA15.3070505@intracom.gr> <20040603154624.GM15195@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040603154624.GM15195@smtp.west.cox.net>; from trini@kernel.crashing.org on Thu, Jun 03, 2004 at 08:46:24AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 03, 2004 at 08:46:24AM -0700, Tom Rini wrote:
> On Thu, Jun 03, 2004 at 12:06:29PM +0300, Pantelis Antoniou wrote:
>
> > Hi there.
> >
> > I have a few questions regarding the new DMA API.
> [snip]
> > 3. The first argument is dma_* function is a struct device.
> >   When working with network devices I must set this to NULL.
> >   Granted this is no problem right now, but could this be
> >   a problem in the future?
>
> It could be a problem in the future, but probably not until cpm1/cpm2
> stuff uses OCP bits, which would have a dev entry to pass in (AFAIK,
> there aren't plans to make use of dev yet, so...).

To further clarify, it just happens that DMA API has to allow for that
parameter since several architectures need to be able to perform
operations based on the "bus type" which can be derived from the
struct device argument.  It just happens that we don't need to do
that on ppc32.  However!...I've been enlightened to a case on
Marvell 64x60 where it would be desirable to use the "non-coherent"
implementation on the on-chip peripherals that don't have snooping
and then use the "coherent" implementation on the PCI bus. That
would require additional reorg work and it's not clear yet how the
64x60 folks want to handle the situation.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
