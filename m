Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04EF52BF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Oct 2004 09:05:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20041029101017.GA28149@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston> <4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston>  <20041029101017.GA28149@iram.es>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 09:00:06 +1000
Message-Id: <1099090806.29689.140.camel@gaston>
Mime-Version: 1.0
Cc: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I alway wondered why the decrementer interrupts are not listed, 
> actually. Perhaps even with a count of the decrementer interrupts
> which result in multiple updates of jiffies, because they indicate
> that something has avery high latency.
> 
> BTW, on my Pismo, the number of bad interrupts is amazing:
>
> .../...
>
> BAD:   21458276
> 
> in about one week uptime, but over half the time sleeping.
> 
> I have a fix for that, but it's not yet ready for submission. 
> I might find time over the week-end.

Ah ok, what is it ? Those seem to be "short" interrupts, they don't
happen on my tipb but they do happen on paul's older one (same mobo as
Pismo).

Looks like between clearing the irq source and exiting the handler, the
IRQ line stays asserted a bit longer or so ...

BTW, We should remove the cruft of early/late eoi too while we are at
it. A single "late" EOI is all we need. The MPIC will latch an edge irq
coming in between the ACK and the EOI and we don't want the CPU priority
to drop too early.

Ben.
 
