Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C93CBDDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 04:02:23 +1100 (EST)
Message-ID: <4926E932.8080105@freescale.com>
Date: Fri, 21 Nov 2008 11:00:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<20081120195347.GA29459@ld0162-tx32.am.freescale.net>
	<200811211704.56808.laurentp@cse-semaphore.com>
In-Reply-To: <200811211704.56808.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> On Thursday 20 November 2008, Scott Wood wrote:
>> This makes things worse on mpc8272ads -- the result of the division is
>> 13.56, but I only get error-free serial output when rounding down.  I
>> don't think the remote end has timing problems, as I don't see this with
>> any other board.
> 
> I get exactly the opposite here with an mpc8248 base board. Rounding down 
> makes 115200bds completely unreliable :-/

Hmm...  In that case, I'm OK with the patch as it's technically more 
correct, and clearly what we want if the quotient comes out to something 
like 13.95.  Maybe mpc8272ads board code could apply some sort of tweak 
to the brg frequency.

The right answer is probably that if you want reliable standard baud 
rates, the board designer should ensure a suitable clock is available, 
rather than picking some random clock and hoping it divides nicely.

> Could you measure the serial baudrate with and without the patch using an 
> oscilloscope ?

Not easily; I'm a software person and would have to track down someone 
to lend me one and show me how to use it.  I may try using ntpdate to 
measure timebase drift, as it should be off by the same percentage.

>> Maybe we should change CPM_CLK to be MAIN_CLK/4 rather than MAIN_CLK/16
>> when the BRG clock is below a certain frequency.
> 
> Isn't that the job of the boot loader ?

Sure, I didn't necessarily mean "linux" by "we". :-)

> Accuracy would be improved, but power 
> consumption will raise as well :-/

Granted... though it's actually BRG_CLK and not CPM_CLK that I meant, so 
hopefully it wouldn't make too much of a difference in power.

-Scott
