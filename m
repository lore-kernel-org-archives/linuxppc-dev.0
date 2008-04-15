Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D208DE229
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:59:18 +1000 (EST)
Message-ID: <4804D0EB.5020508@freescale.com>
Date: Tue, 15 Apr 2008 10:59:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC] Using two baud rate generators with the cpm_uart driver
References: <200804151532.27057.laurentp@cse-semaphore.com>
	<4804CB12.1000308@freescale.com>
	<200804151754.21664.laurentp@cse-semaphore.com>
In-Reply-To: <200804151754.21664.laurentp@cse-semaphore.com>
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
>> The clean solution would be to have an abstracted clock API, similar to 
>> phylib, where the caller doesn't know details about BRGs and such. 
>> Maybe the linux/clk.h API would be suitable; I haven't looked at it in 
>> detail.
> 
> The clock API would have to be quite advanced to express things like "the SCC4 
> clock is a combination of BRG2 and BRG5" (and I don't even consider 
> adding "with BRG2 set to 16x the baud rate and BRG5 to the baud rate").

What I was picturing was platform code providing a clock object that the 
cpm_uart driver could be pointed at (possibly by modifying the device 
tree in platform init); the knowledge of the multiple BRG weirdness 
would be contained in platform code.

-Scott
