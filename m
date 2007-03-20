Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id 22447DDF06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 10:08:13 +1100 (EST)
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: "'Andy Fleming'" <afleming@freescale.com>
Subject: RE: Question about oprofile
Date: Tue, 20 Mar 2007 19:07:29 -0400
Message-ID: <004401c76b44$9b4b73f0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <5C40F14F-81A8-4134-99A9-2B62BBD3AF05@freescale.com>
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

Has anyone considered doing something like lazy FPU/Altivec save/restore,
but only for PMC registers (depending on the PMM field in the MSR)... or is
it a lame idea :)?

-Ilya

-----Original Message-----
From: Andy Fleming [mailto:afleming@freescale.com] 
Sent: Tuesday, March 20, 2007 3:14 PM
To: Ilya Lipovsky
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Question about oprofile


On Mar 20, 2007, at 13:47, Ilya Lipovsky wrote:

> Hi,
>
>
>
> I am trying to understand how oprofile works, and so far I have a  
> question:
>
> When rfi'ing back into user context the PMM is cleared. However, if  
> PMM is cleared and then a context switch happens (say, to another  
> CPU-local thread) the counters keep getting incremented. Is that  
> right?
>
>
>
> If this is the case, then the PMC statistics account not just for  
> the current user thread, but also for other ones as well and thus  
> are not "pure."

oprofile does not support counting just on one thread.  The PMM bit  
is only used to make it so that the interrupt handler and setup code  
are not counted.  In order to count in one thread, you would need to  
modify the context switch code to allow the PMM bit to stay set on  
marked threads, and you would need to modify the oprofile code in  
arch/powerpc to only count when the mark bit is set (rather than when  
it is cleared).

Andy
