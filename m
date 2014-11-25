Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A7231A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:55:06 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DDB01400A0
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 09:55:05 +1100 (AEDT)
Message-ID: <1416956093.5089.1.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 0/5] powerpc/pci: PCI slot unified reset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 09:54:53 +1100
In-Reply-To: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-25 at 09:38 +1100, Gavin Shan wrote:
> The patchset corresponds to skiboot changes, which manages PCI slots
> in a unified way: OPAL APIs used to do slot reset, power management,
> presence status retrival. The patchset shouldn't be merged before
> the OPAL firmware counterpart is merged.

This doesn't work. We need to have both backward and forward
compatibility.

IE. New kernels must work with old OPAL and vice-versa.

> The kernel changes have been split into 2 parts: (A) Use the unified
> PCI slot reset OPAL API - this patchset; (B) Changes to rpaphp.ko to
> support PCI slot hotplug via sysfs entries for PowerPC PowerNV platform.

I don't think we should be using rpaphp... we should be creating our new
backend, there is almost no commonalities between RPA/PAPR and OPAL.

> This patchset affects EEH, PCI reset logics, which is used mainly by
> VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
> good: EEH on PowerNV, EEH support for guest, PCI passthrou.
> 
> Gavin Shan (5):
>   powerpc/powernv: Use PCI slot reset infrastructure
>   powerpc/powernv: Refactor ioda_eeh_reset()
>   powerpc/powernv: Avoid do complete reset for twice
>   powerpc/powernv: Issue fundamental reset if required
>   powerpc/powernv: Drop opal_pci_reinit()
> 
>  arch/powerpc/include/asm/eeh.h                 |   2 +-
>  arch/powerpc/include/asm/opal.h                |  31 +---
>  arch/powerpc/kernel/eeh_pe.c                   |   3 -
>  arch/powerpc/platforms/powernv/eeh-ioda.c      | 230 ++++++++++++++-----------
>  arch/powerpc/platforms/powernv/eeh-powernv.c   |  24 +--
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 -
>  arch/powerpc/platforms/powernv/pci-ioda.c      |   5 +-
>  arch/powerpc/platforms/pseries/eeh_pseries.c   |   3 +-
>  8 files changed, 139 insertions(+), 160 deletions(-)
> 
> Thanks,
> Gavin
