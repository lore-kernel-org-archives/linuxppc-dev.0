Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23963DE009
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 06:53:11 +1000 (EST)
Date: Wed, 5 Sep 2007 15:53:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070905205301.GA807@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 01:36:43PM -0700, Dan Malek wrote:
> 
> On Sep 5, 2007, at 12:27 PM, Scott Wood wrote:
> 
> >1. Only map 512K of the IMMR, rather than 8M, to avoid conflicting  
> >with
> >the default ioremap region.
> 
> The original reason to map 8M was so ioremap()
> could use the same wired TLB rather than allocate
> page table entries.  It should also cover all addresses
> mapped to the flash as well.  This was intentional,
> not a mistake.

"intentional" and "mistake" are not mutually exclusive.

Where is the code that checks for pinned TLB entries on 8xx when doing
ioremap?  Why could this not be done with a 512K mapping?  How was this
even tested, given the obvious wrong-register mistake in the other
CONFIG_PIN_TLB section?  On what do you base the assumption that flash is
within 8MB of the IMMR base?

I didn't change it on a whim, I changed it because ioremap() wasn't
working the way it currently is.

-Scott
