Return-Path: <elohimes@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vr0Cr4NCFzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 23:36:56 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 79so2798045pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 05:36:55 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all
 PCI devices
Date: Sat, 25 Mar 2017 20:36:52 +0800
Message-Id: <1490445412-4050-1-git-send-email-elohimes@gmail.com>
In-Reply-To: <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2017 at 03:53:42PM -0500, Bjorn Helgaas wrote:
> Hi Yongji,
>
> On Wed, Feb 15, 2017 at 02:45:05PM +0800, Yongji Xie wrote:
>> When vfio passthroughs a PCI device of which MMIO BARs are
>> smaller than PAGE_SIZE, guest will not handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> This is because vfio will not allow to passthrough one BAR's
>> mmio page which may be shared with other BARs. Otherwise,
>> there will be a backdoor that guest can use to access BARs
>> of other guest.
>
> Please include a pointer to the VFIO code that enforces this.  It's
> not obvious to me how it would do this.  This doesn't change the
> *size* of the resource, only the alignment.  So if VFIO sees a BAR
> like [mem 0x80000000-0x800000ff], it knows the BAR is aligned enough
> that it *could* be the only thing on a page, but I don't know how it
> could know that there will never be another BAR at 0x80000100.  Even
> if there's no other BAR on that page *now*, it would have to know that
> no hot-added device will ever be placed on that page.
>
>> This patch adds a macro to set default alignment for all
>> PCI devices. Then we could solve this issue on some platforms
>> which would easily hit this issue because of their 64K page
>> such as PowerNV platform by defining this macro as PAGE_SIZE.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/include/asm/pci.h |    4 ++++
>> drivers/pci/pci.c              |    3 +++
>> 2 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
>> index e9bd6cf..5e31bc2 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -28,6 +28,10 @@
>> #define PCIBIOS_MIN_IO               0x1000
>> #define PCIBIOS_MIN_MEM              0x10000000
>>
>> +#ifdef CONFIG_PPC_POWERNV
>> +#define PCIBIOS_DEFAULT_ALIGNMENT   PAGE_SIZE
>> +#endif
>> +
>> struct pci_dev;
>>
>> /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index a881c0d..2622e9b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4965,6 +4965,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>>      resource_size_t align = 0;
>>      char *p;
>>
>> +#ifdef PCIBIOS_DEFAULT_ALIGNMENT
>> +    align = PCIBIOS_DEFAULT_ALIGNMENT;
>> +#endif
>
> I'd prefer to move this #ifdef out of the code path, as in the patch
> below.
>
> I don't know how powerpc kernels are built: can you build a kernel
> that will run on PowerNV as well as on different powerpc systems?  If
> so, is it acceptable to force that kernel to user 64K alignment even
> when it's running on non-PowerNV systems?  Or do you need a function
> call here instead of a #define?
>

That's a good point, the macro may be also defined on non-PowerNV systems.
Maybe an arch-specific function is more reasonable here.

Thanks,
Yongji
