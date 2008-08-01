Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0F148DDF55
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 22:00:14 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KOtIn-0004V3-S9
	for linuxppc-embedded@ozlabs.org; Fri, 01 Aug 2008 05:00:09 -0700
Message-ID: <18772952.post@talk.nabble.com>
Date: Fri, 1 Aug 2008 05:00:09 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: floating point support in the driver.
In-Reply-To: <200808011332.25368.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18772109.post@talk.nabble.com>
	<200808011332.25368.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am not very clear Why floating point support in the Kernel should be
avoided ?

We want our DSP algorithm to run at the boot time and since kernel thread
having higher priority , i assume that it would be faster than user
application.

If i really have to speed up my application execution what mechanism will
you suggest me to try ?

After using Hardware VFP support also i am still laging the timing
requirement by 800 ms in my case 

---- Misbah <><


Laurent Pinchart-4 wrote:
> 
> On Friday 01 August 2008, Misbah khan wrote:
>> 
>> Hi all,
>> 
>> I have a DSP algorithm which i am running in the application even after
>> enabling the VFP support it is taking a lot of time to get executed hence 
>> 
>> I want to transform the same into the driver insted of an user
>> application.
>> Can anybody suggest whether doing the same could be a better solution and
>> what could be the chalenges that i have to face by implimenting such
>> floating point support in the driver.
>> 
>> Is there a way in the application itself to make it execute faster.
> 
> Floating-point in the kernel should be avoided. FPU state save/restore
> operations are costly and are not performed by the kernel when switching
> from userspace to kernelspace context. You will have to protect
> floating-point sections with kernel_fpu_begin/kernel_fpu_end which, if I'm
> not mistaken, disables preemption. That's probably not something you want
> to do. Why would the same code run faster in kernelspace then userspace ?
> 
> -- 
> Laurent Pinchart
> CSE Semaphore Belgium
> 
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
> 
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
> 
>  
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/floating-point-support-in-the-driver.-tp18772109p18772952.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
