Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A30AFDDEBC
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:15:18 +1000 (EST)
Message-ID: <468ACA6F.5010107@freescale.com>
Date: Tue, 03 Jul 2007 17:15:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
References: <468ABF4A.60001@freescale.com>
	<513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
In-Reply-To: <513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> Huh?  Are you saying things are matching on substrings?
> That's even more wrong!

Yes, unfortunately.  I tried getting the BRG frequency from the fsl,cpm 
node and I got the fsl,cpm-enet node instead. :-P

ucc_geth requires device_type == network to avoid matching ucc_geth phy.

>> Does anything actually rely on this behavior?
> 
> 
> Yeah I'm pretty sure some things do.  Those are bugs that
> need fixing.  My plan was to print a big fat warning whenever
> a case-insensitive match wouldn't match when following the
> rules; I never got around to actually implementing that though.
> Maybe some day ;-)

How about a CONFIG_NOT_BROKEN_DEVICE_TREE that disables this and other 
legacy stuff?  If unset, warnings will be printed whenever broken things 
are detected.  Boards which need proper device tree parsing can select 
the config option.

I'd prefer the other way around (CONFIG_BROKEN_DEVICE_TREE), but it'd 
need to default y at first, and kconfig has no unselect command that I 
can see...

-Scott
