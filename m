Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0069FB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 03:23:13 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p65GpZKY018424
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 12:51:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p65HN9j71708186
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 13:23:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p65HN8eP028144
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 14:23:09 -0300
Message-ID: <4E13486C.3000409@linux.vnet.ibm.com>
Date: Tue, 05 Jul 2011 10:22:52 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
	<4E0E1253.1000909@linux.vnet.ibm.com>
	<BANLkTinTEk2SgBwVUHc49cDLEwH_a-XsJg@mail.gmail.com>
	<4E0E274C.4000402@linux.vnet.ibm.com>	<4E1330A3.8080004@linux.vnet.ibm.com>
	<CAPoiz9wArpezPaovSwKVCX3whGRmbAcYjywKX_dUng7wSeW7KQ@mail.gmail.com>
In-Reply-To: <CAPoiz9wArpezPaovSwKVCX3whGRmbAcYjywKX_dUng7wSeW7KQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: James Smart <james.smart@emulex.com>, linux-pci@vger.kernel.org,
	Anton Blanchard <anton@au1.ibm.com>,
	Richard Lary <rlary@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/5/2011 9:18 AM, Jon Mason wrote:
> On Tue, Jul 5, 2011 at 10:41 AM, Richard A Lary
> <rlary@linux.vnet.ibm.com>  wrote:
>> On 7/1/2011 1:00 PM, Richard A Lary wrote:
>>>
>>> On 7/1/2011 12:02 PM, Jon Mason wrote:
>>>>
>>>> On Fri, Jul 1, 2011 at 1:30 PM, Richard A Lary<rlary@linux.vnet.ibm.com>
>>>> wrote:
>>>>>
>>>>> On 7/1/2011 8:24 AM, Jon Mason wrote:
>>>>>>
>>>>>> I recently sent out a number of patches to migrate drivers calling
>>>>>> `pci_find_capability(pdef, PCI_CAP_ID_EXP)` to pci_pcie_cap. This
>>>>>> function takes uses a PCI-E capability offset that was determined by
>>>>>> calling pci_find_capability during the PCI bus walking. In response
>>>>>> to one of the patches, James Smart posted:
>>>>>>
>>>>>> "The reason is due to an issue on PPC platforms whereby use of
>>>>>> "pdev->is_pcie" and pci_is_pcie() will erroneously fail under some
>>>>>> conditions, but explicit search for the capability struct via
>>>>>> pci_find_capability() is always successful. I expect this to be due
>>>>>> a shadowing of pci config space in the hal/platform that isn't
>>>>>> sufficiently built up. We detected this issue while testing AER/EEH,
>>>>>> and are functional only if the pci_find_capability() option is used."
>>>>>>
>>>>>> See http://marc.info/?l=linux-scsi&m=130946649427828&w=2 for the whole
>>>>>> post.
>>>>>>
>>>>>> Based on his description above pci_pcie_cap
>>>>>> andpci_find_capability(pdef, PCI_CAP_ID_EXP) should be functionally
>>>>>> equivalent. If this is not safe, then the PCI bus walking code is
>>>>>> most likely busted on EEH enabled PPC systems (and that is a BIG
>>>>>> problem). Can anyone confirm this is still an issue?
>>>>>
>>>>> Jon,
>>>>>
>>>>> I applied the following debug patch to lpfc driver in a 2.6.32 distro
>>>>> kernel ( I had this one handy, I can try with mainline later today )
>>>>>
>>>>> ---
>>>>> drivers/scsi/lpfc/lpfc_init.c | 10 10 + 0 - 0 !
>>>>> 1 file changed, 10 insertions(+)
>>>>>
>>>>> Index: b/drivers/scsi/lpfc/lpfc_init.c
>>>>> ===================================================================
>>>>> --- a/drivers/scsi/lpfc/lpfc_init.c
>>>>> +++ b/drivers/scsi/lpfc/lpfc_init.c
>>>>> @@ -3958,6 +3958,16 @@ lpfc_enable_pci_dev(struct lpfc_hba *phb
>>>>> pci_try_set_mwi(pdev);
>>>>> pci_save_state(pdev);
>>>>>
>>>>> + printk(KERN_WARNING "pcicap: is_pcie=%x pci_cap=%x pcie_type=%x\n",
>>>>> + pdev->is_pcie,
>>>>> + pdev->pcie_cap,
>>>>> + pdev->pcie_type);
>>>>> +
>>>>> + if (pci_is_pcie(pdev))
>>>>> + printk(KERN_WARNING "pcicap: true\n");
>>>>> + else
>>>>> + printk(KERN_WARNING "pcicap: false\n");
>>>>> +
>>>>> /* PCIe EEH recovery on powerpc platforms needs fundamental reset */
>>>>> if (pci_find_capability(pdev, PCI_CAP_ID_EXP))
>>>>> pdev->needs_freset = 1;
>>>>>
>>>>> This is output upon driver load on an IBM Power 7 model 8233-E8B server.
>>>>>
>>>>> dmesg | grep pcicap
>>>>> Linux version 2.6.32.42-pcicap-ppc64 (geeko@buildhost) (gcc version
>>>>> 4.3.4
>>>>> [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 1
>>>>> 09:31:27
>>>>> PDT 2011
>>>>> pcicap: is_pcie=0 pci_cap=0 pcie_type=0
>>>>> pcicap: false
>>>>> pcicap: is_pcie=0 pci_cap=0 pcie_type=0
>>>>> pcicap: false
>>>>> pcicap: is_pcie=0 pci_cap=0 pcie_type=0
>>>>> pcicap: false
>>>>> pcicap: is_pcie=0 pci_cap=0 pcie_type=0
>>>>> pcicap: false
>>>>>
>>>>> It would appear that the pcie information is not set in pci_dev
>>>>> structure
>>>>> for
>>>>> this device at the time the driver is being initialized during boot.
>>>>
>>>> Thanks for trying this. Can you confirm that the other devices in the
>>>> system have this issue as well (or show that it is isolated to the lpr
>>>> device)? You can add printks in set_pcie_port_type() to verify what
>>>> is being set on bus walking and to see when it is being called with
>>>> respect to when it is being populated by firmware.
>>>
>>> Jon,
>>>
>>> I will give this suggestion a try and post results
>>
>> On Power PC platforms, set_pcie_port_type() is not called.  On Power PC,
>> pci_dev structure is initialized by of_create_pci_dev().  However, the
>> structure member pcie_cap is NOT computed nor set in this function.
>
> Yes, it is.  of_create_pci_dev() calls set_pcie_port_type()
> http://lxr.linux.no/linux+v2.6.39/arch/powerpc/kernel/pci_of_scan.c#L144
>
> That function sets pdev->pcie_cap
> http://lxr.linux.no/linux+v2.6.39/drivers/pci/probe.c#L896
>
> So, it should be set.  It looks like there is a bug in
> of_create_pci_dev, as set_pcie_port_type is being called BEFORE the
> BARs are setup.  If you move set_pcie_port_type prior to
> pci_device_add (perhaps even after), then I bet the issue is resolved.
>

The claim above was based upon observation that with this patch applied
to a 2.6.32 kernel, the printk output did not appear in dmesg upon boot.

  static void set_pcie_hotplug_bridge(struct pci_dev *pdev)
@@ -774,6 +780,8 @@ int pci_setup_device(struct pci_dev *dev
         u8 hdr_type;
         struct pci_slot *slot;

+       printk(KERN_WARNING "pcicap: setup_device %p\n", dev);
+
         if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
                 return -EIO;

I can make no claim about my understanding of pci device initialization
on Power PC, so I have added Anton Blanchard to the cc list.

Perhaps Anton can explain why pcie_cap is always 0 on Power PC.

-rich

>
>> The information used to populate pci_dev comes from the Power PC
>> device_tree passed to the OS by Open Firmware.
>>
>> Based upon standing Power PC design, we cannot support patches
>> which replace pci_find_capability(pdef, PCI_CAP_ID_EXP) with
>> pci_is_pcie(pdev) on Power PC platforms.
>>
>> -rich
>>
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
