Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D7902BDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Oct 2004 10:56:24 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
In-Reply-To: <4181878C.20605@vision.caltech.edu>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston> <4181878C.20605@vision.caltech.edu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 10:51:30 +1000
Message-Id: <1099011090.29689.96.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-28 at 16:58 -0700, Arrigo Benedetti wrote:

> To achieve real-time performance in a very critical section of code. 
> Even after moving all the
> interrupts to CPU0, there are still two interrupts running on CPU1 that 
> are disturbing the
> execution of the time-critical code:

> 118:         15      21134   OpenPIC   Level     IPI0 (call function)
> 119:        888        904   OpenPIC   Level     IPI1 (reschedule)

Those are normal, they are cross-CPU interrupts used internally by the
kernel. There are also non-visible in that list the timer interrupts on
both CPUs. You just can't do anything against these.

Ben.
