Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BABF61A0F82
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 00:14:47 +1100 (AEDT)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 11:14:41 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B028D1DC005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 08:13:40 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GDDtjs42926134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 10:13:55 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GDEZt7024169
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 11:14:35 -0200
Date: Mon, 16 Feb 2015 11:14:27 -0200
From: cascardo@linux.vnet.ibm.com
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Support registering specific reset handler
Message-ID: <20150216131427.GA4840@oc0812247204.ltc.br.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Fri, Feb 13, 2015 at 03:54:55PM +1100, Gavin Shan wrote:
> VFIO PCI infrastructure depends on pci_reset_function() to do reset on
> PCI devices so that they would be in clean state when host or guest grabs
> them. Unfortunately, the function doesn't work (or not well) on some PCI
> devices that require EEH PE reset.
> 
> The patchset extends the quirk for PCI device speicific reset methods to
> allow dynamically registration. With it, we can translate reset requests
> for those special PCI devcies to EEH PE reset, which is only avaialble on
> 64-bits PowerPC platforms.
> 

Hi, Gavin.

I like your approach overall. That allows us to confine these quirks to
the platforms where they are relevant. I would make the quirks more
specific, though, instead of doing them for all IBM and Mellanox
devices.

I wonder if we should not have some form of domain reset, where we would
reset all the devices on the same group, and use that on vfio. Grouping
the devices would then be made platform-dependent, as well as the reset
method. On powernv, we would group by IOMMU group and issue a
fundamental reset.

Cascardo.

> Gavin Shan (4):
>   PCI: Rename struct pci_dev_reset_methods
>   PCI: Introduce list for device reset methods
>   PCI: Allow registering reset method
>   powerpc/powernv: Register PCI dev specific reset handlers
> 
>  arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
>  drivers/pci/pci.h                    |   3 +-
>  drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
>  include/linux/pci.h                  |   9 +++
>  4 files changed, 192 insertions(+), 20 deletions(-)
> 
> -- 
> 1.8.3.2
> 
