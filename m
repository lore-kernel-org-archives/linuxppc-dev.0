Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57BFADDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:13:21 +1000 (EST)
Date: Thu, 30 Aug 2007 15:13:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/9] cpm2: Fix off-by-one error in setbrg().
Message-ID: <20070830201311.GA5144@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201921.GB24329@ld0162-tx32.am.freescale.net>
	<20070830020907.59052c67@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830020907.59052c67@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 02:09:07AM +0400, Vitaly Bordug wrote:
> On Tue, 28 Aug 2007 15:19:21 -0500
> Scott Wood wrote:
> 
> > The hardware adds one to the BRG value to get the divider, so it must
> > be subtracted by software.
> 
> Prolly a note why it used to work, or what exactly this is resulting in
> the code. IIRC this was just fw-ported so arch/ppc should have this as
> well.

It *didn't* work before -- hence the fix.

The failure mode from being off by just one isn't total nonfunctionality,
but rather a corrupted character now and then, which could explain why it
wasn't fixed before.

As for arch/ppc, I'm just trying to not break it more than it already is.

-Scott
