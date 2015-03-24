Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3423C1A2B39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 11:24:21 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A523140161
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:24:16 +1100 (AEDT)
Message-ID: <1427156635.4770.290.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] PCI: One more parameter to
 pci_set_pcie_reset_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 24 Mar 2015 11:23:55 +1100
In-Reply-To: <1427144881.3643.680.camel@redhat.com>
References: <1427079771-18472-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427081673.3643.547.camel@redhat.com> <20150323035656.GA27802@shangw>
 <1427083561.3643.551.camel@redhat.com> <20150323044033.GA1874@shangw>
 <1427114434.3643.554.camel@redhat.com>
 <20150323200729.GB1368@oc0812247204.ltc.br.ibm.com>
 <1427144881.3643.680.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, Brian King <brking@us.ibm.com>,
 cascardo@linux.vnet.ibm.com, bhelgaas@google.com,
 Frank Haverkamp <haver@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 15:08 -0600, Alex Williamson wrote:
> 
> I don't know what you're doing on POWER, I thought groups were
> equivalent to PEs, but on x86 we learn about isolation of PCI functions
> by standard PCI properties.  Devices need to tell us that they're
> isolated via ACS capabilities (or quirks, with vendor approval).
> Otherwise we assume there is no isolation and multi-function devices
> will be grouped together, preventing the individual functions from being
> assigned to separate userspace instances.  VFIO does not ignore the
> problem of internal communication between functions, it uses ACS... at
> least on most platforms.

POWER doesn't allow functions in different PEs today (mostly for a
different reason which is the problem we have with MMIO assignment to
different PEs, though we are working on ways to fix that in the future
in which case we might start using ACS).

There's still a potential issue with LSIs though, I haven't looked how
you handle it on x86.

> Firmware shared between functions is an unsolvable problem outside of
> restricting device assignment only to SR-IOV virtual functions.  We
> cannot know the programming method to block firmware updates of an
> assigned device nor can we control which functions share the firmware.
> If you're worried about this level of attack against the hardware, use
> VFs exclusively.

You cannot trust HW :-)

> If you're unsatisfied with the grouping of devices on your platform,
> this is entirely within your control since VFIO relies on IOMMU groups,
> which are managed via the platform IOMMU driver.  If your IOMMU driver
> is arbitrarily splitting each PCI function into a separate group without
> testing the isolation, that's a problem with IOMMU groups on your
> platform.  If you would like to add a reset requirement to a group, you
> have the ability to do that.  On x86, I expect this would be far too
> restrictive.

That means that you cannot recover devices that don't support FLR...

> VFIO also knows how to do bus and slot resets, the pci_reset_bus() and
> pci_reset_slot() interfaces were added by me with vfio-pci as the first
> user.  Resets are generally handled as best effort though and this is
> sometimes a property of a device that might make it unsuitable for
> device assignment.

Or unsuitable as a multi-function split assignment, we can still give
the whole slot to the guest.

> The fact that you're implying above that the devices covered by the
> device specific reset proposed in this series can be assigned separately
> makes ignoring the scope of pci_reset_function() all the more wrong.  If
> you want to change grouping on POWER to require that a group can be
> reset, that's an IOMMU driver issue.  If you want to make a change to
> VFIO to require an opt-in/out of allowing access to groups without a
> reset, then propose something.  Just please don't ignore the semantics
> of existing functions because it's a quicker and easier hack than doing
> it correctly.  Thanks,

The IOMMU driver unfortunately cannot know whether the devices support a
good reset granularity without quirks ... Oh well. It's a mess, thanks
for Intel for not making FLR mandatory since PCI 1.0 .... :-)

Cheers,
Ben.
