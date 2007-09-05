Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F247EDDFEE
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 08:23:19 +1000 (EST)
Date: Wed, 5 Sep 2007 17:23:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070905222310.GA11433@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
	<CF1B6B97-44FA-4002-9030-3C1A20F2F2F4@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CF1B6B97-44FA-4002-9030-3C1A20F2F2F4@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 03:08:28PM -0700, Dan Malek wrote:
> All of this worked in 2.4, many changes were part
> of the evolution in 2.6...  configurable pinned entries,
> large page sizes, variations, I didn't keep track of
> all of this.  I just assumed I'd have to fix it all if I
> ever needed to use it, which I haven't.  The original
> version of 8xx could wire exactly three entries for
> 8M text, 8M data, and 8M IMMR plus upper device
> addresses.  We would set the IMMR to ff800000,
> cover the CPM, some other devices and the flash
> at the top of memory.

The IMMRs I've seen from the bootloader are ff000000 (Freescale boards)
and fa200000 (Embedded Planet).  AFAICT, the number of fixed TLB entries
is fixed at 4 on these chips, so using the fourth for flash wouldn't take
away any general-purpose TLB entries.

> >I didn't change it on a whim, I changed it because ioremap() wasn't
> >working the way it currently is.
> 
> This processor is severely resource limited.  It's
> far better to fix ioremap and take advantage of this
> performance enhancement than to further
> cripple it.  Just like other processors test for
> mapping by BATs or CAMs, the 8xx and
> probably 4xx should test for wired mapping.

I certainly agree that it would be nice to check -- my immediate goal is
to get things working, though.

-Scott
