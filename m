Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCtdK490jzDrD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 14:35:01 +1100 (AEDT)
Date: Thu, 12 Oct 2017 22:34:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bodong Wang <bodong@mellanox.com>, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
Message-ID: <20171013033456.GC25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
 <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <87efq92ei6.fsf@concordia.ellerman.id.au>
 <20171012182932.GA653@bhelgaas-glaptop.roam.corp.google.com>
 <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e77da565-e9e1-75e1-55ee-cfc9a8bf1424@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Alex, Bodong, Eli, Saeed]

On Thu, Oct 12, 2017 at 02:59:23PM -0500, Bryant G. Ly wrote:
> On 10/12/17 1:29 PM, Bjorn Helgaas wrote:
> >On Thu, Oct 12, 2017 at 03:09:53PM +1100, Michael Ellerman wrote:
> >>Bjorn Helgaas <helgaas@kernel.org> writes:
> >>
> >>>On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
> >>>>This patch adds the machine dependent call for
> >>>>pcibios_bus_add_device, since the previous patch
> >>>>separated the calls out between the PowerNV and PowerVM.
> >>>>
> >>>>The difference here is that for the PowerVM environment
> >>>>we do not want match_driver set because in this environment
> >>>>we do not want the VF device drivers to load immediately, due to
> >>>>firmware loading the device node when VF device is assigned to the
> >>>>logical partition.
> >>>>
> >>>>This patch will depend on the patch linked below, which is under
> >>>>review.
> >>>>
> >>>>https://patchwork.kernel.org/patch/9882915/
> >>>>
> >>>>Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> >>>>Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
> >>>>---
> >>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++++++
> >>>>  1 file changed, 24 insertions(+)
> >>>>
> >>>>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>>index 6b812ad990e4..45946ee90985 100644
> >>>>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> >>>>@@ -64,6 +64,27 @@ static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
> >>>>  static DEFINE_SPINLOCK(slot_errbuf_lock);
> >>>>  static int eeh_error_buf_size;
> >>>>+void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
> >>>>+{
> >>>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
> >>>>+
> >>>>+	if (!pdev->is_virtfn)
> >>>>+		return;
> >>>>+
> >>>>+	pdn->device_id  =  pdev->device;
> >>>>+	pdn->vendor_id  =  pdev->vendor;
> >>>>+	pdn->class_code =  pdev->class;
> >>>>+
> >>>>+	/*
> >>>>+	 * The following operations will fail if VF's sysfs files
> >>>>+	 * aren't created or its resources aren't finalized.
> >>>>+	 */
> >>>>+	eeh_add_device_early(pdn);
> >>>>+	eeh_add_device_late(pdev);
> >>>>+	eeh_sysfs_add_device(pdev);
> >>>>+	pdev->match_driver = -1;
> >>>match_driver is a bool, which should be assigned "true" or "false".
> >>Above he mentioned a dependency on:
> >>
> >>   [04/10] PCI: extend pci device match_driver state
> >>   https://patchwork.kernel.org/patch/9882915/
> >>
> >>
> >>Which makes it an int.
> >Oh, right, I missed that, thanks.
> >
> >>Or has that patch been rejected or something?
> >I haven't *rejected* it, but it's low on my priority list, so you
> >shouldn't depend on it unless it adds functionality you really need.
> >If I did apply that particular patch, I would want some rework because
> >it currently obfuscates the match_driver logic.  There's no clue when
> >reading the code what -1/0/1 mean.
> So do you prefer enum's? - If so I can make a change for that.
> >Apparently here you *do* want the "-1 means the PCI core will never
> >set match_driver to 1" functionality, so maybe you do depend on it.
> We depend on the patch because we want that ability to never set
> match_driver,
> for SRIOV on PowerVM.

Is this really new PowerVM-specific functionality?  ISTR recent discussions
about inhibiting driver binding in a generic way, e.g.,
http://lkml.kernel.org/r/1490022874-54718-1-git-send-email-bodong@mellanox.com

> >If that's the case, how to you ever bind a driver to these VFs?  The
> >changelog says you don't want VF drivers to load *immediately*, so I
> >assume you do want them to load eventually.
> >
> The VF's that get dynamically created within the configure SR-IOV
> call, on the Pseries Platform, wont be matched with a driver. - We
> do not want it to match.
> 
> The Power Hypervisor will load the VFs. The VF's will get
> assigned(by the user) via the HMC or Novalink in this environment
> which will then trigger PHYP to load the VF device node to the
> device tree.

I don't know what it means for the Hypervisor to "load the VFs."  Can
you explain that in PCI-speak?

The things I know about are:

  - we set PCI_SRIOV_CTRL_VFE in the PF, which enables VFs
  - now the VFs respond to config accesses
  - the PCI core enumerates the VFs by reading their config space
  - the PCI core builds pci_dev structs for the VFs
  - the PCI core adds these pci_devs to the bus
  - we try to bind drivers to the VFs
  - the VF driver probe function may read VF config space and VF BARs
  - the VF may be assigned to a guest VM

Where does "loading the VFs" fit in?  I don't know what HMC, Novalink,
or PHYP are.  I don't *need* to know what they are, as long as you can
explain what's happening in terms of the PCI concepts and generic Linux VMs
and device assignment.

Bjorn
