Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGc6l6CX7zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 00:51:27 +1100 (AEDT)
Date: Tue, 17 Oct 2017 08:51:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steven Royer <seroyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@mellanox.com>, jjalvare@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
Message-ID: <20171017135123.GA5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
 <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <88eab212351a662dda330071d9afe9dc@linux.vnet.ibm.com>
 <11c15c773aefcc0490e197051c2eaf41@linux.vnet.ibm.com>
 <20171013120558.1a129183@t450s.home>
 <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <24fdec01-8df4-f027-0b3c-0472a2d73946@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 13, 2017 at 02:12:32PM -0500, Bryant G. Ly wrote:
> 
> 
> On 10/13/17 1:05 PM, Alex Williamson wrote:
> >On Fri, 13 Oct 2017 07:01:48 -0500
> >Steven Royer <seroyer@linux.vnet.ibm.com> wrote:
> >
> >>On 2017-10-13 06:53, Steven Royer wrote:
> >>>On 2017-10-12 22:34, Bjorn Helgaas wrote:
> >>>>[+cc Alex, Bodong, Eli, Saeed]
> >>>>
> >>>>On Thu, Oct 12, 2017 at 02:59:23PM -0500, Bryant G. Ly wrote:
> >>>>>On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
> >>>>>>On Thu, Oct 12, 2017 at 03:09:53PM +1100, Michael Ellerman wrote:
> >>>>>>>Bjorn Helgaas <helgaas@kernel.org> writes:
> >>>>>>>>On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
> >>>>>>reading the code what -1/0/1 mean.

> >>>>>>Apparently here you *do* want the "-1 means the PCI core will never
> >>>>>>set match_driver to 1" functionality, so maybe you do depend on it.
> >>>>>We depend on the patch because we want that ability to never set
> >>>>>match_driver,
> >>>>>for SRIOV on PowerVM.
> >>>>Is this really new PowerVM-specific functionality?  ISTR recent
> >>>>discussions
> >>>>about inhibiting driver binding in a generic way, e.g.,
> >>>>http://lkml.kernel.org/r/1490022874-54718-1-git-send-email-bodong@mellanox.com
> >>>>>>If that's the case, how to you ever bind a driver to these VFs?  The
> >>>>>>changelog says you don't want VF drivers to load *immediately*, so I
> >>>>>>assume you do want them to load eventually.
> >>>>>The VF's that get dynamically created within the configure SR-IOV
> >>>>>call, on the Pseries Platform, wont be matched with a driver. - We
> >>>>>do not want it to match.
> >>>>>
> >>>>>The Power Hypervisor will load the VFs. The VF's will get
> >>>>>assigned(by the user) via the HMC or Novalink in this environment
> >>>>>which will then trigger PHYP to load the VF device node to the
> >>>>>device tree.
> >>>>I don't know what it means for the Hypervisor to "load the VFs."  Can
> >>>>you explain that in PCI-speak?
> >>>>
> >>>>The things I know about are:
> >>>>
> >>>>   - we set PCI_SRIOV_CTRL_VFE in the PF, which enables VFs
> >>>>   - now the VFs respond to config accesses
> >>>>   - the PCI core enumerates the VFs by reading their config space
> >>>>   - the PCI core builds pci_dev structs for the VFs
> >>>>   - the PCI core adds these pci_devs to the bus
> >>>>   - we try to bind drivers to the VFs
> >>>>   - the VF driver probe function may read VF config space and VF BARs
> >>>>   - the VF may be assigned to a guest VM
> >>>>
> >>>>Where does "loading the VFs" fit in?  I don't know what HMC, Novalink,
> >>>>or PHYP are.  I don't *need* to know what they are, as long as you can
> >>>>explain what's happening in terms of the PCI concepts and generic
> >>>>Linux VMs
> >>>>and device assignment.
> >>>>
> >>>>Bjorn
> >>>The VFs will be hotplugged into the VM separately from the enable
> >>>SR-IOV, so the driver will load as part of the hotplug operation.
> >>>
> >>>Steve
> >>One more point of clarification: when the hotplug happens, the VF will
> >>show up on a virtual PCI bus that is not directly correlated to the real
> >>PCI bus that the PF is on.  On that virtual PCI bus, the driver will
> >>match because it won't be set to -1.
> So lets refer to Bjorn's list of things for SRIOV.
> 
>   - we set PCI_SRIOV_CTRL_VFE in the PF, which enables VFs
>   - now the VFs respond to config accesses
>   - the PCI core enumerates the VFs by reading their config space
>   - the PCI core builds pci_dev structs for the VFs
>   - the PCI core adds these pci_devs to the bus
> 
> So everything is the same up to here.
>   - we try to bind drivers to the VFs
>   - the VF driver probe function may read VF config space and VF BARs
>   - the VF may be assigned to a guest VM
> 
> PowerVM environment is very different than traditional KVM in terms
> of SRIOV.  In our environment the VFs are not usable or view-able by
> the Hosting Partition in this case Linux. This is a very important
> point in that the Host CAN NOT do anything to any of the VFs
> available.

This is where I get confused.  I guess the Linux that sets
PCI_SRIOV_CTRL_VFE to enable the VFs can also perform config accesses
to the VFs, since it can enumerate them and build pci_dev structs for
them, right?

And the Linux in the "Hosting Partition" is a guest that cannot see a
VF until a management console attaches the VF to the Hosting
Partition?  I'm not a VFIO or KVM expert but that sounds vaguely like
what they would do when assigning a VF to a guest.

> So like existing way of enabling SRIOV we still rely on the PF driver to
> enable VFs - but in this case the attachment phase is done via a user
> action via a management console in our case (novalink or hmc) triggered
> event that will essentially act like a hotplug.
> 
> So in the fine details of that user triggered action the system
> firmware will bind the VFs, allowing resources to be allocated to
> the VF.  - Which essentially does all the attaching as we know it
> today but is managed by PHYP not by the kernel.

What exactly does "firmware binding the VFs" mean?  I guess this must
mean assigning a VF to a partition, injecting a hotplug add event to
that partition, and making the VF visible in config space?

Bjorn
