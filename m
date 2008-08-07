Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6897DDECF
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 02:45:21 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m77GjFxi002574
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 09:45:15 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m77GjESd026072
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 11:45:14 -0500 (CDT)
Date: Thu, 7 Aug 2008 11:45:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Message-ID: <20080807164513.GA22176@ld0162-tx32.am.freescale.net>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<1218061585.24157.246.camel@pasglop>
	<fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
Cc: paulus@samba.org, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 05:11:08PM -0600, Grant Likely wrote:
> I do this particular test to make absolute sure that the caller
> absolutely understands the limitations of the block mapping.  If they
> call this with something that isn't 128k aligned, then I make it fail
> immediately so the coder is forced to go and understand what they are
> allowed to do.  Basically, I'm reinforcing the fact that this is not
> the same as ioremap().
> 
> I haven't decided yet if I should test size in the same way.  Thoughts?

I'd prefer it round up the size as needed to cover the requested mapping
and needed alignment.

The minimum size is going to be different on Book E, for example, and I
can think of at least one user that will be shared between Book E and
classic (CPM2 early console).

-Scott
