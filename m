Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2FBC679F9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 02:28:12 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4AGS317008219
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 12:28:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4AGS2DO233916
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 12:28:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4AGS2E4007745
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 12:28:02 -0400
Subject: RE: Information for setting up SMT related parameters on linux
	2.6.16 on POWER5
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: "Meswani, Mitesh" <mmeswani@utep.edu>
In-Reply-To: <C26C730943E01145B4F89E37FE0A022002BBC74D@itdsrvmail02.utep.edu>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
	<445BE729.80903@am.sony.com>
	<C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu>
	<1147118619.8664.44.camel@localhost.localdomain>
	<18583972-9E29-4B52-BF2E-53102F1794EB@kernel.crashing.org>
	<C26C730943E01145B4F89E37FE0A022002BBC74D@itdsrvmail02.utep.edu>
Content-Type: text/plain
Date: Wed, 10 May 2006 11:27:48 -0500
Message-Id: <1147278469.8664.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-09 at 17:17 -0600, Meswani, Mitesh wrote:
> Thanks guys 
>  
> That answered so many of my questions. 
>  
> If I were to use these macros from user space, would they remain set
> until next reboot or change ? POWER5 allows priorities 2 through 4 for
> user apps, so considering this, and the fact that the normal prioirity
> is level 4, if a user app resets it to say 2 and then finishes without
> changing it back to 4 , would all the subsequent user apps run at the
> new level 2. I wonder what I am saying even makes sense, because the
> kernel internally throttles the priority for various sections of the
> kernel code and it may even overwrite it. 

I dont believe there is any mechanism that ever saves the current
priority between user and kernel, or between threads, etc.  So if you
were to set it, it would remain set until the next HMT_ macro was
touched.  A brief source search shows that the HMT_ macros are
referenced in idle loops, spin locks, exceptions, and hcalls, so not
likely that it would remain set for long. 

>  
> On a slightly unrelated note, I appended some boot parameters like
> smt-enabled=on/off to /etc/lilo.conf and unfortunately I am not able
> to see any effect and it boots the same way. I am switching from the

Perhaps bad notation in my first note.    "smt-enabled=on" is a default,
and will give you threads.   "smt-enabled=off"  will cause those threads
to be off by default. 

>  AIX world so I maybe doing something dumb, please point out if I am !
> This kind of seems to effect the bind processor calls using
> sys_setaffinity when there are 4 logical processors 0-3 on two
> physical processors, bind only allows me to set affinity to either cpu
> 0 or 2, this seems weird to me because my system is booting with two
> logical cpus and then I set online bit to 1 to turn the remaining on,
> thereafter I try binding and havent been very successful. 

Dont know about the affinity stuff.. 

>  
>  
> Thanks for all your replies. 
>  
>  
>  
> 
> Mitesh R. Meswani 
> Ph.D. Candidate 
> Research Associate, PLS2 Group
> Room 106 F, Department of Computer Science
> The University of Texas at El Paso, 
> El Paso, Texas 79968
> Tel: 915 747 8012 (O)
> Email: mmeswani@utep.edu
> 
> 
> ______________________________________________________________________
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]
> Sent: Mon 5/8/2006 5:04 PM
> To: will_schmidt@vnet.ibm.com
> Cc: Meswani, Mitesh; linuxppc-dev@ozlabs.org; Arnd Bergmann;
> linux-kernel@vger.kernel.org; cbe-oss-dev@ozlabs.org
> Subject: Re: Information for setting up SMT related parameters on
> linux 2.6.16 on POWER5
> 
> 
> > the HMT_* macros are telling firmware that "this processor thread 
> > should
> > run at this priority".  Typically used when we're waiting on a 
> > spinlock.
> > I.e. When we are waiting on a spinlock, we hit the HMT_low macro to 
> > drop
> > our threads priority, allowing the other thread to use those extra
> > cycles finish it's stuff quicker, and maybe even release the lock 
> > we're
> > waiting for.          HMT_* is all within the kernel though, no 
> > exposure
> > to userspace apps.
> 
> Actually, those macros translate straight into a single machine insn.
> No firmware is involved.  See include/asm-powerpc/processor.h.  For
> example:
> 
> #define HMT_very_low()   asm volatile("or 31,31,31   # very low 
> priority")
> 
> You can use those same macros from user space, although it is CPU
> implementation dependent which priorities you can actually set (you
> probably can do low and medium priority).
> 
> 
> Segher
> 
> 
> 
> 
