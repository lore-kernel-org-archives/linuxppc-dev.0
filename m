Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 7AED1DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 00:44:07 +1000 (EST)
Date: Wed, 13 Jun 2007 10:37:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <fa686aa40706130554l36fefa13w4e2b1957a9fc5288@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0706131033480.3467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Jun 2007, Grant Likely wrote:

> On 6/12/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> >
> > Hi,
> >
> >  Grant> Rather than c67x00-hub.c being compiled seperately, the
> >  Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
> >  Grant> This is a very bad idea.

What's so bad about it?  It's an elegant solution to the problem of 
breaking a very long driver up into smaller, more digestible pieces 
without polluting the kernel's namespace with lots of extra global 
symbols.

> >   Simplest solution is to merge the
> >  Grant> two files into one and be done with it.
> >
> > Yeah, it isn't exactly pretty, but it's what the other hcd drivers do,
> > E.G.:
> >
> > % grep -rs "include.*hub.c" *c
> > ehci-hcd.c:#include "ehci-hub.c"
> > ohci-hcd.c:#include "ohci-hub.c"
> > uhci-hcd.c:#include "uhci-hub.c"
> >
> > I don't quite know why they do it like that though ..
> 
> True, but that doesn't mean that it's a good idea to follow the lead.

Why not?

> There are lots of other examples of ugly code in the kernel that is
> tolerated just because nobody has cleaned it up yet, but is still
> unacceptable for new code.

What's so ugly about breaking a driver up into pieces?  Leaving it in 
one giant piece would be much more ugly IMO.

> We know it's an ugly thing to do, and the fix is simple and easy.

As the Firesign Theater once said, Everything you know is wrong!  :-)

Alan Stern
