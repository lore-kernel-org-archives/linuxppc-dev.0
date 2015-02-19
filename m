Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DA3B1A0D22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 05:58:06 +1100 (AEDT)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 19 Feb 2015 16:58:02 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 762501DC005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 13:57:01 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1JIwABX4292726
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 15:58:11 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1JIvuYI030402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 16:57:56 -0200
Date: Thu, 19 Feb 2015 16:57:47 -0200
From: cascardo@linux.vnet.ibm.com
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Support registering specific reset handler
Message-ID: <20150219185746.GA4440@oc0812247204.ltc.br.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
 <20150216223647.GA5758@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150216223647.GA5758@shangw>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2015 at 09:36:47AM +1100, Gavin Shan wrote:
> On Mon, Feb 16, 2015 at 11:14:27AM -0200, cascardo@linux.vnet.ibm.com wrote:
> >On Fri, Feb 13, 2015 at 03:54:55PM +1100, Gavin Shan wrote:
> >> VFIO PCI infrastructure depends on pci_reset_function() to do reset on
> >> PCI devices so that they would be in clean state when host or guest grabs
> >> them. Unfortunately, the function doesn't work (or not well) on some PCI
> >> devices that require EEH PE reset.
> >> 
> >> The patchset extends the quirk for PCI device speicific reset methods to
> >> allow dynamically registration. With it, we can translate reset requests
> >> for those special PCI devcies to EEH PE reset, which is only avaialble on
> >> 64-bits PowerPC platforms.
> >> 
> >
> >Hi, Gavin.
> >
> >I like your approach overall. That allows us to confine these quirks to
> >the platforms where they are relevant. I would make the quirks more
> >specific, though, instead of doing them for all IBM and Mellanox
> >devices.
> >
> 
> Yeah, we need have more specific vendor/device IDs for PATCH[4/4]. Could
> you please take a look on PATCH[4/4] and then suggest the specific devices
> that requries the platform-dependent reset quirk? Especially the device IDs
> for IBM/Mellanox we need put add quirks for.
> 
> >I wonder if we should not have some form of domain reset, where we would
> >reset all the devices on the same group, and use that on vfio. Grouping
> >the devices would then be made platform-dependent, as well as the reset
> >method. On powernv, we would group by IOMMU group and issue a
> >fundamental reset.
> >
> 
> I'm assuming "domain reset" is PE reset, which is the specific reset handler
> tries to do on PowerNV platform. The reason why we need platform specific
> reset handler is some adapters can't support function level reset methods
> (except pci_dev_specific_reset()) in __pci_dev_reset().
> 

Well, in the case of Power servers, this would be the PE reset, I am not
sure what this would be on other platforms. No other platform implements
pci_set_pcie_reset_state, which I think would be one possible to
implement such a reset.

What I am saying is that we should consider doing this on all platforms
and for all adapters, because this is not specific to Power and this is
not specific to this particular set of adapters. Otherwise, one can
simply program one adapter in the guest to write to host memory,
shutdown, and since no reset will take place, the card will simply write
to host memory when the guest is finished with and IOMMU is off.

Regards.
Cascardo.

> Thanks,
> Gavin
> 
> >Cascardo.
> >
> >> Gavin Shan (4):
> >>   PCI: Rename struct pci_dev_reset_methods
> >>   PCI: Introduce list for device reset methods
> >>   PCI: Allow registering reset method
> >>   powerpc/powernv: Register PCI dev specific reset handlers
> >> 
> >>  arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
> >>  drivers/pci/pci.h                    |   3 +-
> >>  drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
> >>  include/linux/pci.h                  |   9 +++
> >>  4 files changed, 192 insertions(+), 20 deletions(-)
> >> 
> >> -- 
> >> 1.8.3.2
> >> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
