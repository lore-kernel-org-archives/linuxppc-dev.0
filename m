Return-Path: <kevin.tian@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r5YnK0gqZzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 12:33:24 +1000 (AEST)
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
Date: Fri, 13 May 2016 02:33:18 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F853FA4@SHSMSX101.ccr.corp.intel.com>
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
In-Reply-To: <20160512114735.7ec61bd3@t450s.home>
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

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, May 13, 2016 1:48 AM
>=20
> On Thu, 12 May 2016 04:53:19 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Thursday, May 12, 2016 10:21 AM
> > >
> > > On Thu, 12 May 2016 01:19:44 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > > Sent: Wednesday, May 11, 2016 11:54 PM
> > > > >
> > > > > On Wed, 11 May 2016 06:29:06 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >
> > > > > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > > > > Sent: Thursday, May 05, 2016 11:05 PM
> > > > > > >
> > > > > > > On Thu, 5 May 2016 12:15:46 +0000
> > > > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > > > >
> > > > > > > > > From: Yongji Xie [mailto:xyjxie@linux.vnet.ibm.com]
> > > > > > > > > Sent: Thursday, May 05, 2016 7:43 PM
> > > > > > > > >
> > > > > > > > > Hi David and Kevin,
> > > > > > > > >
> > > > > > > > > On 2016/5/5 17:54, David Laight wrote:
> > > > > > > > >
> > > > > > > > > > From: Tian, Kevin
> > > > > > > > > >> Sent: 05 May 2016 10:37
> > > > > > > > > > ...
> > > > > > > > > >>> Acutually, we are not aimed at accessing MSI-X table =
from
> > > > > > > > > >>> guest. So I think it's safe to passthrough MSI-X tabl=
e if we
> > > > > > > > > >>> can make sure guest kernel would not touch MSI-X tabl=
e in
> > > > > > > > > >>> normal code path such as para-virtualized guest kerne=
l on PPC64.
> > > > > > > > > >>>
> > > > > > > > > >> Then how do you prevent malicious guest kernel accessi=
ng it?
> > > > > > > > > > Or a malicious guest driver for an ethernet card settin=
g up
> > > > > > > > > > the receive buffer ring to contain a single word entry =
that
> > > > > > > > > > contains the address associated with an MSI-X interrupt=
 and
> > > > > > > > > > then using a loopback mode to cause a specific packet b=
e
> > > > > > > > > > received that writes the required word through that add=
ress.
> > > > > > > > > >
> > > > > > > > > > Remember the PCIe cycle for an interrupt is a normal me=
mory write
> > > > > > > > > > cycle.
> > > > > > > > > >
> > > > > > > > > > 	David
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > If we have enough permission to load a malicious driver o=
r
> > > > > > > > > kernel, we can easily break the guest without exposed
> > > > > > > > > MSI-X table.
> > > > > > > > >
> > > > > > > > > I think it should be safe to expose MSI-X table if we can
> > > > > > > > > make sure that malicious guest driver/kernel can't use
> > > > > > > > > the MSI-X table to break other guest or host. The
> > > > > > > > > capability of IRQ remapping could provide this
> > > > > > > > > kind of protection.
> > > > > > > > >
> > > > > > > >
> > > > > > > > With IRQ remapping it doesn't mean you can pass through MSI=
-X
> > > > > > > > structure to guest. I know actual IRQ remapping might be pl=
atform
> > > > > > > > specific, but at least for Intel VT-d specification, MSI-X =
entry must
> > > > > > > > be configured with a remappable format by host kernel which
> > > > > > > > contains an index into IRQ remapping table. The index will =
find a
> > > > > > > > IRQ remapping entry which controls interrupt routing for a =
specific
> > > > > > > > device. If you allow a malicious program random index into =
MSI-X
> > > > > > > > entry of assigned device, the hole is obvious...
> > > > > > > >
> > > > > > > > Above might make sense only for a IRQ remapping implementat=
ion
> > > > > > > > which doesn't rely on extended MSI-X format (e.g. simply ba=
sed on
> > > > > > > > BDF). If that's the case for PPC, then you should build MSI=
-X
> > > > > > > > passthrough based on this fact instead of general IRQ remap=
ping
> > > > > > > > enabled or not.
> > > > > > >
> > > > > > > I don't think anyone is expecting that we can expose the MSI-=
X vector
> > > > > > > table to the guest and the guest can make direct use of it.  =
The end
> > > > > > > goal here is that the guest on a power system is already
> > > > > > > paravirtualized to not program the device MSI-X by directly w=
riting to
> > > > > > > the MSI-X vector table.  They have hypercalls for this since =
they
> > > > > > > always run virtualized.  Therefore a) they never intend to to=
uch the
> > > > > > > MSI-X vector table and b) they have sufficient isolation that=
 a guest
