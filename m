Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 7B7C82BDEB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Oct 2004 03:32:19 +1000 (EST)
Message-ID: <41827E99.1090206@vision.caltech.edu>
Date: Fri, 29 Oct 2004 10:32:09 -0700
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <41816863.9020000@vision.caltech.edu>	<1099006771.29690.83.camel@gaston>
	<4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston>
In-Reply-To: <1099011090.29689.96.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Benjamin Herrenschmidt wrote:

>On Thu, 2004-10-28 at 16:58 -0700, Arrigo Benedetti wrote:
>
>  
>
>>To achieve real-time performance in a very critical section of code. 
>>Even after moving all the
>>interrupts to CPU0, there are still two interrupts running on CPU1 that 
>>are disturbing the
>>execution of the time-critical code:
>>    
>>
>
>  
>
>>118:         15      21134   OpenPIC   Level     IPI0 (call function)
>>119:        888        904   OpenPIC   Level     IPI1 (reschedule)
>>    
>>
>
>Those are normal, they are cross-CPU interrupts used internally by the
>kernel. There are also non-visible in that list the timer interrupts on
>both CPUs. You just can't do anything against these.
>
>  
>

Have these interrupts anything to do with the load balancer? I have 
disabled the load balancer code
in linux/sched.c (just commented out all the code in load_balance()).
Maybe the only solution is to write a kernel module?

-Arrigo
