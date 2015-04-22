Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C6E01A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:06:55 +1000 (AEST)
Message-ID: <55378EC4.2080302@freescale.com>
Date: Wed, 22 Apr 2015 15:06:28 +0300
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>					
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>					
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>					
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>				
 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>			
 <1428016310.22867.289.camel@freescale.com>		
 <551E4A41.1080705@freescale.com>	
 <1428096375.22867.369.camel@freescale.com>		
 <55262DD3.2050707@freescale.com>	 <1428623611.22867.561.camel@freescale.com>
 <5534DAA4.3050809@freescale.com> <1429577566.4352.68.camel@freescale.com>
In-Reply-To: <1429577566.4352.68.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: Laurentiu Tudor <b10716@freescale.com>, linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.04.2015 03:52, Scott Wood wrote:
> On Mon, 2015-04-20 at 13:53 +0300, Purcareata Bogdan wrote:
>> There was a weird situation for .kvmppc_mpic_set_epr - its corresponding inner
>> function is kvmppc_set_epr, which is a static inline. Removing the static inline
>> yields a compiler crash (Segmentation fault (core dumped) -
>> scripts/Makefile.build:441: recipe for target 'arch/powerpc/kvm/kvm.o' failed),
>> but that's a different story, so I just let it be for now. Point is the time may
>> include other work after the lock has been released, but before the function
>> actually returned. I noticed this was the case for .kvm_set_msi, which could
>> work up to 90 ms, not actually under the lock. This made me change what I'm
>> looking at.
>
> kvm_set_msi does pretty much nothing outside the lock -- I suspect
> you're measuring an interrupt that happened as soon as the lock was
> released.

That's exactly right. I've seen things like a timer interrupt occuring right 
after the spinlock_irqrestore, but before kvm_set_msi actually returned.

[...]

>>   Or perhaps a different stress scenario involving a lot of VCPUs
>> and external interrupts?
>
> You could instrument the MPIC code to find out how many loop iterations
> you maxed out on, and compare that to the theoretical maximum.

Numbers are pretty low, and I'll try to explain based on my observations.

The problematic section in openpic_update_irq is this [1], since it loops 
through all VCPUs, and IRQ_local_pipe further calls IRQ_check, which loops 
through all pending interrupts for a VCPU [2].

The guest interfaces are virtio-vhostnet, which are based on MSI 
(/proc/interrupts in guest shows they are MSI). For external interrupts to the 
guest, the irq_source destmask is currently 0, and last_cpu is 0 (unitialized), 
so [1] will go on and deliver the interrupt directly and unicast (no VCPUs loop).

I activated the pr_debugs in arch/powerpc/kvm/mpic.c, to see how many interrupts 
are actually pending for the destination VCPU. At most, there were 3 interrupts 
- n_IRQ = {224,225,226} - even for 24 flows of ping flood. I understand that 
guest virtio interrupts are cascaded over 1 or a couple of shared MSI interrupts.

So worst case, in this scenario, was checking the priorities for 3 pending 
interrupts for 1 VCPU. Something like this (some of my prints included):

[61010.582033] openpic_update_irq: destmask 1 last_cpu 0
[61010.582034] openpic_update_irq: Only one CPU is allowed to receive this IRQ
[61010.582036] IRQ_local_pipe: IRQ 224 active 0 was 1
[61010.582037] IRQ_check: irq 226 set ivpr_pr=8 pr=-1
[61010.582038] IRQ_check: irq 225 set ivpr_pr=8 pr=-1
[61010.582039] IRQ_check: irq 224 set ivpr_pr=8 pr=-1

It would be really helpful to get your comments regarding whether these are 
realistical number for everyday use, or they are relevant only to this 
particular scenario.

- Can these interrupts be used in directed delivery, so that the destination 
mask can include multiple VCPUs? The MPIC manual states that timer and IPI 
interrupts are supported for directed delivery, altough I'm not sure how much of 
this is used in the emulation. I know that kvmppc uses the decrementer outside 
of the MPIC.

- How are virtio interrupts cascaded over the shared MSI interrupts? 
/proc/device-tree/soc@e0000000/msi@41600/interrupts in the guest shows 8 values 
- 224 - 231 - so at most there might be 8 pending interrupts in IRQ_check, is 
that correct?

Looking forward to your feedback.

[1] http://lxr.free-electrons.com/source/arch/powerpc/kvm/mpic.c#L454
[2] http://lxr.free-electrons.com/source/arch/powerpc/kvm/mpic.c#L303
[3] 
https://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/F27971551C9EED8E8525774A0048770A/$file/mpic_db_05_16_2011.pdf

Best regards,
Bogdan P.
