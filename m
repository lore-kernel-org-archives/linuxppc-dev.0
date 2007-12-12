Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A961DDE09C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:54:35 +1100 (EST)
Message-ID: <47601245.2090907@freescale.com>
Date: Wed, 12 Dec 2007 10:54:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
References: <20071210204705.GA31263@localhost.localdomain>
	<20071212164035.GB4329@loki.buserror.net>
	<20071212165513.GA30981@localhost.localdomain>
In-Reply-To: <20071212165513.GA30981@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Wed, Dec 12, 2007 at 10:40:35AM -0600, Scott Wood wrote:
>> Not enough to be worth the complexity compared to the overhead of NAND
>> access -- especially in the likely case of a non-SMP build.
> 
> I'm allowing UPM access from the IRQ handlers (because nothing prevents
> this, so why deny?). Thus locks are needed even on non-SMP build,

No, it just needs to disable interrupts.  Which is what locks do on 
non-SMP.  The overhead of this is not worth 30 lines of code to avoid.

-Scott
