Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 277191A09F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:25:59 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D3811400E9
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 16:25:58 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 10:55:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 699BE3940053
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 10:55:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45S0ZC66977826
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 10:58:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45PlZm025872
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 10:55:47 +0530
Date: Thu, 4 Dec 2014 16:25:45 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 0/5] powerpc/pci: PCI slot unified reset
Message-ID: <20141204052545.GA23081@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2014 at 09:38:42AM +1100, Gavin Shan wrote:

Please ignore this revision. v2 is on the way...

Thanks,
Gavin

>The patchset corresponds to skiboot changes, which manages PCI slots
>in a unified way: OPAL APIs used to do slot reset, power management,
>presence status retrival. The patchset shouldn't be merged before
>the OPAL firmware counterpart is merged.
>
>The kernel changes have been split into 2 parts: (A) Use the unified
>PCI slot reset OPAL API - this patchset; (B) Changes to rpaphp.ko to
>support PCI slot hotplug via sysfs entries for PowerPC PowerNV platform.
>
>This patchset affects EEH, PCI reset logics, which is used mainly by
>VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
>good: EEH on PowerNV, EEH support for guest, PCI passthrou.
>
>Gavin Shan (5):
>  powerpc/powernv: Use PCI slot reset infrastructure
>  powerpc/powernv: Refactor ioda_eeh_reset()
>  powerpc/powernv: Avoid do complete reset for twice
>  powerpc/powernv: Issue fundamental reset if required
>  powerpc/powernv: Drop opal_pci_reinit()
>
> arch/powerpc/include/asm/eeh.h                 |   2 +-
> arch/powerpc/include/asm/opal.h                |  31 +---
> arch/powerpc/kernel/eeh_pe.c                   |   3 -
> arch/powerpc/platforms/powernv/eeh-ioda.c      | 230 ++++++++++++++-----------
> arch/powerpc/platforms/powernv/eeh-powernv.c   |  24 +--
> arch/powerpc/platforms/powernv/opal-wrappers.S |   1 -
> arch/powerpc/platforms/powernv/pci-ioda.c      |   5 +-
> arch/powerpc/platforms/pseries/eeh_pseries.c   |   3 +-
> 8 files changed, 139 insertions(+), 160 deletions(-)
>
>Thanks,
>Gavin
