Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2455A67B2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 08:34:10 +1000 (EST)
Date: Sun, 24 Apr 2005 14:25:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050424172518.GB22786@logos.cnet>
References: <20050421183239.GJ6525@logos.cnet>
	<20050424205945.372F7C1510@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050424205945.372F7C1510@atlas.denx.de>
Cc: 26-devel@cyclades.com, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: v2.6 performance slowdown on MPC8xx: Measuring TLB cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Apr 24, 2005 at 10:59:40PM +0200, Wolfgang Denk wrote:
> Dear Marcelo,

Hi Wolfgang! 

> thanks for starting this discussion, and for providing a patch for 8xx. 

Thanks so much for spending the time to do this, some very interesting
results inside..

> However, I think we should not only look at the TLB handling problems
> on the 8xx processors. This is probably just a part of  the  problem.
> In  general  the 2.6 performance on (small) embedded systems is much,
> much worse than what we see with a 2.4 kernel. 
> 
> I put some results (2.4.25 vs. 2.6.11.7 on a MPC860 and on a MPC8240)
> at http://www.denx.de/twiki/bin/view/Know/Linux24vs26
> 
> Here is the summary:
> 
> Using the 2.6 kernel on embedded  systems  implicates  the  following
> disadvantages:
> * Slow to build: 2.6 takes 30...40% longer to compile
> * Big memory footprint in flash: the 2.6 compressed kernel image is
>   30...40% bigger 
>
> * Big memory footprint in RAM: the 2.6 kernel needs 30...40% more
>   RAM; the available RAM size for applications is 700kB smaller

I've shrank the v2.6 kernel build to a size significantly smaller than our 
v2.4 build, and performance did not increase at all. 

>From that, I could figure that the performance problem, in this case, 
was not related to decreased available free memory. From then on I started
going the TLB direction.

But yes, in general, v2.6 image is bigger and memory consumption is higher 
than v2.4. 

One important project in this area is linux-tiny, which allows one to 
disable unwanted features.

> * Slow to boot: 2.6 takes 5...15% longer to boot into multi-user mode

Others have mentioned, and I agree, that sysfs is likely to be the major 
cause for boot-time slowdown. Have you tried disabling sysfs? 

> * Slow to run: context switches up to 96% slower, local communication
>   latencies up to 80% slower, file system latencies up to 76% slower,
>   local communication bandwidth less than 50% in some cases. 

I've noticed the v2.6 scheduler context switching _more_ than v2.4...

Question: Such huge regressions are seen on MPC8xx only, MPC82xx slowdown 
is not so bad, correct? 

> It's a disappointing result, indeed.

Yes we are in bad shape :( 
