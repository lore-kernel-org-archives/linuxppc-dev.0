Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4F49DE1BC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:13:59 +1000 (EST)
Message-ID: <4807AF9F.4060603@freescale.com>
Date: Thu, 17 Apr 2008 15:14:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com> <4807AC15.4010008@freescale.com>
	<4807AD48.1040100@freescale.com>
In-Reply-To: <4807AD48.1040100@freescale.com>
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

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> No.  clrsetbits operates on I/O registers, not RAM.
> 
> Does lwarx require the EA to be cached memory or something?

That's implementation dependent, and support for accesses to uncached 
memory is being phased out of book E according to the E500 manual.

>  The reservation is held within the processor, so it should work on I/O.

Even if the core supports lwarx/stwcx to uncached memory, the I/O bus 
must support atomic read-modify-write transactions for this to work.

Why do you think you need lwarx/stwcx to I/O?

-Scott
