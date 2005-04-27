Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 1BC9E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 08:30:29 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 1E070A400C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 00:30:24 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 28 Apr 2005 00:29:35 +0200
References: <200504271233.18856.glenn@aoi-industries.com>
In-Reply-To: <200504271233.18856.glenn@aoi-industries.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504280029.35461.roger.larsson@norran.net>
Subject: Re: Status of Linux 2.6 for 40x and 44x CPUs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 27 April 2005 18.33, Glenn Burkhardt wrote:
> From the looks of the benchmarks described here:
>
> http://www.denx.de/twiki/bin/view/Know/Linux24vs26
>
> and the results are basically confirmed here:
>
> http://www.2cpu.com/articles/98_1.html
>
> there are good reasons to avoid using the 2.6 kernel.  Frankly, I'm
> surprised and would have thought that the changes in the scheduler would
> have brought improvements, as did the report here:
>
> http://www.lynuxworks.com/corporate/news/2004/linux-kernel-2.6.php

At all depends on what you measure (and that you actually measure
what you think you are measuring :-)

"A PREEMPTIBLE KERNEL."

  This is about how quick your higher priority thread actually gets to run
  after an event (i.e. driver to application). It is not about how fast the
  context switch itself is.

  Why 2.4 might be faster:
     Measure context switch time where one process wakes up another
     while going to sleep has less overhead.

  Modified test
    Let the above processes run with SCHED_RR or SCHED_FIFO
    add a third process that uses the kernel a lot - like memory management.

"AN EFFICIENT SCHEDULER"

  This is more about what will happen if you have more than a few processes
  in the run queue - avoids searching all of them...

  Why 2.4 might be faster:
   A search of a list with only one element is hard to beat!
   But try to measure using lots of processes running at the same time.

/RogerL
