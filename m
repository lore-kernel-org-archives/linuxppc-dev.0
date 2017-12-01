Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypCFp23VmzDrpv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 22:48:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, helgaas@kernel.org,
 bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, aik@ozlabs.ru, ruscur@russell.cc
Subject: Re: [PATCH v5 0/3] Prepartion for SR-IOV PowerVM Enablement
In-Reply-To: <8f9ebacd-5e4e-a6d3-b1c2-dcf9bd0ea811@linux.vnet.ibm.com>
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
 <8f9ebacd-5e4e-a6d3-b1c2-dcf9bd0ea811@linux.vnet.ibm.com>
Date: Fri, 01 Dec 2017 22:48:09 +1100
Message-ID: <87k1y6breu.fsf@concordia.ellerman.id.au>
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

> On 11/9/17 8:00 AM, Bryant G. Ly wrote:
>
>> v1 - Initial patch
>> v2 - Addressed Bjorn's comment on creating a highly platform
>>      dependent global exported symbol.
>> v3 - Based patch off linux-ppc/master
>> v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request
>> v5 - Fixed comments and commit message
>>
>> Bryant G. Ly (3):
>>   powerpc/kernel: Separate SR-IOV Calls
>>   pseries: Add PSeries SR-IOV Machine dependent calls
>>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
>>
>>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>>  arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
>>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
>>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/pci.c         | 31 ++++++++++++++++++++++----
>>  drivers/pci/iov.c                            | 11 ++++++++++
>>  include/linux/pci.h                          |  2 ++
>>  11 files changed, 118 insertions(+), 33 deletions(-)
>>
> Hi Mike,
>
> Any updates on when this is going to get pulled? I want to submit the full SR-IOV enablement on PowerVM,
> but I haven't seen this get merged into 4.15 yet.

Hi Bryant,

Sorry but this was too late for 4.15.

Timing wise it will be fine for 4.16, though I still have to convince
myself that what you're doing will work for pseries on KVM.

It would be good to get an ack from Alexey and Russell (added to CC).

cheers
