Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1E38DE036
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 08:06:59 +1100 (EST)
Message-ID: <47604D6E.1050200@freescale.com>
Date: Wed, 12 Dec 2007 15:06:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
References: <20071210204705.GA31263@localhost.localdomain>
	<20071212164035.GB4329@loki.buserror.net>
	<20071212165513.GA30981@localhost.localdomain>
	<47601245.2090907@freescale.com>
	<20071212205838.GA16425@localhost.localdomain>
In-Reply-To: <20071212205838.GA16425@localhost.localdomain>
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
> As the compromise I might suggest this: forbid pattern_start/pattern_end
> from the ISRs (by marking them as might_sleep()), and replace _irqsave
> spinlock with simple spinlock.

No, you cannot use a bare spinlock with IRQs enabled.  You'll deadlock 
on SMP, and you'll have races with preemption enabled.

> Given that, personally I'd want to lockless variant to stay.
> 
> So, you still want to get rid of it?

Yes, in the absence of benchmarking that shows it makes a real 
difference.  Premature optimization being the root of all evil, and what 
not.

-Scott
