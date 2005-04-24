Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 779B467B18
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 07:00:12 +1000 (EST)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Apr 2005 15:32:39 -0300."
	<20050421183239.GJ6525@logos.cnet>
Date: Sun, 24 Apr 2005 22:59:40 +0200
Sender: wd@denx.de
Message-Id: <20050424205945.372F7C1510@atlas.denx.de>
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

Dear Marcelo,

thanks for starting this discussion, and for providing a patch for 8xx.

However, I think we should not only look at the TLB handling problems
on the 8xx processors. This is probably just a part of  the  problem.
In  general  the 2.6 performance on (small) embedded systems is much,
much worse than what we see with a 2.4 kernel.

I put some results (2.4.25 vs. 2.6.11.7 on a MPC860 and on a MPC8240)
at http://www.denx.de/twiki/bin/view/Know/Linux24vs26

Here is the summary:

Using the 2.6 kernel on embedded  systems  implicates  the  following
disadvantages:
* Slow to build: 2.6 takes 30...40% longer to compile
* Big memory footprint in flash: the 2.6 compressed kernel image is
  30...40% bigger
* Big memory footprint in RAM: the 2.6 kernel needs 30...40% more
  RAM; the available RAM size for applications is 700kB smaller
* Slow to boot: 2.6 takes 5...15% longer to boot into multi-user mode
* Slow to run: context switches up to 96% slower, local communication
  latencies up to 80% slower, file system latencies up to 76% slower,
  local communication bandwidth less than 50% in some cases.

It's a disappointing result, indeed.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Another megabytes the dust.
