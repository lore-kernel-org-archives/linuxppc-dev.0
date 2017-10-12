Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yChWl43GCzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 06:59:31 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9CJxFH8046568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:59:28 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2djcq25gxt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:59:28 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Thu, 12 Oct 2017 15:59:28 -0400
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 14:59:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2017 at 03:09:53PM +1100, Michael Ellerman wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>
>>> On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
>>>> This patch adds the machine dependent call for
>>>> pcibios_bus_add_device, since the previous patch
>>>> separated the calls out between the PowerNV and PowerVM.
>>>>
>>>> The difference here is that for the PowerVM environment
>>>> we do not want match_driver set because in this environment
>>>> we do not want the VF device drivers to load immediately, due to
>>>> firmware loading the device node when VF device is assigned to the
>>>> logical partition.
>>>>
>>>> This patch will depend on the patch linked below, which is under
>>>> review.
>>>>
>>>> https://patchwork.kernel.org/patch/9882915/
>>>>
>>>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>>>> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
>>>> ---
>>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++++++
>>>>   1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> index 6b812ad990e4..45946ee90985 100644
>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> @@ -64,6 +64,27 @@ static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
>>>>   static DEFINE_SPINLOCK(slot_errbuf_lock);
>>>>   static int eeh_error_buf_size;
>>>>   
>>>> +void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>> +
>>>> +	if (!pdev->is_virtfn)
>>>> +		return;
>>>> +
>>>> +	pdn->device_id  =  pdev->device;
>>>> +	pdn->vendor_id  =  pdev->vendor;
>>>> +	pdn->class_code =  pdev->class;
>>>> +
>>>> +	/*
>>>> +	 * The following operations will fail if VF's sysfs files
>>>> +	 * aren't created or its resources aren't finalized.
>>>> +	 */
>>>> +	eeh_add_device_early(pdn);
>>>> +	eeh_add_device_late(pdev);
>>>> +	eeh_sysfs_add_device(pdev);
>>>> +	pdev->match_driver = -1;
>>> match_driver is a bool, which should be assigned "true" or "false".
>> Above he mentioned a dependency on:
>>
>>    [04/10] PCI: extend pci device match_driver state
>>    https://patchwork.kernel.org/patch/9882915/
>>
>>
>> Which makes it an int.
> Oh, right, I missed that, thanks.
>
>> Or has that patch been rejected or something?
> I haven't *rejected* it, but it's low on my priority list, so you
> shouldn't depend on it unless it adds functionality you really need.
> If I did apply that particular patch, I would want some rework because
> it currently obfuscates the match_driver logic.  There's no clue when
> reading the code what -1/0/1 mean.
So do you prefer enum's? - If so I can make a change for that.
> Apparently here you *do* want the "-1 means the PCI core will never
> set match_driver to 1" functionality, so maybe you do depend on it.
We depend on the patch because we want that ability to never set 
match_driver,
for SRIOV on PowerVM.
>
> If that's the case, how to you ever bind a driver to these VFs?  The
> changelog says you don't want VF drivers to load *immediately*, so I
> assume you do want them to load eventually.
>
The VF's that get dynamically created within the configure SR-IOV call, 
on the
Pseries Platform, wont be matched with a driver. - We do not want it to 
match.

The Power Hypervisor will load the VFs. The VF's will get assigned(by 
the user)
via the HMC or Novalink in this environment which will then trigger PHYP
to load the VF device node to the device tree.

-Bryant
