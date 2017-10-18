Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHCNk4MLWzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 00:20:38 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IDJbpr008534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 09:20:35 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dp6s4vjfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 09:20:35 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 07:20:34 -0600
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <87r2u2jvfb.fsf@concordia.ellerman.id.au>
 <3507ee2e-00ee-7bd0-36a3-292af5112734@linux.vnet.ibm.com>
 <e5bc893a-03f7-4ca7-4e46-938421dfc1c5@ozlabs.ru>
 <5b7b8e8f-2d16-875f-ef53-ccf593064a53@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 08:20:29 -0500
MIME-Version: 1.0
In-Reply-To: <5b7b8e8f-2d16-875f-ef53-ccf593064a53@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <9893e011-d524-06b6-b041-3f1b24e5f03d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/17 8:36 PM, Alexey Kardashevskiy wrote:
> PowerNV KVM guest is a pseries machine so this code will execute there.
>
The configure sriov path will fail and not enable sriov if resources are
not met. I.e. the IOV Bar is not set in PF IOV Resources, which in this
case gets assigned by firmware.

We have separated the calls to put PowerNV and PSeries as machine dependent
calls. Furthermore, we are adding device node properties in the device tree to identify if
this is an SR-IOV slot on Phyp Pseries platform. Verification will be in place to
distinguish between platforms that support SR-IOV in PSeries.
>> Which is the reason for
>> the separation of calls to the machine dependent stuff.
>>> We also use the pseries platform when running under KVM.
>>>
>>> cheers
>>>
>> If anyone plans to enable SR-IOV on Pseries platform, firmware must provide the
>> resources to enable the VFs and map them with system resources.
> This is what the PowerNV platform does.
Again, we have separated the machine dependent calls to different platforms. In our
case we don't use opal and our dependent on phyp to associate resources.
>
>> A new version
>> of the PAPR Document will be added to document these system resources.
> The guest simply gets yet another PCI device, how is IOV different here?
>
> In regard of EEH, the API does not change afaik, it is up to the hypervisor
> (KVM+QEMU) to handle IOV case correctly.

I don't understand your question entirely, can you rephrase?
