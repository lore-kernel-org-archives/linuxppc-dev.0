Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCF97DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 08:14:03 +1100 (EST)
Message-ID: <47604F17.8060403@freescale.com>
Date: Wed, 12 Dec 2007 15:13:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
References: <20071210204705.GA31263@localhost.localdomain>	<20071212164035.GB4329@loki.buserror.net>	<20071212165513.GA30981@localhost.localdomain>	<47601245.2090907@freescale.com>	<20071212205838.GA16425@localhost.localdomain>
	<47604D6E.1050200@freescale.com>
In-Reply-To: <47604D6E.1050200@freescale.com>
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

Scott Wood wrote:
> Anton Vorontsov wrote:
>> As the compromise I might suggest this: forbid pattern_start/pattern_end
>> from the ISRs (by marking them as might_sleep()), and replace _irqsave
>> spinlock with simple spinlock.
> 
> No, you cannot use a bare spinlock with IRQs enabled.  You'll deadlock 
> on SMP, and you'll have races with preemption enabled.

Sorry, brain fart...  obviously, with preemption on it'd disable 
preemption even with a plain spinlock, and on SMP without preemption 
it's not an issue.

Still, all you're getting rid of is the MSR twiddling, which should be 
pretty minor.

-Scott
