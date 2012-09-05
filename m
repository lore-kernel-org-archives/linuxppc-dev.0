Return-Path: <aik@ozlabs.ru>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DBF972C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 10:55:22 +1000 (EST)
Received: by dajt11 with SMTP id t11so4655644daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2012 17:55:20 -0700 (PDT)
Message-ID: <5046A2F1.1020004@ozlabs.ru>
Date: Wed, 05 Sep 2012 10:55:13 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc-powernv: align BARs to PAGE_SIZE on powernv
 platform
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
 <1346787940.3025.11.camel@pasglop>
In-Reply-To: <1346787940.3025.11.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/12 05:45, Benjamin Herrenschmidt wrote:
> On Tue, 2012-09-04 at 17:36 +1000, Alexey Kardashevskiy wrote:
>> VFIO adds a separate memory region for every BAR and tries
>> to mmap() it to provide direct BAR mapping to the guest.
>> If it succeedes, QEMU registers this address with kvm_set_phys_mem().
>> However it is not always possible because such a BAR should
>> be host page size aligned. In this case VFIO uses "slow" path
>> and emulated BAR access in QEMU.
>>
>> In order to avoid "slow" path, BARs have to be PAGE_SIZE aligned
>> in the host kernel and this is what the patch does.
>>
>> The patch adds powernv platform specific hook which makes all
>> BARs sizes 64K aligned. The pci_reassigndev_resource_alignment()
>> function from drivers/pci/pci.c has been used as a reference.
>>
>> This is purely an optimization patch, the things will work without
>> it, just a bit slower.
>
> It's still bad in more ways that I care to explain...

Well it is right before pci_reassigndev_resource_alignment() which is 
common and does the same thing.

> The main one is that you do the "fixup" in a very wrong place anyway and
> it might cause cases of overlapping BARs.

As far as I can tell it may only happen if someone tries to align resource 
via kernel command line.

But ok. I trust you :)

> In any case this is wrong. It's a VFIO design bug and needs to be fixed
> there (CC'ing Alex).

It can be fixed in VFIO only if VFIO will stop treating functions 
separately and start mapping group's MMIO space as a whole thing. But this 
is not going to happen.

The example of the problem is NEC USB PCI which has 3 functions, each has 
one BAR, these BARs are 4K aligned and I cannot see how it can be fixed 
with 64K page size and VFIO creating memory regions per BAR (not per PHB).


> IE. We need a way to know where the BAR is within a page at which point
> VFIO can still map the page, but can also properly take into account the
> offset.

It is not about VFIO, it is about KVM. I cannot put non-aligned page to 
kvm_set_phys_mem(). Cannot understand how we would solve this.


You better discuss it with David, my vocab is weak.



> We also need a way to tell VFIO userspace that it's OK to use the fast
> path for such small BARs. It's not for all host platforms. We know it's
> ok for PowerNV because we know the devices are grouped by PEs and the PE
> granularity is larger than a page but that's not necessarily going to be
> the case on all powerpc platforms that support KVM.
>
> Cheers,
> Ben.
>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/platforms/powernv/setup.c |   26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>> index db1ad1c..331838e 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/of.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/bug.h>
>> +#include <linux/pci.h>
>>
>>   #include <asm/machdep.h>
>>   #include <asm/firmware.h>
>> @@ -179,6 +180,30 @@ static int __init pnv_probe(void)
>>   	return 1;
>>   }
>>
>> +static void pnv_pcibios_fixup_resources(struct pci_dev *pdev)
>> +{
>> +	struct resource *r;
>> +	int i;
>> +
>> +	/*
>> +	 * Aligning resources to PAGE_SIZE in order to
>> +	 * support "fast" path for PCI BAR access under VFIO
>> +	 * which maps every BAR individually to the guest
>> +	 * so BARs have to be PAGE aligned.
>> +	 */
>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>> +		r = &pdev->resource[i];
>> +		if (!r->flags)
>> +			continue;
>> +		pr_debug("powernv: %s, aligning BAR#%d %llx..%llx",
>> +			pdev->dev.kobj.name, i, r->start, r->end);
>> +		r->end = PAGE_ALIGN(r->end - r->start + 1) - 1;
>> +		r->start = 0;
>> +		r->flags |= IORESOURCE_UNSET;
>> +		pr_debug(" to  %llx..%llx\n", r->start, r->end);
>> +	}
>> +}
>> +
>>   define_machine(powernv) {
>>   	.name			= "PowerNV",
>>   	.probe			= pnv_probe,
>> @@ -189,6 +214,7 @@ define_machine(powernv) {
>>   	.progress		= pnv_progress,
>>   	.power_save             = power7_idle,
>>   	.calibrate_decr		= generic_calibrate_decr,
>> +	.pcibios_fixup_resources= pnv_pcibios_fixup_resources,
>>   #ifdef CONFIG_KEXEC
>>   	.kexec_cpu_down		= pnv_kexec_cpu_down,
>>   #endif
>
>


-- 
Alexey
