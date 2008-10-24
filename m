Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44A8CDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 02:39:18 +1100 (EST)
Message-Id: <36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Chris Snook <csnook@redhat.com>
In-Reply-To: <4901E6FB.4070200@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP PPC
	based systems)
Date: Fri, 24 Oct 2008 10:39:05 -0500
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>
	<4901E6FB.4070200@redhat.com>
Cc: LinuxPPC-dev list <linuxppc-dev@ozlabs.org>, tglx@linutronix.de,
	linux-kernel Kernel <linux-kernel@vger.kernel.org>, maxk@qualcomm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 24, 2008, at 10:17 AM, Chris Snook wrote:

> Kumar Gala wrote:
>> It appears the default IRQ affinity changes from being just cpu 0  
>> to all cpu's.  This breaks several PPC SMP systems in which only a  
>> single processor is allowed to be selected as the destination of  
>> the IRQ.
>> What is the right answer in fixing this?  Should we:
>>    cpumask_t irq_default_affinity = 1;
>> instead of
>>    cpumask_t irq_default_affinity = CPU_MASK_ALL?
>
> On those systems, perhaps, but not universally.  There's plenty of  
> hardware where the physical topology of the machine is abstracted  
> away from the OS, and you need to leave the mask wide open and let  
> the APIC figure out where to map the IRQs.  Ideally, we should  
> probably make this decision based on the APIC, but if there's no PPC  
> hardware that uses this technique, then it would suffice to make  
> this arch-specific.


What did those systems do before this patch?  Its one thing to expose  
a mask in the ability to change the default mask in /proc/irq/ 
default_smp_affinity.  Its another (and a regression in my opinion) to  
change the mask value itself.

As for making it ARCH specific, that doesn't really help since not all  
PPC hw has the limitation I spoke of.  Not even all MPIC (in our  
cases) have the limitation.

- k
