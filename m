Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A17CDDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 19:49:20 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KQJAL-0007fH-0t
	for linuxppc-embedded@ozlabs.org; Tue, 05 Aug 2008 02:49:17 -0700
Message-ID: <18827857.post@talk.nabble.com>
Date: Tue, 5 Aug 2008 02:49:17 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: floating point support in the driver.
In-Reply-To: <48969805.40904@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18772109.post@talk.nabble.com>
	<200808011332.25368.laurentp@cse-semaphore.com>
	<18772952.post@talk.nabble.com>
	<20080801.095429.-1827411968.imp@bsdimp.com>
	<18805820.post@talk.nabble.com>
	<20080803.233352.915266361.imp@bsdimp.com>
	<48969805.40904@ovro.caltech.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi David ,

Thank you for your reply.

I am running the algorithm on OMAP processor (arm-core) and i did tried the
same on iMX processor which takes 1.7 times more than OMAP.

It is true that the algorithm is performing the vector operation which is
blowing the cache .

But the question is How to lock the cache ? In driver how should we
implement the same ?

An example code or a document could be helpful in this regard.

--- Misbah <><

David Hawkins-3 wrote:
> 
> 
> Hi Misbah,
> 
> I would recommend you look at your floating-point code again
> and benchmark each section. You should be able to estimate
> the number of clock cycles required to complete an operation
> and then check that against your measurements.
> 
> Depending on whether your algorithm is processing intensive
> or data movement intensive, you may find that the big time
> waster is moving data on or off chip, or perhaps its a large
> vector operation that is blowing out the cache. If you
> do find that, then on some processors you can lock the
> cache, so your algorithm would require a custom driver
> that steals part of the cache from the OS, but the floating point
> code would not run in the kernel, it would run on data
> stored in the stolen cache area. You can lock both instructions
> and data in the cache; eg. an FFT routine can be locked in
> the instruction cache, while FFT data is in the data cache.
> I'm not sure how easy this is to do under Linux though.
> 
> Here's an example of the level of detail you can get
> downto when benchmarking code:
> 
> http://www.ovro.caltech.edu/~dwh/correlator/pdf/dsp_programming.pdf
> 
> The FFT routine used on this processor made use of both
> the instruction and data cache (on-chip SRAM) on the
> DSP.
> 
> This code is being re-developed to run on a MPC8349EA PowerPC
> with FPU. I did some initial testing to confirm that the
> FPU operates as per the data sheet, and will eventually get
> around to more complete testing.
> 
> Which processor were you running your code on, and what
> frequency were you operating the processor at? How does
> the algorithm timing compare when run on other processors,
> eg. your desktop or laptop machine?
> 
> Cheers,
> Dave
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/floating-point-support-in-the-driver.-tp18772109p18827857.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
