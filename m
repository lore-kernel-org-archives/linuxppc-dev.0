Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 696C767B19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 08:17:29 +1000 (EST)
In-Reply-To: <20050616164717.GA1915@logos.cnet>
References: <20050616144739.GA1559@logos.cnet>
	<8efaee2824f500e906c2c05526ea3214@embeddededge.com>
	<20050616164717.GA1915@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02dc0da971179e034a4ff9f539bc1d8e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 18:17:21 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: map_page() and pinned TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 12:47 PM, Marcelo Tosatti wrote:

> Well it is expected that mapin_ram() flushes the va for the
> PTE's being created.
>
> That is the only well known occurence of _tlbie() on
> a possibly pinned region.

Crap ... no, it's not.  It's map_page() that does the flush,
which happens on ioremap() as well.  When we pin
entries, we also pin some IO space as well.  We need
to update ioremap() to be smart about pinned entries
like it does BATs and CAMs.  I wonder if we can just
make this a generic test in ioremap().  It doesn't have
to know how the spaces are "pinned", just that they are
and how they are mapped.

> What does MOL stand for?

MacOS on Linux.  I don't think 8xx will run this any
time soon :-)

> If b) is chosen alone, which is what you seem to suggest, we
> will get tons of warnings (or traps) anyway from mapin_ram().

It's from more than just mapin_ram().  As I said, we also
use some of the entries to pin IO space.  We used to pin only
8M of instructions, which is more than sufficient, then various
8M windows of data space.  I think we used to pin 24M of
data and 8M of IMMR (plus anything above that, which could
be flash or other IO).

> So having that said, isnt the correct way out of this to change
> both a) and b)?

We certainly have to implement b) to catch all pinned spaces,
then update accordingly to ensure none of the wired entries
get evicted.

Thanks.


	-- Dan
