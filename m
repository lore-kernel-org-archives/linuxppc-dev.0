Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 343CC1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 05:39:05 +1100 (AEDT)
Received: by oifz81 with SMTP id z81so19126091oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2015 10:39:02 -0800 (PST)
Date: Fri, 6 Mar 2015 12:38:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Support registering specific reset handler
Message-ID: <20150306183859.GH20077@google.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
 <20150216223647.GA5758@shangw>
 <20150219185746.GA4440@oc0812247204.ltc.br.ibm.com>
 <20150220055308.GA26047@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220055308.GA26047@shangw>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2015 at 04:53:08PM +1100, Gavin Shan wrote:
> On Thu, Feb 19, 2015 at 04:57:47PM -0200, cascardo@linux.vnet.ibm.com wrote:
> >On Tue, Feb 17, 2015 at 09:36:47AM +1100, Gavin Shan wrote:
> >> On Mon, Feb 16, 2015 at 11:14:27AM -0200, cascardo@linux.vnet.ibm.com wrote:
> >> >On Fri, Feb 13, 2015 at 03:54:55PM +1100, Gavin Shan wrote:
> >> >> VFIO PCI infrastructure depends on pci_reset_function() to do reset on
> >> >> PCI devices so that they would be in clean state when host or guest grabs
> >> >> them. Unfortunately, the function doesn't work (or not well) on some PCI
> >> >> devices that require EEH PE reset.
> >> >> 
> >> >> The patchset extends the quirk for PCI device speicific reset methods to
> >> >> allow dynamically registration. With it, we can translate reset requests
> >> >> for those special PCI devcies to EEH PE reset, which is only avaialble on
> >> >> 64-bits PowerPC platforms.
> >> >> 
> >> >
> >> >Hi, Gavin.
> >> >
> >> >I like your approach overall. That allows us to confine these quirks to
> >> >the platforms where they are relevant. I would make the quirks more
> >> >specific, though, instead of doing them for all IBM and Mellanox
> >> >devices.
> >> >
> >> 
> >> Yeah, we need have more specific vendor/device IDs for PATCH[4/4]. Could
> >> you please take a look on PATCH[4/4] and then suggest the specific devices
> >> that requries the platform-dependent reset quirk? Especially the device IDs
> >> for IBM/Mellanox we need put add quirks for.
> >> 
> >> >I wonder if we should not have some form of domain reset, where we would
> >> >reset all the devices on the same group, and use that on vfio. Grouping
> >> >the devices would then be made platform-dependent, as well as the reset
> >> >method. On powernv, we would group by IOMMU group and issue a
> >> >fundamental reset.
> >> >
> >> 
> >> I'm assuming "domain reset" is PE reset, which is the specific reset handler
> >> tries to do on PowerNV platform. The reason why we need platform specific
> >> reset handler is some adapters can't support function level reset methods
> >> (except pci_dev_specific_reset()) in __pci_dev_reset().
> >> 
> >
> >Well, in the case of Power servers, this would be the PE reset, I am not
> >sure what this would be on other platforms. No other platform implements
> >pci_set_pcie_reset_state, which I think would be one possible to
> >implement such a reset.
> >
> >What I am saying is that we should consider doing this on all platforms
> >and for all adapters, because this is not specific to Power and this is
> >not specific to this particular set of adapters. Otherwise, one can
> >simply program one adapter in the guest to write to host memory,
> >shutdown, and since no reset will take place, the card will simply write
> >to host memory when the guest is finished with and IOMMU is off.
> >
> 
> Yes, I believe your way will make things simpler and we don't need the
> code to support registering reset handler dynamically at atll. Please
> confirm if following idea is what you're suggesting: 
> 
> - Introduce function drivers/pci/quirks.c::pci_dev_specific_reset(), which
>   will be added to pci_dev_reset_methods[] for various vendor/device IDs.
> - pci_dev_specific_reset() routes the reset (or probe) request to
>   pci_set_pcie_reset_state(), which needs one more syntax for reset probing.
>   In turn, pci_set_pcie_reset_state() calls pcibios_set_pcie_reset_state(),
>   which returns -ETTY by default.
> 
> For PowerPC, pcibios_set_pcie_reset_state() will do PE reset, which can't
> be ported to other platforms as it depends on PowerPC unique EEH feature.
> So other platforms have to override this function and do things similar to
> PowerPC PE reset there.

Dropping for now because it sounds like you are considering reworking based
on Cascardo's ideas.  If not, please re-post these so they show up in
patchwork again.

Bjorn
