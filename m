Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id 55A2D679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 04:00:43 +1000 (EST)
Message-ID: <44749FF9.3020608@kenati.com>
Date: Wed, 24 May 2006 11:03:37 -0700
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
References: <20060524061205.53935.qmail@web8405.mail.in.yahoo.com>
	<200605240850.24333.roger.larsson@norran.net>
In-Reply-To: <200605240850.24333.roger.larsson@norran.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Roger Larsson wrote:

>On onsdag 24 maj 2006 08.12, sandeep malik wrote:
>  
>
>>Hi All...
>>
>>  I am trying to run an application compiled with gcc toolchain gcc--3.4.3
>>and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I
>>am getting following error....
>>
>>  floating point used in kernel (task=c0398410, pc=3184)
>>  floating point used in kernel (task=c0398410, pc=3184)
>>  floating point used in kernel (task=c0398410, pc=3184)
>>  floating point used in kernel (task=c0398410, pc=3184)
>>  floating point used in kernel (task=c0398410, pc=3184)
>>  floating point used in kernel (task=c0398410, pc=3184)
>>
>>  I was suspecting this error might be because the hardware is not
>>supporting floating point operations and hence i tried a simple program in
>>which I intentionally did some floating point operation but that program
>>was running as expected. 
>>    
>>
>No, the warning is more serious than that.
>
>Linux does not save floating point registers when entering kernel.
>It might even optimize not to store/reload when doing a context switch.
>
>If your kernel module is using floating point in your kernel code.
>It will probably work on a processor not having floating point but will
>break in mysterious ways on one supporting hardware floating point.
>
>Do not use floating point in kernel. If you still have to you must take
>extremely care.
>  Turn off kernel preemption.
>  Save FP registers.
>  Do your stuff.
>  Reload FP registers.
>  Turn on preemption.
>But the question is why would you have to?
>Simple calculations can be done in fixed point, and complex calculations
>does not belong in the kernel.
>
>/RogerL
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
Hi Sandeep,

I had the same problem as you. The processor I was using didn't have fp 
support, so what I did was link the kernel with the gcc library and I 
got it to work. However, as Roger said it would break on processors with 
fp support. In the long run I looked at the floating point calculations 
(log2 in my case) and was able to do the same math with fixed point.

Can you post the floating point calculations you need to do ? Someone 
here might be able to do the same using fix point.

Thanks,


Carlos
