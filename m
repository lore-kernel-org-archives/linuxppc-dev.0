Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71528B7D81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 20:37:46 +1000 (EST)
Date: Wed, 9 Jun 2010 11:30:47 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
Message-ID: <20100609103046.GC5618@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100609061330.620AC14E867@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 08:13:30AM +0200, Wolfgang Denk wrote:
> In message <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com> you wrote:

> > Would making a change in uboot be a better solution? Eric, can you
> > verify if changing uboot also fixes the problem?

> To me it seems better if the driver itself does what needs to be done
> instead of relying on specific settings that may or may not be done in
> U-Boot. Keep in mind that drivers may be loaded as modules, and that
> we even see cases where the same port serves multiple purposes by
> loading different driver modules (yes, this is not exactly a clever
> idea, but hardware designers come up with such solutions).

I do tend to agree that having the driver be able to cope with things is
a bit more robust - it's not terribly discoverable for users and people
are often justifiably nervous about updating their bootloader.

It might, however, be sensible to make the GPIO based reset be optional
based on having the OF data for the GPIOs.  That way existing DTs will
work without changes and systems that can use the reset implementation
in the controller will be able to do so.
