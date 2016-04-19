Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpybj49b3zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:19:29 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id er2so4415554pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:19:29 -0700 (PDT)
Subject: Re: [PATCH v8 30/45] powerpc/pci: Delay populating pdn
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-31-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715EA08.3040901@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:19:20 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-31-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> The pdn (struct pci_dn) instances are allocated from memblock or
> bootmem when creating PCI controller (hoses) in setup_arch(). PCI
> hotplug, which will be supported by proceeding patches, releases
> PCI device nodes and their corresponding pdn on unplugging event.
> The memory chunks for pdn instances allocated from memblock or
> bootmem are hard to reused after being released.
>
> This delays creating pdn by pci_devs_phb_init() from setup_arch()
> to core_initcall() so that they are allocated from slab. The memory
> consumed by pdn can be released to system without problem during
> PCI unplugging time. It indicates that pci_dn is unavailable in
> setup_arch() and the the fixup on pdn (like AGP's) can't be carried
> out that time. We have to do that in ppc_md.pcibios_root_bridge_prepare()
> on maple/pasemi/powermac platforms where/when the pdn is available.
>
> At the mean while, the EEH device is created when pdn is populated,
> meaning pdn and EEH device have same life cycle. In turn, we needn't
> call eeh_dev_init() to create EEH device explicitly.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Uff. It would not hurt to mention that  pcibios_root_bridge_prepare is 
called from subsys_initcall() which is executed after core_initcall() so 
the code flow does not change.

Have you checked if there is anything in between 
core_initcall(pci_devs_phb_init) and subsys_initcall(pcibios_init) which 
might need device tree nodes? For example, subsys_initcall(pcibios_init) 
calls (eventually) pnv_pci_ioda_fixup(), if we are unlucky and 
pcibios_init() (and therefore pnv_pci_ioda_fixup() or what pseries/others 
do) is called before pcibios_init() - won't we crash or something?




-- 
Alexey
