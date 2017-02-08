Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ57M6JJxzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 13:41:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 imunsie@au1.ibm.com
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
In-Reply-To: <20170207235720.GA17605@gwshan>
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
 <871svab6fj.fsf@concordia.ellerman.id.au> <20170207232130.GB10885@gwshan>
 <784859a2-527a-17c6-dbb2-9663b6562846@au1.ibm.com>
 <20170207235720.GA17605@gwshan>
Date: Wed, 08 Feb 2017 13:41:19 +1100
Message-ID: <87poit9zg0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> On Wed, Feb 08, 2017 at 10:39:55AM +1100, Andrew Donnellan wrote:
>>On 08/02/17 10:21, Gavin Shan wrote:
>>>On Tue, Feb 07, 2017 at 10:12:48PM +1100, Michael Ellerman wrote:
>>>>Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>>>
>>>.../...
>>>
>>>>>The effect of this patch is to copy the memory resources from the *real*
>>>>>PHB to the vPHB, as given through the device tree. It shouldn't have any
>>>>>practical effect other than squashing this message.
>>>>
>>>>It sounds a bit backward to me. If we don't need the resources then
>>>>why have them?
>>>>
>>>>If we have code that thinks that's an error, than maybe that's what
>>>>needs fixing, or special casing for the vPHB?
>>>>
>>>
>>>Yeah, vPHB is a special case. There are basically two stages in PCI enumeration:
>>>probing and then resource assignment. vPHB is different from *real* PHB as the
>>>resource assignment is skipped on it. So vPHB doesn't need any resources to be
>>>populated. However, there is a check in probing stage and it's where the warning
>>>message comes from.
>>>
>>>   drivers/misc/cxl/vphb.c::cxl_pci_vphb_add()
>>>   arch/powerpc/kernel/pci-common.c::pcibios_scan_phb()
>>>                                     pcibios_setup_phb_resources()
>>>
>>>   static void pcibios_setup_phb_resources(struct pci_controller *hose,
>>>                                        struct list_head *resources)
>>>   {
>>>       :
>>>       for (i = 0; i < 3; ++i) {
>>>            res = &hose->mem_resources[i];
>>>            if (!res->flags) {
>>>                if (i == 0)
>>>                    printk(KERN_ERR "PCI: Memory resource 0 not set for "
>>>                        "host bridge %s (domain %d)\n",
>>>                        hose->dn->full_name, hose->global_number);
>>>                continue;
>>>            }
>>>       :
>>>   }
>>>
>>>Alternatively, we can replace prink(KERN_ERR) with pr_debug(). It's going to
>>>affect all PHBs including the real ones. Andrew and Michael, what do you think? :-)
>>
>>In what other circumstances do we get this error printed on real PHBs?
>>
>
> When hose->mem_resources[0] isn't built from PHB's device-tree node. It means
> the device-tree node's "ranges" isn't populated correctly by loader and it
> should be very rare ... I never saw it before.

Sounds to me like we could probably just drop the warning. Or make it pr_devel().

cheers
