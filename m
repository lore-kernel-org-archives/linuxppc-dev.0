Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 10543DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Aug 2008 15:23:28 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KPsXU-0005rW-NI
	for linuxppc-embedded@ozlabs.org; Sun, 03 Aug 2008 22:23:24 -0700
Message-ID: <18805820.post@talk.nabble.com>
Date: Sun, 3 Aug 2008 22:23:24 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: floating point support in the driver.
In-Reply-To: <20080801.095429.-1827411968.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18772109.post@talk.nabble.com>
	<200808011332.25368.laurentp@cse-semaphore.com>
	<18772952.post@talk.nabble.com>
	<20080801.095429.-1827411968.imp@bsdimp.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you Warner.

Actually the complete algorithm should take not more than 1 sec to execute
but its taking around 1.8 sec .The algorithm would rum between every few
secs. I am trying to fine tune the code ,i just want to know that will it a
good idea to alter the task priority and what could be the best way ?

-- Misbah <>< 

M. Warner Losh wrote:
> 
> In message: <18772952.post@talk.nabble.com>
>             Misbah khan <misbah_khan@engineer.com> writes:
> : I am not very clear Why floating point support in the Kernel should be
> : avoided ?
> 
> Because saving the FPU state is expensive.  The kernel multiplexes the
> FPU hardware among all the userland processes that use it.  For parts
> of the kernel to effectively use the FPU, it would have to save the
> state on traps into the kernel, and restore the state when returning
> to userland.  This is a big drag on performance of the system.  There
> are ways around this optimization where you save the fpu state
> explicitly, but the expense si still there.
> 
> : We want our DSP algorithm to run at the boot time and since kernel
> thread
> : having higher priority , i assume that it would be faster than user
> : application.
> 
> Bad assumption.  User threads can get boots in priority in certain
> cases.
> 
> If it really is just at boot time, before any other threads are
> started, you likely can get away with it.
> 
> : If i really have to speed up my application execution what mechanism
> will
> : you suggest me to try ?
> : 
> : After using Hardware VFP support also i am still laging the timing
> : requirement by 800 ms in my case 
> 
> This sounds like a classic case of putting 20 pounds in a 10 pound bag
> and complaining that the bag rips out.  You need a bigger bag.
> 
> If you are doing FPU intensive operations in userland, moving them to
> the kernel isn't going to help anything but maybe latency.  And if you
> are almost a full second short, your quest to move things into the
> kernel is almost certainly not going to help enough.  Moving things
> into the kernel only helps latency, and only when there's lots of
> context switches (since doing stuff in the kernel avoids the domain
> crossing that forces the save of the CPU state).
> 
> I don't know if the 800ms timing is relative to a task that must run
> once a second, or once an hour.  If the former, you're totally
> screwed and need to either be more clever about your algorithm
> (consider integer math, profiling the hot spots, etc), or you need
> more powerful silicon.  If you  are trying to shave 800ms off a task
> that runs for an hour, then you just might be able to do that with
> tiny code tweaks.
> 
> Sorry to be so harsh, but really, there's no such thing as a free lunch.
> 
> Warner
> 
> 
> 
> : ---- Misbah <><
> : 
> : 
> : Laurent Pinchart-4 wrote:
> : > 
> : > On Friday 01 August 2008, Misbah khan wrote:
> : >> 
> : >> Hi all,
> : >> 
> : >> I have a DSP algorithm which i am running in the application even
> after
> : >> enabling the VFP support it is taking a lot of time to get executed
> hence 
> : >> 
> : >> I want to transform the same into the driver insted of an user
> : >> application.
> : >> Can anybody suggest whether doing the same could be a better solution
> and
> : >> what could be the chalenges that i have to face by implimenting such
> : >> floating point support in the driver.
> : >> 
> : >> Is there a way in the application itself to make it execute faster.
> : > 
> : > Floating-point in the kernel should be avoided. FPU state save/restore
> : > operations are costly and are not performed by the kernel when
> switching
> : > from userspace to kernelspace context. You will have to protect
> : > floating-point sections with kernel_fpu_begin/kernel_fpu_end which, if
> I'm
> : > not mistaken, disables preemption. That's probably not something you
> want
> : > to do. Why would the same code run faster in kernelspace then
> userspace ?
> : > 
> : > -- 
> : > Laurent Pinchart
> : > CSE Semaphore Belgium
> : > 
> : > Chaussee de Bruxelles, 732A
> : > B-1410 Waterloo
> : > Belgium
> : > 
> : > T +32 (2) 387 42 59
> : > F +32 (2) 387 42 75
> : > 
> : >  
> : > _______________________________________________
> : > Linuxppc-embedded mailing list
> : > Linuxppc-embedded@ozlabs.org
> : > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> : > 
> : 
> : -- 
> : View this message in context:
> http://www.nabble.com/floating-point-support-in-the-driver.-tp18772109p18772952.html
> : Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> : 
> : _______________________________________________
> : Linuxppc-embedded mailing list
> : Linuxppc-embedded@ozlabs.org
> : https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> : 
> : 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/floating-point-support-in-the-driver.-tp18772109p18805820.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
