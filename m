Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDHRK2ThYzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 06:12:44 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9DJC0VK082790
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 15:12:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2djy0dtvyf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 15:12:41 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Fri, 13 Oct 2017 15:12:40 -0400
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Alex Williamson <alex.williamson@redhat.com>,
 Steven Royer <seroyer@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@mellanox.com>, jjalvare@linux.vnet.ibm.com
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 14:12:32 -0500
MIME-Version: 1.0
In-Reply-To: <20171013120558.1a129183@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/13/17 1:05 PM, Alex Williamson wrote:
> On Fri, 13 Oct 2017 07:01:48 -0500
> Steven Royer <seroyer@linux.vnet.ibm.com> wrote:
>
>> On 2017-10-13 06:53, Steven Royer wrote:
>>> On 2017-10-12 22:34, Bjorn Helgaas wrote:
>>>> [+cc Alex, Bodong, Eli, Saeed]
>>>>
>>>> On Thu, Oct 12, 2017 at 02:59:23PM -0500, Bryant G. Ly wrote:
>>>>> On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
>>>>>> On Thu, Oct 12, 2017 at 03:09:53PM +1100, Michael Ellerman wrote:
>>>>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>>>>   
>>>>>>>> On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
>>>>>>>>> This patch adds the machine dependent call for
>>>>>>>>> pcibios_bus_add_device, since the previous patch
>>>>>>>>> separated the calls out between the PowerNV and PowerVM.
>>>>>>>>>
>>>>>>>>> The difference here is that for the PowerVM environment
>>>>>>>>> we do not want match_driver set because in this environment
>>>>>>>>> we do not want the VF device drivers to load immediately, due to
>>>>>>>>> firmware loading the device node when VF device is assigned to the
>>>>>>>>> logical partition.
>>>>>>>>>
>>>>>>>>> This patch will depend on the patch linked below, which is under
>>>>>>>>> review.
>>>>>>>>>
>>>>>>>>> https://patchwork.kernel.org/patch/9882915/
>>>>>>>>>
>>>>>>>>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>>>>>>>>> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
>>>>>>>>> ---
>>>>>>>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++++++
>>>>>>>>>   1 file changed, 24 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>>>>> index 6b812ad990e4..45946ee90985 100644
>>>>>>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>>>>> @@ -64,6 +64,27 @@ static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
>>>>>>>>>   static DEFINE_SPINLOCK(slot_errbuf_lock);
>>>>>>>>>   static int eeh_error_buf_size;
>>>>>>>>> +void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>>>>>>>>> +{
>>>>>>>>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>>>>>> +
>>>>>>>>> +	if (!pdev->is_virtfn)
>>>>>>>>> +		return;
>>>>>>>>> +
>>>>>>>>> +	pdn->device_id  =  pdev->device;
>>>>>>>>> +	pdn->vendor_id  =  pdev->vendor;
>>>>>>>>> +	pdn->class_code =  pdev->class;
>>>>>>>>> +
>>>>>>>>> +	/*
>>>>>>>>> +	 * The following operations will fail if VF's sysfs files
>>>>>>>>> +	 * aren't created or its resources aren't finalized.
>>>>>>>>> +	 */
>>>>>>>>> +	eeh_add_device_early(pdn);
>>>>>>>>> +	eeh_add_device_late(pdev);
>>>>>>>>> +	eeh_sysfs_add_device(pdev);
>>>>>>>>> +	pdev->match_driver = -1;
>>>>>>>> match_driver is a bool, which should be assigned "true" or "false".
>>>>>>> Above he mentioned a dependency on:
>>>>>>>
>>>>>>>    [04/10] PCI: extend pci device match_driver state
>>>>>>>    https://patchwork.kernel.org/patch/9882915/
>>>>>>>
>>>>>>>
>>>>>>> Which makes it an int.
>>>>>> Oh, right, I missed that, thanks.
>>>>>>   
>>>>>>> Or has that patch been rejected or something?
>>>>>> I haven't *rejected* it, but it's low on my priority list, so you
>>>>>> shouldn't depend on it unless it adds functionality you really need.
>>>>>> If I did apply that particular patch, I would want some rework because
>>>>>> it currently obfuscates the match_driver logic.  There's no clue when
>>>>>> reading the code what -1/0/1 mean.
>>>>> So do you prefer enum's? - If so I can make a change for that.
>>>>>> Apparently here you *do* want the "-1 means the PCI core will never
>>>>>> set match_driver to 1" functionality, so maybe you do depend on it.
>>>>> We depend on the patch because we want that ability to never set
>>>>> match_driver,
>>>>> for SRIOV on PowerVM.
>>>> Is this really new PowerVM-specific functionality?  ISTR recent
>>>> discussions
>>>> about inhibiting driver binding in a generic way, e.g.,
>>>> http://lkml.kernel.org/r/1490022874-54718-1-git-send-email-bodong@mellanox.com
>>>>    
>>>>>> If that's the case, how to you ever bind a driver to these VFs?  The
>>>>>> changelog says you don't want VF drivers to load *immediately*, so I
>>>>>> assume you do want them to load eventually.
>>>>>>   
>>>>> The VF's that get dynamically created within the configure SR-IOV
>>>>> call, on the Pseries Platform, wont be matched with a driver. - We
>>>>> do not want it to match.
>>>>>
>>>>> The Power Hypervisor will load the VFs. The VF's will get
>>>>> assigned(by the user) via the HMC or Novalink in this environment
>>>>> which will then trigger PHYP to load the VF device node to the
>>>>> device tree.
>>>> I don't know what it means for the Hypervisor to "load the VFs."  Can
>>>> you explain that in PCI-speak?
>>>>
>>>> The things I know about are:
>>>>
>>>>    - we set PCI_SRIOV_CTRL_VFE in the PF, which enables VFs
>>>>    - now the VFs respond to config accesses
>>>>    - the PCI core enumerates the VFs by reading their config space
>>>>    - the PCI core builds pci_dev structs for the VFs
>>>>    - the PCI core adds these pci_devs to the bus
>>>>    - we try to bind drivers to the VFs
>>>>    - the VF driver probe function may read VF config space and VF BARs
>>>>    - the VF may be assigned to a guest VM
>>>>
>>>> Where does "loading the VFs" fit in?  I don't know what HMC, Novalink,
>>>> or PHYP are.  I don't *need* to know what they are, as long as you can
>>>> explain what's happening in terms of the PCI concepts and generic
>>>> Linux VMs
>>>> and device assignment.
>>>>
>>>> Bjorn
>>> The VFs will be hotplugged into the VM separately from the enable
>>> SR-IOV, so the driver will load as part of the hotplug operation.
>>>
>>> Steve
>> One more point of clarification: when the hotplug happens, the VF will
>> show up on a virtual PCI bus that is not directly correlated to the real
>> PCI bus that the PF is on.  On that virtual PCI bus, the driver will
>> match because it won't be set to -1.
So lets refer to Bjorn's list of things for SRIOV.

   - we set PCI_SRIOV_CTRL_VFE in the PF, which enables VFs
   - now the VFs respond to config accesses
   - the PCI core enumerates the VFs by reading their config space
   - the PCI core builds pci_dev structs for the VFs
   - the PCI core adds these pci_devs to the bus

So everything is the same up to here.
   - we try to bind drivers to the VFs
   - the VF driver probe function may read VF config space and VF BARs
   - the VF may be assigned to a guest VM

PowerVM environment is very different than traditional KVM in terms of SRIOV.
In our environment the VFs are not usable or view-able by the Hosting Partition
in this case Linux. This is a very important point in that the Host CAN NOT
do anything to any of the VFs available.

So like existing way of enabling SRIOV we still rely on the PF driver to
enable VFs - but in this case the attachment phase is done via a user
action via a management console in our case (novalink or hmc) triggered
event that will essentially act like a hotplug.

So in the fine details of that user triggered action the system firmware
will bind the VFs, allowing resources to be allocated to the VF.
- Which essentially does all the attaching as we know it today but is
managed by PHYP not by the kernel.
> I'm pretty lost too, but I think what's being said is that the
> paravirtualized SR-IOV enable creates VFs according to the SR-IOV
> offset and stride capabilities of the PF, but we're supposed to ignore
> those (why are we even creating pci_devs for them?) and the hypervisor
> will actually hotplug the VFs somewhere else.  How's that still
> SR-IOV?  Why wouldn't the hypervisor just add the real VFs that we're
> supposed to use at the offset and stride indicated by the PF SR-IOV
> capability and mask the VFs that we're not supposed to see?  Thanks,
>
> Alex
>
In our current environment (PSeries) we still need to manage the VFs say
when doing error recovery. Therefore, we need pci_devs to be mapped
to system resources in this case a PE (Partitionable Endpoint).
There are more patches that will map the system resources to a pci_dn
structure. This patch was merely the start of separating PowerVM
and PowerNV configure sriov call.

-Bryant
