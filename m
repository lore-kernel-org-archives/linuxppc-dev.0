Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 0A6A267B2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 07:58:34 +1000 (EST)
Message-ID: <42A0D41E.6000608@mvista.com>
Date: Fri, 03 Jun 2005 15:05:18 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42A0CD46.60300@mvista.com>
	<5e2620f079e946d884175372dbf7e37e@freescale.com>
In-Reply-To: <5e2620f079e946d884175372dbf7e37e@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374 Real-Time Clock
 Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Randy,
> 
> I was planning on cloning the DS1337 driver once all of the latest  
> patches for it got into Linus's tree. 

I haven't seen any patches for the DS1337, but I admit that I wasn't 
looking very hard.

  Not sure if you looked at it,
> but when I was looking at RTC on 8349 the DS1337 seemed similar.  Not  
> sure if we can unify the DS1337 driver such that can also support the  
> DS1374.

I looked at the DS1337 driver, but that chip uses individual registers 
for the various time bits, whereas the DS1374 uses a 32-bit seconds 
count spread across 4 registers. I wasn't convinced that I could find a 
reliable way to differenciate between the 2 types at run time since they 
use the same I2C address (0x68). So, I choose to create a new driver to 
keep it simple. If there is a reliable way to handle both types in the 
same driver, I'll drop my DS1374-specific driver.

> 
> (Also, I'll wait on acceptance of the driver before pushing the board  
> code).

Agreed.

		Randy Vinson
