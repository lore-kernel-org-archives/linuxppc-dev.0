Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGcYl0YYqzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 01:11:22 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HEAL4f009757
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 10:11:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnk97rkt5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 10:11:19 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 10:11:19 -0400
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>, jjalvare@linux.vnet.ibm.com
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <87r2u2jvfb.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 09:11:01 -0500
MIME-Version: 1.0
In-Reply-To: <87r2u2jvfb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <3507ee2e-00ee-7bd0-36a3-292af5112734@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding Juan back into the cc: jjalvare@linux.vnet.ibm.com


On 10/16/17 10:38 PM, Michael Ellerman wrote:
> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>> On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
> ...
>>> If that's the case, how to you ever bind a driver to these VFs?  The
>>> changelog says you don't want VF drivers to load *immediately*, so I
>>> assume you do want them to load eventually.
>>>
>> The VF's that get dynamically created within the configure SR-IOV call, 
>> on the Pseries Platform, wont be matched with a driver. - We do not
>> want it to match.
>>
>> The Power Hypervisor will load the VFs. The VF's will get assigned(by 
>> the user) > via the HMC or Novalink in this environment which will
>> then trigger PHYP to load the VF device node to the device tree.
> What about the other "Power Hypervisor"? ie. KVM running on Power.
This path is only exercised when configuring SR-IOV for Pseries LPAR,
therefore it will not affect PowerNV or KVM(opal). Which is the reason for
the separation of calls to the machine dependent stuff.
> We also use the pseries platform when running under KVM.
>
> cheers
>
If anyone plans to enable SR-IOV on Pseries platform, firmware must provide the
resources to enable the VFs and map them with system resources. A new version
of the PAPR Document will be added to document these system resources. Lastly,
we were not aware that there is an intention to enable SR-IOV in adapters assigned
to a VM with Pseries running on KVM. Furthermore, this could be left as a todo
for the future if this type of configuration is needed.

-Bryant
