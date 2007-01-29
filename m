Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 020C1DDFFA
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 08:22:50 +1100 (EST)
Subject: Re: [PATCH 13/16] ps3: get firmware version
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BE476A.3010407@am.sony.com>
References: <45BAC225.7020209@am.sony.com>
	<200701271230.06534.arnd@arndb.de>  <45BE476A.3010407@am.sony.com>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 08:22:22 +1100
Message-Id: <1170105742.26655.286.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> To make it work, I need to arrange to do 64 bit HV calls from the 32 bit
> wrapper.  I'm not yet entirely sure how to set that up.  Any suggestions
> would be welcome.

You can use the ld and std instructions in 32 bits mode to load / store
full 64 bits registers. So you can define wrappers for the few HV calls
you need that either put all args in an array of 64 bits entries that
your asm wrapper then loads in registers using "ld" (and stores back the
results using std) or you can define proper wrappers per functions that
"turn" the arguments into the right shape for the 64 bits call (a bit
harder since 32 bits will pass 64 bits values as 2 registers, so you'd
have to write them on the stack and load the combined value with ld...)

Ben.
