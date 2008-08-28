Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BA6FDE162
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 05:00:26 +1000 (EST)
Message-ID: <48B6DCFD.4020802@freescale.com>
Date: Thu, 28 Aug 2008 12:14:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: RFC: Could cpm2_clk_setup and cpm2_set_pin be exported ?
References: <200808281757.16903.laurentp@cse-semaphore.com>
	<20080828164142.GB1185@ld0162-tx32.am.freescale.net>
	<200808281907.53607.laurentp@cse-semaphore.com>
In-Reply-To: <200808281907.53607.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> On Thursday 28 August 2008, Scott Wood wrote:
>> On Thu, Aug 28, 2008 at 05:57:13PM +0200, Laurent Pinchart wrote:
>>> I'm facing a situation where I need to call cpm2_clk_setup and 
>>> cpm2_set_pin from a device driver compiled as a module. Before 
>>> submitting a patch to export both functions, I'd like to make
>>> sure there isn't a cleaner way to implement the desired
>>> functionality without calling functions that are supposed to be
>>> used by board setup code.
>> Have you looked at using the GPIO API?
> 
> Yes, but the GPIO API doesn't support dedicated pin usage. Basically
> all I can do is configure a pin as a general purpose input or output,
> and set its level when configured as an output. The GPIO API doesn't
> provide any way to access the PAR and SOR registers.

OK, wasn't sure what it was that you needed to set at runtime.  Are you 
actually switching between dedicated functions dynamically?  Why do you 
need to do this?

> Beside, the GPIO API won't help configuring clock routing.

Why does the clock routing need to change dynamically?

If it turns out this really does need to happen, we can add some locks 
and export the functions, but I'd like to hear more about the use case 
first.

-Scott
