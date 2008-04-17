Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2603DE8C9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:25:59 +1000 (EST)
Message-ID: <4807B26F.2020107@freescale.com>
Date: Thu, 17 Apr 2008 15:26:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com> <4807AC15.4010008@freescale.com>
	<4807AD48.1040100@freescale.com> <4807AF9F.4060603@freescale.com>
	<4807B062.3080004@freescale.com>
In-Reply-To: <4807B062.3080004@freescale.com>
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
>> That's implementation dependent, and support for accesses to uncached 
>> memory is being phased out of book E according to the E500 manual.
> 
> What's wrong with uncached memory?

The typical implementation of lwarx/stwcx depends on holding the 
reserved cache line in exclusive state, and stwcx failing if it is no 
longer exclusive.

> I figured that if I could use lwarx/stwcx to make clrsetbits atomic, there would
> be no need to spinlocks protecting an individual register.

OK, so you're not trying to be atomic with respect to the device, just 
with respect to other cores?  Just use the spinlock.

-Scott
