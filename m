Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9F27DF0B6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:17:46 +1000 (EST)
Message-ID: <4807B062.3080004@freescale.com>
Date: Thu, 17 Apr 2008 15:17:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com> <4807AC15.4010008@freescale.com>
	<4807AD48.1040100@freescale.com> <4807AF9F.4060603@freescale.com>
In-Reply-To: <4807AF9F.4060603@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> That's implementation dependent, and support for accesses to uncached 
> memory is being phased out of book E according to the E500 manual.

What's wrong with uncached memory?

>>  The reservation is held within the processor, so it should work on I/O.
> 
> Even if the core supports lwarx/stwcx to uncached memory, the I/O bus 
> must support atomic read-modify-write transactions for this to work.

Why?  I thought the way that lwarx/stwcx work is that since the processor
detects the reservation collision, and the processor is one doing the writes,
that it would know when the reservation collided.  Why does the I/O bus need to
know anything?

> Why do you think you need lwarx/stwcx to I/O?

I figured that if I could use lwarx/stwcx to make clrsetbits atomic, there would
be no need to spinlocks protecting an individual register.

-- 
Timur Tabi
Linux kernel developer at Freescale
