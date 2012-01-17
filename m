Return-Path: <mbohan@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine02.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DAA981007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 13:53:50 +1100 (EST)
Message-ID: <4F14E05C.30207@codeaurora.org>
Date: Mon, 16 Jan 2012 18:43:40 -0800
From: Michael Bohan <mbohan@codeaurora.org>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com>
In-Reply-To: <4F0F7B60.5040701@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/12/2012 4:31 PM, Rob Herring wrote:
> You have removed the irq_alloc_descs call from the GIC which is a step
> backwards. Several of the ARM DT enabled platforms are at the point they
> can fully support dynamic virq base for each irqchip. I changed the
> domain from legacy to linear and got things working. The issue with
> linear is for SPARSE_IRQ. The default behavior on ARM for SPARSE_IRQ is
> all nr_irqs are allocated at boot time before any controller is
> initialized. The only platform with a GIC and requiring SPARSE_IRQ is
> shmobile, but it is also the only one that calls irq_alloc_desc
> functions for it's interrupts. So I think we are okay there. The problem
> occurs when enabling SPARSE_IRQ for a non-DT platform with a GIC and
> with irqchips that don't call irq_alloc_desc for their irqs. IMHO, this
> should be an okay trade-off. There's no advantage to enabling SPARSE_IRQ
> on ARM for platforms that don't require it. All the platforms with a GIC
> have active work to convert to DT (except shmobile which I think is
> okay), so it's a temporary issue.

I thought I would chime in here since this is very relevant to what 
we're doing on arm-msm. We are using Device Tree with the GIC. We also 
have several other interrupt chips, including one for a device that 
supports up to 32768 sparsely populated interrupts. Hence we are using 
SPARSE_IRQ to only allocate irq_descs on demand for this device.

To support this, I had to modify irq_domain_add() to not 'register' the 
domain. Eg. simply add the domain to the list, but do not initialize the 
hwirq values in the irq_data structure. This is because our irq_descs 
are allocated later based on Device Tree topology. This information is 
not available during of_irq_init().

But then I was left with the problem of managing irq_bases for multiple 
chip drivers. The problem with irq_alloc_desc() is that it doesn't allow 
you to allocate a range without allocating its corresponding resources. 
Meaning, I'd like to reserve a chunk of virqs, but not utilize any 
resources for them until I know they're necessary. This is where 
irq_domains comes in.

In order to support this properly, I decided it made sense to add a new 
API called irq_domain_find_free_range(). This walks the irq domains 
list, now sorted by domain->irq_base, to find the first available range 
of the size specified. Thus every irq chip then only needs to know the 
worst case number of interrupts it could ever support. The framework 
takes care of finding the specific virq base. And all of this 
information is available at of_irq_init() time. This all assumes that 
every chip driver registers with irq_domains.

I was planning on sending these patches out, but it seems like with 
Grant's patches, they may no longer be up to date. I was curious if any 
thought was given to supporting configurations like this the one I 
mentioned with the advent of these patches. I am happy to help test if 
you can steer me in the right direction.

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
