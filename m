Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F5EDDE5A8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:08:15 +1000 (EST)
Message-ID: <4863A2B0.9000303@freescale.com>
Date: Thu, 26 Jun 2008 09:07:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
References: <20080625215051.GA11784@loki.buserror.net>
	<D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
In-Reply-To: <D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
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

Kumar Gala wrote:
> 
> On Jun 25, 2008, at 4:50 PM, Scott Wood wrote:
> 
>> Basic PM support for 83xx.  Standby is implemented as sleep.
>> Suspend-to-RAM is implemented as "deep sleep" (with the processor
>> turned off) on 831x.  PCI agent power management is supported.
>>
>> Device power management of SOC peripherals is not yet supported.
> 
> (Not comments on this patch, but related)
> 
> Do you know if anyone is looking at making sure DOZE/NAP work on 83xx?  
> We clearly don't flush the L1 cache today in the 6xx code.

Doze should work (a long time ago when I did power measurements I saw a 
drop in consumption once Linux started, and the system was idle)...  Nap 
is not supported, and should probably be removed from the e300 cputable 
entry.  I don't think it's worthwhile to flush the cache every time the 
cpu is idle just to nap instead of doze.

-Scott
