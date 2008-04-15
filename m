Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06B47DE92A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:34:44 +1000 (EST)
Message-ID: <4804CB12.1000308@freescale.com>
Date: Tue, 15 Apr 2008 10:34:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC] Using two baud rate generators with the cpm_uart driver
References: <200804151532.27057.laurentp@cse-semaphore.com>
In-Reply-To: <200804151532.27057.laurentp@cse-semaphore.com>
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
> thanks to a bad hardware design decision, I'm faced with a software issue with 
> the cpm_uart driver.
> 
> My hardware uses either SCC4 or SMC2 (production-time option) as an RS485 port 
> with an external transceiver. The transceiver's data direction is controlled 
> by external logic that monitors the SCC4/SMC2 TxD signal.
> 
> The external logic needs an input clock at the baud rate frequency on the 
> MPC8248 BRG5 output pin (although I could modify it to accept an input clock 
> at 16x the baud rate frequency). This means the cpm_uart driver has to setup 
> two baud rate generators instead of one.
> 
> The ppc architecture was easy to hack as it used a fs_uart_platform_info 
> structure in which I added a set_brg function pointer provided by platform 
> code. This isn't possible with the powerpc architecture anymore.
 >
> Is there a clean way to fix this issue ? Kicking the hardware designer won't 
> help :-)

Maybe not, but it'd be satisfying. :-)

The clean solution would be to have an abstracted clock API, similar to 
phylib, where the caller doesn't know details about BRGs and such. 
Maybe the linux/clk.h API would be suitable; I haven't looked at it in 
detail.

-Scott
