Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGvmR5G9dzDrFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 12:36:39 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id g6so2914499pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 18:36:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 jjalvare@linux.vnet.ibm.com
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <87r2u2jvfb.fsf@concordia.ellerman.id.au>
 <3507ee2e-00ee-7bd0-36a3-292af5112734@linux.vnet.ibm.com>
 <e5bc893a-03f7-4ca7-4e46-938421dfc1c5@ozlabs.ru>
Message-ID: <5b7b8e8f-2d16-875f-ef53-ccf593064a53@ozlabs.ru>
Date: Wed, 18 Oct 2017 12:36:30 +1100
MIME-Version: 1.0
In-Reply-To: <e5bc893a-03f7-4ca7-4e46-938421dfc1c5@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/10/17 12:01, Alexey Kardashevskiy wrote:
> On 18/10/17 01:11, Bryant G. Ly wrote:
>> Adding Juan back into the cc: jjalvare@linux.vnet.ibm.com
>>
>>
>> On 10/16/17 10:38 PM, Michael Ellerman wrote:
>>> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>>>> On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
>>> ...
>>>>> If that's the case, how to you ever bind a driver to these VFs?  The
>>>>> changelog says you don't want VF drivers to load *immediately*, so I
>>>>> assume you do want them to load eventually.
>>>>>
>>>> The VF's that get dynamically created within the configure SR-IOV call, 
>>>> on the Pseries Platform, wont be matched with a driver. - We do not
>>>> want it to match.
>>>>
>>>> The Power Hypervisor will load the VFs. The VF's will get assigned(by 
>>>> the user) > via the HMC or Novalink in this environment which will
>>>> then trigger PHYP to load the VF device node to the device tree.
>>> What about the other "Power Hypervisor"? ie. KVM running on Power.
>> This path is only exercised when configuring SR-IOV for Pseries LPAR,
>> therefore it will not affect PowerNV or KVM(opal).
> 
> PowerNV KVM guest is a pseries machine so this code will execute there.
> 
>> Which is the reason for
>> the separation of calls to the machine dependent stuff.
>>> We also use the pseries platform when running under KVM.
>>>
>>> cheers
>>>
>> If anyone plans to enable SR-IOV on Pseries platform, firmware must provide the
>> resources to enable the VFs and map them with system resources.
> 
> This is what the PowerNV platform does.
> 
>> A new version
>> of the PAPR Document will be added to document these system resources.
> 
> The guest simply gets yet another PCI device, how is IOV different here?
> 
> In regard of EEH, the API does not change afaik, it is up to the hypervisor
> (KVM+QEMU) to handle IOV case correctly.
> 
> 
>> Lastly,
>> we were not aware that there is an intention to enable SR-IOV in adapters assigned
>> to a VM with Pseries running on KVM.
> 
> There is no any special enablement of IOV for a VM on powernv, once
> configured in the powernv host, we can just pass VFs to QEMU and therefore
> to a pseries guest, it is just a normal PCI device.
> 
> Do you assign a PF to a VM and create VFs from inside the VM? Or only pHyp
> is allowed to do that? Sorry, I know nothing about pHyp on this matter.
> 

Never mind this last question, I've just read the entire thread about this
hosting partition thing.



-- 
Alexey
