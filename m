Return-Path: <paubert@iram.es>
Received: from ltgp.iram.es (ltgp.iram.es [150.214.224.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 324612BF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Oct 2004 20:21:47 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 29 Oct 2004 12:10:17 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041029101017.GA28149@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston>
	<4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099011090.29689.96.camel@gaston>
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

On Fri, Oct 29, 2004 at 10:51:30AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2004-10-28 at 16:58 -0700, Arrigo Benedetti wrote:
> 
> > To achieve real-time performance in a very critical section of code. 
> > Even after moving all the
> > interrupts to CPU0, there are still two interrupts running on CPU1 that 
> > are disturbing the
> > execution of the time-critical code:
> 
> > 118:         15      21134   OpenPIC   Level     IPI0 (call function)
> > 119:        888        904   OpenPIC   Level     IPI1 (reschedule)
> 
> Those are normal, they are cross-CPU interrupts used internally by the
> kernel. There are also non-visible in that list the timer interrupts on
> both CPUs. You just can't do anything against these.

I alway wondered why the decrementer interrupts are not listed, 
actually. Perhaps even with a count of the decrementer interrupts
which result in multiple updates of jiffies, because they indicate
that something has avery high latency.

BTW, on my Pismo, the number of bad interrupts is amazing:


           CPU0       
  9:          0   OpenPIC   Edge      Built-in Sound out
 10:          0   OpenPIC   Edge      Built-in Sound in
 19:     616569   OpenPIC   Level     ide0
 24:         23   OpenPIC   Level     Built-in Sound misc
 25:   12784655   OpenPIC   Level     VIA-PMU
 26:          2   OpenPIC   Level     keywest i2c
 27:          0   OpenPIC   Level     ohci_hcd
 28:          0   OpenPIC   Level     ohci_hcd
 40:          3   OpenPIC   Level     ohci1394
 41:    1334956   OpenPIC   Level     eth0
 42:          4   OpenPIC   Level     keywest i2c
 47:     503221   OpenPIC   Level     GPIO1/ADB
BAD:   21458276

in about one week uptime, but over half the time sleeping.

I have a fix for that, but it's not yet ready for submission. 
I might find time over the week-end.

	Regards,
	Gabriel
