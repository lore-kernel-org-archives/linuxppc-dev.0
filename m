Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGLWH1R3tzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 14:38:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
In-Reply-To: <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 14:38:16 +1100
Message-ID: <87r2u2jvfb.fsf@concordia.ellerman.id.au>
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

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
> On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
...
>>
>> If that's the case, how to you ever bind a driver to these VFs?  The
>> changelog says you don't want VF drivers to load *immediately*, so I
>> assume you do want them to load eventually.
>>
> The VF's that get dynamically created within the configure SR-IOV call, 
> on the Pseries Platform, wont be matched with a driver. - We do not
> want it to match.
>
> The Power Hypervisor will load the VFs. The VF's will get assigned(by 
> the user) > via the HMC or Novalink in this environment which will
> then trigger PHYP to load the VF device node to the device tree.

What about the other "Power Hypervisor"? ie. KVM running on Power.

We also use the pseries platform when running under KVM.

cheers
