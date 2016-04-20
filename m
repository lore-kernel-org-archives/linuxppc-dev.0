Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqSh76Gz5zDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:55:03 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id c20so13530985pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:55:03 -0700 (PDT)
Subject: Re: [PATCH v8 30/45] powerpc/pci: Delay populating pdn
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-31-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715EA08.3040901@ozlabs.ru> <20160420021318.GB28594@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5716FD8E.5010700@ozlabs.ru>
Date: Wed, 20 Apr 2016 13:54:54 +1000
MIME-Version: 1.0
In-Reply-To: <20160420021318.GB28594@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2016 12:13 PM, Gavin Shan wrote:
> On Tue, Apr 19, 2016 at 06:19:20PM +1000, Alexey Kardashevskiy wrote:
>> On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>> The pdn (struct pci_dn) instances are allocated from memblock or
>>> bootmem when creating PCI controller (hoses) in setup_arch(). PCI
>>> hotplug, which will be supported by proceeding patches, releases
>>> PCI device nodes and their corresponding pdn on unplugging event.
>>> The memory chunks for pdn instances allocated from memblock or
>>> bootmem are hard to reused after being released.
>>>
>>> This delays creating pdn by pci_devs_phb_init() from setup_arch()
>>> to core_initcall() so that they are allocated from slab. The memory
>>> consumed by pdn can be released to system without problem during
>>> PCI unplugging time. It indicates that pci_dn is unavailable in
>>> setup_arch() and the the fixup on pdn (like AGP's) can't be carried
>>> out that time. We have to do that in ppc_md.pcibios_root_bridge_prepare()
>>> on maple/pasemi/powermac platforms where/when the pdn is available.
>>>
>>> At the mean while, the EEH device is created when pdn is populated,
>>> meaning pdn and EEH device have same life cycle. In turn, we needn't
>>> call eeh_dev_init() to create EEH device explicitly.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>
>> Uff. It would not hurt to mention that  pcibios_root_bridge_prepare is called
>>from subsys_initcall() which is executed after core_initcall() so the code
>> flow does not change.
>>
>
> Yes, will do in next revision.
>
>> Have you checked if there is anything in between
>> core_initcall(pci_devs_phb_init) and subsys_initcall(pcibios_init) which
>> might need device tree nodes? For example, subsys_initcall(pcibios_init)
>> calls (eventually) pnv_pci_ioda_fixup(), if we are unlucky and pcibios_init()
>> (and therefore pnv_pci_ioda_fixup() or what pseries/others do) is called
>> before pcibios_init() - won't we crash or something?
>>
>
> I don't catch what you were asking. device-tree nodes (struct device_node)
> are always there. This patch doesn't affect them. Perhaps you were talking
> about pdn (PCI_DN). If it's the case, this patch delays creating pdn from
> setup_arch() to core_initcall(pci_devs_phb_init).


While thinking of explaining what I wanted to ask, I found my answer :)

pcibios_init() calls ppc_md.pcibios_root_bridge_prepare() first, then 
ppc_md.pcibios_fixup() so we are fine here with ordering.


> I don't see anything need pdn between setup_arch() and core_initcall().
> The changes introduced to powermac/pasemi platforms are: move fixing the child
> pdns of the specifiec PHB's pdn from setup_arch() to subsys_initcall(pcibios_init).
> I don't see anything between them needs the fixed pdns.
>
> I don't understand how pcibios_init() is called before pcibios_init() in your

pcibios_init() is used twice in the sentence above :)

Anyway,


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> context. Sorry for my bad English. Perhaps you're asking the the called sequence
> on core_initcall() and subsys_init()? If so, they're defined like below:
>
> #define core_initcall(fn)		__define_initcall(fn, 1)
> #define subsys_initcall(fn)		__define_initcall(fn, 4)
 >
>
>>
>> --
>> Alexey
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Alexey
