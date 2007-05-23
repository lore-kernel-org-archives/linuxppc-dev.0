Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59019DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 16:13:36 +1000 (EST)
In-Reply-To: <1179891419.6145.19.camel@concordia.ozlabs.ibm.com>
References: <46538264.2050000@mvista.com>
	<1179891419.6145.19.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D429DC8F-23EF-4B49-BA93-75403659E96D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] BOOKE watchdog and kexec
Date: Wed, 23 May 2007 01:10:59 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2007, at 10:36 PM, Michael Ellerman wrote:

> On Tue, 2007-05-22 at 16:53 -0700, Dave Jiang wrote:
>> What would be the appropriate way to deal with the BOOKE watchdog  
>> in order to
>> properly kexec? The BOOKE watchdog cannot be disabled. With the  
>> current
>> implementation, a watchdog daemon in userland is required to poke the
>> /dev/watchdog continously in order to keep it from going off. In  
>> the kexec
>> situation, the watchdog daemon in userland goes away when the new  
>> kernel is
>> executed. It is very possible that the new kernel can potentially  
>> timeout on a
>> certain hardware device initialization (i.e. SCSI discovery/ 
>> timeout) and causes
>> the watchdog to go off and reset the hardware. The reset is of  
>> course not
>> wanted in this situation.
>>
>> Several solutions comes into mind:
>> 1. Have the kernel timer poke the watchdog. This would ensure  
>> situation
>> described above would never happen. I think x86 does this with NMI  
>> watchdog.
>>
>> 2. Have the watchdog driver spawn a kernel thread to poke the  
>> watchdog at a
>> periodic time. Or perhaps use the delayed-work mechanism to do that.
>>
>> 3. Set the highest bit of the watchdog register so that it does  
>> not expire for
>> 2^32 ticks.
>
> #3 sounds the easiest. You'd set it in machine_kexec_prepare() and  
> then
> have the second kernel restore a sane value. I assume 2^32 ticks is  
> long
> enough to boot?

I haven't looked at the 4xx side, but on fsl parts you can pick any  
of 64-bits in the time base as the transition point, so you should  
have enough time, however maybe setting it to something like the  
panic_timeout or make it configurable is the best choice.

However, I agree that just tweaking the time and restoring it the  
best option.

- k
