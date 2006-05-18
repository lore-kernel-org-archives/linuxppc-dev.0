Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F36DE67A44
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 02:48:15 +1000 (EST)
Date: Thu, 18 May 2006 09:48:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: MPC8xx: resolution of gettimeofday() ?
Message-ID: <20060518164812.GA21075@gate.ebshome.net>
References: <446C8E70.3040601@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <446C8E70.3040601@imc-berlin.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, May 18, 2006 at 05:10:40PM +0200, Steven Scholz wrote:
> Hi all,
> 
> what is the resolution of gettimeofday() for an MPC8xx?
> 
> IIUC then the "decrementer" is used to generate the timer interrupts every 10ms.
> 
> This decrementer runs at cpuclk/16. Thus with 80MHz CPU clock has a
> resolution of 16/80MHz = 200ns and overflows every 50000 ticks.
> 
> But is this decrementer used to update xtime?
> Will gettimeofday() have a resolution of 200ns?
> 
> How about linux 2.4 where xtime is a "struct timeval" rather then "struct
> timespec"?
> 
> This trivial test programm
> 
> 	struct timeval first, next;
> 	double diff;
> 
> 	gettimeofday(&first, NULL);
> 	do {
> 		gettimeofday(&next, NULL);
> 	} while (first.tv_usec == next.tv_usec &&
> 		 first.tv_sec == next.tv_sec);
> 
> 	diff  = ((double)  next.tv_sec - (double) first.tv_sec) * 1e6;
> 	diff +=  (double) (next.tv_usec - first.tv_usec);
> 
> 	printf ("Resolution gettimeofday() = %g ?s\n", diff);
> 
> says it's between 13 - 16 ?s on a linux-2.4.20. Could that be? how does this
> relate to the decrementer frequency?

Usually on PPC we use timebase to interpolate time between Decrementer 
interrupts. In this case gettimeofday resolution is determined by 
timebase resolution which is quite high (megahertz range).

-- 
Eugene
