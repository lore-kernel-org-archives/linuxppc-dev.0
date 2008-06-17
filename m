Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id E845CDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 08:18:01 +1000 (EST)
Date: Tue, 17 Jun 2008 23:17:55 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Loading drivers based on board identification
Message-ID: <20080617221754.GA17165@sirena.org.uk>
References: <20080617202656.GA10957@sirena.org.uk>
	<20080617213105.4F96911D8063@mail23-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080617213105.4F96911D8063@mail23-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 02:31:03PM -0700, Stephen Neuendorffer wrote:

> I'm very interested in trying to factor out board data from the device
> tree, but for slightly different reasons, I think.  (Although I don't
> exactly understand what you're proposing...)

Sorry, I should have gone into a *little* more detail about what DMI
information actually is.  DMI provides device management data - you can
see the things that Linux supports in include/linux/dmi.h.  Of most
relevance to what I'm talking about here is information like the board,
chassis and system manufactuer, product name and version though there is
other, more device tree style, information in there.

This information can be queried by drivers to allow them to override
default behaviour based on knowledge about the system in a similar way
to how OpenFirmware but of more relevance here is that it is also
possible for drivers to use the module autoloading infrastructure to
automatically load modules which provide dmi: module aliases (for
example, this is used by the dcdbas driver which interfaces to Dell
system management controllers to automatically load on Dell systems).

> I don't yet have a proposal, but I'd be curious to hear your thoughts.

My proposal would be to essentially clone at least the system
information bit of the DMI API to provide equivalent information.