> > > > > > > can only hurt itself by doing so.
> > > > > > >
> > > > > > > On x86 we don't have a), our method of programming the MSI-X =
vector
> > > > > > > table is to directly write to it. Therefore we will always re=
quire QEMU
> > > > > > > to place a MemoryRegion over the vector table to intercept th=
ose
> > > > > > > accesses.  However with interrupt remapping, we do have b) on=
 x86, which
> > > > > > > means that we don't need to be so strict in disallowing user =
accesses
> > > > > > > to the MSI-X vector table.  It's not useful for configuring M=
SI-X on
> > > > > > > the device, but the user should only be able to hurt themselv=
es by
> > > > > > > writing it directly.  x86 doesn't really get anything out of =
this
> > > > > > > change, but it helps this special case on power pretty signif=
icantly
> > > > > > > aiui.  Thanks,
> > > > > > >
> > > > > >
> > > > > > Allowing guest direct write to MSI-x table has system-wide impa=
ct.
> > > > > > As I explained earlier, hypervisor needs to control "interrupt_=
index"
> > > > > > programmed in MSI-X entry, which is used to associate a specifi=
c
> > > > > > IRQ remapping entry. Now if you expose whole MSI-x table to gue=
st,
> > > > > > it can program random index into MSI-X entry to associate with
> > > > > > any IRQ remapping entry and then there won't be any isolation p=
er se.
> > > > > >
> > > > > > You can check "5.5.2 MSI and MSI-X Register Programming" in VT-=
d
> > > > > > spec.
> > > > >
> > > > > I think you're extrapolating beyond the vfio interface.  The chan=
ge
> > > > > here is to remove the vfio protection of the MSI-X vector table w=
hen
> > > > > the system provides interrupt isolation.  The argument is that th=
is is
> > > > > safe to do because the hardware protects the host from erroneous =
and
> > > > > malicious user programming, but it is not meant to provide a mean=
s to
> > > > > program MSI-X directly through the vector table.  This is effecti=
vely
> > > >
> > > > Sorry I didn't get this point. Once we allow userspace to mmap MSI-=
X
> > > > table, isn't it equivalent to allowing userspace directly program v=
ector
> > > > table? Or is there other mechanism to prevent direct programming?
> > >
> > > This would remove the mechanism that prevents direct programming.
> > > Users can configure the device to perform DMA w/o setting up an IOMMU
> > > mapping, which generates a fault.  Users can incorrectly manipulate t=
he
> > > MSI-X vector table instead of using the proper vfio programming
> > > interface, which generates a fault.
> > >
> > > > > the same as general DMA programming, if the vfio programming mode=
l is
> > > > > not followed the device generates iommu faults.  I do have a conc=
ern
> > > > > that userspace driver writers are going to more often presume the=
y can
> > > > > use the vector table directly because of this change, but I don't=
 know
