Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A15EDDFB9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 13:12:04 +1000 (EST)
Date: Wed, 5 Sep 2007 22:11:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070906031155.GB12955@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
	<20070905205951.GA1047@ld0162-tx32.am.freescale.net>
	<63F66EED-7808-40A3-B63D-AA53664CB1A0@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63F66EED-7808-40A3-B63D-AA53664CB1A0@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 03:27:31PM -0700, Dan Malek wrote:
> On Sep 5, 2007, at 1:59 PM, Scott Wood wrote:
> 
> >BTW, it seems I misremembered what the conflict was -- it's not with
> >ioremap space, but with the default location of the consistent memory
> >pool (at 0xff100000).
> 
> Change the configuration option to move this somewhere
> else, outside of the wired mapping.

Sure, that'd work too -- though then I'd either have to change the
default for all platforms and hope I didn't break any of them, or have
8xx be different for what might amount to be no reason.

Would any platforms have a problem with setting the default to
0xfd000000?  Anything over 0xfe000000 is particularly likely to conflict
with something.

> As I said in the last message, these lower end processors are very
> resource challenged, and we need to clever about the memory mapping and
> use of the TLBs.  This isn't a place to be creating fancy memory maps
> and algorithms to manage them.

Actually, being slightly fancier by dynamically choosing where to place
the consistent memory pool would have avoided this issue.

I agree that not using a pinned TLB entry for the IMMR sucks, and maybe
I'll do something about it later -- just not right now.  This patchset's
been floating for long enough without expanding its scope further.

> Use maximum mappings whenever possible, configure the memory controller
> to pack as much stuff into this single TLB mapping as possible. 
> Something configurable like this memory pool should not be a reason to
> give up these performance enhancements.

Sure.  I still don't think it's that big of a deal when none of the
currently supported boards have anything useful in the 8MB after the
IMMR (and pinning is only used for the debug console anyway), and custom
boards can always use custom TLB mappings, but moving the coherent region
to somewhere a little more polite is something that we should do anyway.

-Scott
