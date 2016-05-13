Return-Path: <kevin.tian@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r5Ys52gtyzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 12:36:41 +1000 (AEST)
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Yongji Xie <xyjxie@linux.vnet.ibm.com>, David Laight
 <David.Laight@ACULAB.COM>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "joro@8bytes.org" <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Fri, 13 May 2016 02:36:27 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F853FC5@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
 <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
 <20160505090513.56886c12@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F84EEBA@SHSMSX101.ccr.corp.intel.com>
 <20160511095331.18436241@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F850046@SHSMSX101.ccr.corp.intel.com>
 <20160511202042.77593861@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8507E8@SHSMSX101.ccr.corp.intel.com>
 <20160512114735.7ec61bd3@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Tian, Kevin
> Sent: Friday, May 13, 2016 10:33 AM
>=20
> > means.  The MSI-X vector table of a device is always considered
> > untrusted which is why we require user opt-ins to subvert that
> > protection.  Thanks,
> >
>=20
> I only partially agree with this statement since there is different
> trust level for kernel space driver and user space driver.
>=20
> OS may choose to trust kernel space driver then it can enable IRQ
> remapping only for load balance purpose w/o source id verfification.
> In such case MSI-X vector table is trusted and fully under kernel
> control. Allowing to mmap MSI-X table in user space definitely
> breaks that boundary.
>=20
> Anyway my point is simple. Let's ignore how Linux kernel implements
> IRQ remapping on x86 (which may change time to time), and just
> focus on architectural possibility. Non-x86 platform may implement
> IRQ remapping completely separate from device side, then checking
> availability of IRQ remapping is enough to decide whether mmap
> MSI-X table is safe. x86 with VT-d can be configured to a mode
> requiring host control of both MSI-X entry and IRQ remapping hardware
> (without source id check). In such case it's insufficient to make
> decision simply based on IRQ remapping availability. We need a way
> to query from IRQ remapping module whether it's actually safe to
> mmap MSI-X.
>=20

Or another way is to have VFIO explicitly request intel-iommu to
enforce sid check when IRQ remapping is enabled...

Thanks
Kevin
