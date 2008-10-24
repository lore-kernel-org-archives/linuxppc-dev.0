Return-Path: <csnook@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 21054DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 02:16:50 +1100 (EST)
Message-ID: <4901E6FB.4070200@redhat.com>
Date: Fri, 24 Oct 2008 11:17:15 -0400
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP
	PPC based systems)
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>
In-Reply-To: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Kumar Gala wrote:
> It appears the default IRQ affinity changes from being just cpu 0 to all 
> cpu's.  This breaks several PPC SMP systems in which only a single 
> processor is allowed to be selected as the destination of the IRQ.
> 
> What is the right answer in fixing this?  Should we:
> 
>     cpumask_t irq_default_affinity = 1;
> 
> instead of
> 
>     cpumask_t irq_default_affinity = CPU_MASK_ALL?

On those systems, perhaps, but not universally.  There's plenty of hardware 
where the physical topology of the machine is abstracted away from the OS, and 
you need to leave the mask wide open and let the APIC figure out where to map 
the IRQs.  Ideally, we should probably make this decision based on the APIC, but 
if there's no PPC hardware that uses this technique, then it would suffice to 
make this arch-specific.

-- Chris
