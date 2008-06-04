Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp115.mail.mud.yahoo.com (smtp115.mail.mud.yahoo.com
	[209.191.84.164]) by ozlabs.org (Postfix) with SMTP id 2F93EDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 12:00:26 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:00:10 +1000
References: <1211852026.3286.36.camel@pasglop>
	<20080603213501.GD3549@parisc-linux.org>
	<Pine.LNX.4.64.0806031444590.3242@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0806031444590.3242@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041200.11678.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 June 2008 07:58, Trent Piepho wrote:
> On Tue, 3 Jun 2008, Matthew Wilcox wrote:
> > On Tue, Jun 03, 2008 at 12:57:56PM -0700, Trent Piepho wrote:
> >> On Tue, 3 Jun 2008, Matthew Wilcox wrote:
> >>> On Tue, Jun 03, 2008 at 11:47:00AM -0700, Trent Piepho wrote:
> >>>> On Tue, 3 Jun 2008, Linus Torvalds wrote:
> >>>>> On Tue, 3 Jun 2008, Nick Piggin wrote:
> >>>>>> Linus: on x86, memory operations to wc and wc+ memory are not
> >>>>>> ordered with one another, or operations to other memory types (ie.
> >>>>>> load/load and store/store reordering is allowed). Also, as you know,
> >>>>>> store/load reordering is explicitly allowed as well, which covers
> >>>>>> all memory types. So perhaps it is not quite true to say
> >>>>>> readl/writel is strongly ordered by default even on x86. You would
> >>>>>> have to put in some mfence instructions in them to make it so.
> >>>>
> >>>> So on x86, these could be re-ordered?
> >>>>
> >>>> writel(START_OPERATION, CONTROL_REGISTER);
> >>>> status = readl(STATUS_REGISTER);
> >>>
> >>> You wouldn't ask for write-combining memory mapping for control or
> >>> status registers.
> >>
> >> But Nick said, "store/load reordering is explicitly allowed as well,
> >> which covers *all* memory types."
> >
> > Then Nick is confused.  PCI only defines one way to flush posted writes
> > to a device -- doing a read from it.  There's no way that reads can
> > be allowed to pass writes (unless you've asked for it, like with write
> > combining).
>
> But that requirement is for the PCI bridge, isn't it?  It doesn't matter if
> the bridge will flush all posted writes before allowing a read if the CPU
> decides to give the bridge the read before the write.  A powerpc CPU will
> certainly do this if you don't take any steps like telling it the memory is
> uncachable and guarded.  I didn't think it was allowed on x86 (except with
> WC), but Nick seemed to say it was.

Ah sorry, not UC, I was confused. UC I think actually is strongly ordered
WRT other UC and also cacheable operations.

WC is weakly ordered, anything goes.
