Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGrbY4F7ZzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 10:13:45 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HNCocX035915
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:13:43 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnswk38pn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:13:42 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 19:13:41 -0400
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steven Royer <seroyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@mellanox.com>
References: <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
 <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
 <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
 <7e23c703-750b-b4f8-f252-0c872a40ae8a@linux.vnet.ibm.com>
 <20171017162621.GB5641@bhelgaas-glaptop.roam.corp.google.com>
 <f8fbbd56-f165-0a17-a24a-2b021f7fa238@linux.vnet.ibm.com>
 <20171017185242.GG5641@bhelgaas-glaptop.roam.corp.google.com>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 18:13:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171017185242.GG5641@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <eb1ac136-a054-ea2b-2368-af740e0c23d4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10/17/17 1:52 PM, Bjorn Helgaas wrote:
> Right.  But that patch isn't really on the path to inclusion (mainly
> because it's test framework and doesn't fix a bug or add support for
> new hardware or features).
I was not aware of this decision and this will cause changes to this patch.
>
> I'm suggesting that maybe there should be a generic way to prevent
> binding to VF devices that works for everybody and doesn't require any
> arch-specific code at all.

The patch that you have suggested in kernel 4.12 is also a generic way.

https://marc.info/?l=linux-kernel&m=149002335105804&w=2

Perhaps we can use the same constructs that this patch uses at our level. Nonetheless,
that will take a rework to this patch and possibly an export of a function to set drivers_autoprobe
globally. I know that was frowned upon on first email thread. Let me know if this is an
acceptable solution.
>>>>>> So like existing way of enabling SRIOV we still rely on the PF driver to
>>>>>> enable VFs - but in this case the attachment phase is done via a user
>>>>>> action via a management console in our case (novalink or hmc) triggered
>>>>>> event that will essentially act like a hotplug.
>>>>>>
>>>>>> So in the fine details of that user triggered action the system
>>>>>> firmware will bind the VFs, allowing resources to be allocated to
>>>>>> the VF.  - Which essentially does all the attaching as we know it
>>>>>> today but is managed by PHYP not by the kernel.
>>>>> What exactly does "firmware binding the VFs" mean?  I guess this must
>>>>> mean assigning a VF to a partition, injecting a hotplug add event to
>>>>> that partition, and making the VF visible in config space?
>>>> Firmware basically adds a device node to the device tree as defined
>>>> in the (PAPR) Power Architecture Platform Requirements document.
>>> From the point of view of the kernel that consumes this device tree
>>> and owns the VF, I guess this looks like a hot-add.  
>> Correct, this is intended. We want to minimize change and only focus
>> on configure SR-IOV path in the PF on PSeries platform.
>>> It would be nice
>>> if this could be exposed to that kernel by having the firmware inject
>>> a normal PCIe hotplug interrupt, but I'm guessing it's not that
>>> simple.
>> I don't understand entirely your suggestion. However, in the case of
>> interrupts PHYP owns all the resources and will be associated accordingly
>> with a partitionable endpoint (PE).
> Assume you have a Linux kernel, and PHYP assigns a VF to it.  What
> happens in that Linux kernel? 

When  kernel boots it goes through the lists of buses in the device tree. For each (physical,virtual)
bus the kernel reads the list of devices. After resources are read and assigned it will probe the devices.

If the kernel is up and running then this will start its flow through the dlpar add bus code.
Which then will read the device node and same operation as boot will entail of going
through the list of devices under the bus.

One should note that dynamically created VFs in configure SR-IOV path will have is_virtfn
set and others do not, therefore pcibios_bus_add_device will only be exercised in certain
cases.
>  How does it discover this new device?
This is treated as a normal hot plug operation for the Operating System that
the device gets assigned which can be  IBMi, AIX or Linux in this environment.
>
> I'm suggesting that it would be cool if that kernel received a hotplug
> interrupt from the Downstream Port leading to the new VF, and the
> pciehp driver could read the Slot Status register and see that
> "Presence Detect Changed" was set.  If that happened, the pciehp
> driver should automatically enumerate the new device and there
> wouldn't be much if any powerpc-specific code in the path.
To re-state Steve's earlier comment, PHYP will enumerate the virtual pci bus and is not
directly correlated to the real PCI bus that the PF is on. We have no control of the pci
bus enumeration for the device node added to the device tree.

Juan J. Alvarez
