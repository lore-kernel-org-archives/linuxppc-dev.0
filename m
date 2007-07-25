Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 570EADDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 04:39:28 +1000 (EST)
Message-ID: <46A798D8.7020906@freescale.com>
Date: Wed, 25 Jul 2007 13:39:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>
	<46A7941F.2050300@ru.mvista.com>
In-Reply-To: <46A7941F.2050300@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Hello.
> 
> Scott Wood wrote:
> 
>>>    Also, what mmio-ide in the compat properly means in the context of 
>>> ide_platform which is able to handle both port and memory mapped IDE.
> 
> 
>> I/O-space is only valid in the context of PCI, ISA, or similar buses, and
>> the bus-specific reg format indicates whether it's mmio-space or
>> io-space.
> 
>    You could save time on lecturing me (and use it to look on the driver 
> ;-).

Sorry, I misread the question as being a mismatch between the 
capabilities of the device binding and the driver, not about the 
specific compatible name.  Something like "generic-ide" would probably 
be better.

>> What is board specific about a set of standard IDE registers at a given
> 
>    The regisrer mapping used is highly non-standard.

The gap between registers is nonstandard, but that's a fairly common 
type of noncompliance in embedded-land, and probably merits being 
supported in a generic way.  I wouldn't call it "highly" nonstandard.

Is there some other non-standardness that I'm missing?

>    We're already in board specific code, so why the heck not? :-)
> 
>> various ns16550-compatibles out there as well?
> 
>    I never suggested that -- what I did suggest was make of_serial.c 
> recognize certain chip types and register them with 8250 driver.

What would be the advantage of maintaining a list of chips whose only 
difference is register spacing, rather than just using reg-shift and 
being done with it?

-Scott