> > > > > that that is sufficient reason to prevent such a change.  They'll
> > > > > quickly discover the device generates faults on interrupt rather =
than
> > > > > working as expected.
> > > >
> > > > If userspace can actually program vector table directly, there is n=
ot
> > > > always fault triggered. As long as MSI-X table is fully under contr=
ol
> > > > of userspace, any interrupt index can be used here which may link
> > > > to a IRQ remapping entry allocated for other devices.
> > >
> > > Is not part of the vector lookup comparing the source ID of the DMA
> > > write?  If not then VT-d interrupt remapping offers us no protection
> > > from a malicious guest performing DMA to the same address.  Thanks,
> > >
> >
> > For x86 IRQ remapping doesn't rely on existing DMAR remapping table for
> > DMA. Instead IRQ remapping table is a global table per VT-d engine, sha=
red
> > by all devices behind this VT-d engine. Each IRQ remapping table entry
> > (IRTE) can specify:
> >
> > - whether to validate source-id of the interrupt requests;
> > - whether to verify the whole source id;
> > - whether to verify some bits of the source id;
> > ...
> > (section 9.10 Interrupt Remapping Table Entry (IRTE) in VT-d spec)
> >
> > IRTE index is programmed into corresponding MSI-X entry of a device.
> > When an interrupt message is triggered from that device, IRQ remapping
> > hardware will use the index to find the IRTE entry.
> >
> > As long as host kernel has strict control of MSI-X table, it can choose=
 to
> > not validate source-id as long as IRTE index is trusted.
> >
> > That is why I concerned you cannot do this simply based on whether
> > IRQ remapping is available on x86. If such usage is really required,
> > you'll need some more accurate indicator per iommu structure to tell
> > whether safe to allow mmap MSI-X to user space.
>=20
> As argued previously in this thread, there's nothing special about a
> DMA write to memory versus a DMA write to a special address that
> triggers an MSI vector.  If the device is DMA capable, which we assume
> all are, it can be fooled into generating those DMA writes regardless
> of whether we actively block access to the MSI-X vector table itself.

But with DMA remapping above can be blocked.

>=20
> With respect to the IRTE, these entries are always under host control,
> and aside from the potential opt-in gap when using the intremap=3Dnosid
> boot option, they always make use of source-id validation as Linux is
> written today.  Compatibility mode support is also disabled.  Nothing
> here changes that.  In fact, I suspect the only advantage to blocking

VFIO as a standalone module shouldn't make assumption on how
IRQ remapping is actually implemented in kernel (especially when
VT-d spec allows no source ID verification).

> MSI-X vector table access w/o interrupt remapping is to avoid obvious
> collisions if it were to be programmed directly, it doesn't actually
> prevent an identical DMA transaction from being generated by other

Kernel can enable DMA remapping but disable IRQ remapping. In such
case identical DMA transaction can be prevented.

> means.  The MSI-X vector table of a device is always considered
> untrusted which is why we require user opt-ins to subvert that
> protection.  Thanks,
>=20

I only partially agree with this statement since there is different
trust level for kernel space driver and user space driver.

OS may choose to trust kernel space driver then it can enable IRQ
remapping only for load balance purpose w/o source id verfification.=20
In such case MSI-X vector table is trusted and fully under kernel=20
control. Allowing to mmap MSI-X table in user space definitely=20
breaks that boundary.

Anyway my point is simple. Let's ignore how Linux kernel implements
IRQ remapping on x86 (which may change time to time), and just
focus on architectural possibility. Non-x86 platform may implement
IRQ remapping completely separate from device side, then checking
availability of IRQ remapping is enough to decide whether mmap
MSI-X table is safe. x86 with VT-d can be configured to a mode
requiring host control of both MSI-X entry and IRQ remapping hardware=20
(without source id check). In such case it's insufficient to make=20
decision simply based on IRQ remapping availability. We need a way=20
to query from IRQ remapping module whether it's actually safe to=20
mmap MSI-X.

Thanks
Kevin
