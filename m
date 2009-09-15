Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10235B8377
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:44:18 +1000 (EST)
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090915153220.GG12372@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 07:44:07 +1000
Message-Id: <1253051047.8375.232.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-15 at 11:32 -0400, Josh Boyer wrote:
> On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
> >One of the guys here was getting a messed up console on a bamboo board
> >(on linux boot), which he traced to the fact that the default dts has a
> >9600 baudrate coded into it (board was running 115k2, not 9600).  Either
> >deleting the line, or replacing the 9600 with zero fixed the problem.
> 
> Once booted, was there a valid current-speed property in /proc/device-tree
> for the serial node?  I'm curious if U-Boot created it, or if the kernel
> just used whatever baud was present already.
> 
> When I did the bamboo port a while ago, I recall having issues with either
> a missing clock-frequency or current-speed (or both perhaps) and the bootloader
> on the board was the original PIBS.  It might have been an issue with PIBS
> but I'm guessing the rest of the 4xx boards copied from either Ebony or
> Bamboo in their ports and hence contain that property.

I think I recently added code to legacy_serial probe the speed from the
HW if the property is absent, which should help.

Cheers,
Ben.
