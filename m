Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AB271A0427
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 13:30:43 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79C4E140779
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 13:30:43 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 12:30:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 738F03578048
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 13:30:40 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H2UW6c35455138
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 13:30:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H2U6we002161
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 13:30:07 +1100
Date: Tue, 17 Feb 2015 13:29:42 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc/pci: PCI slot unified reset
Message-ID: <20150217022942.GB17352@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 04, 2014 at 04:50:50PM +1100, Gavin Shan wrote:

Please ignore this one. I'll rebase and send out a new revision
shortly.

Thanks,
Gavin

>The patchset corresponds to skiboot changes, which manages PCI slots
>in a unified way: OPAL APIs used to do slot reset, power management,
>presence status retrival. The patchset shouldn't be merged before
>the OPAL firmware counterpart is merged.
>
>The kernel changes have been split into 2 parts: (A) Use the unified
>PCI slot reset OPAL API - this patchset; (B) powernv-php driver to
>support PCI hotplug for PowerNV platform, which will be sent separately.
>
>This patchset affects EEH, PCI reset logics, which is used mainly by
>VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
>good: EEH on PowerNV, EEH support for guest, PCI passthrou.
>
>Changelog
>=========
>v1 -> v2
>        * Keep opal_pci_reinit(). In case the slot is resetted by kernel,
>          instead of skiboot, this API should be called to restore states
>          for those affected devices.
>        * Reworked slot ID scheme so that old/new kernel can work with
>          skiboot with or without unified PCI slot management support.
>        * Code cleanup here and there.
>
>Gavin Shan (3):
>  powerpc/powernv: Use PCI slot reset infrastructure
>  powerpc/powernv: Refactor ioda_eeh_reset()
>  powerpc/powernv: Issue fundamental reset if required
>
> arch/powerpc/include/asm/eeh.h            |   1 +
> arch/powerpc/include/asm/opal.h           |   9 +-
> arch/powerpc/platforms/powernv/eeh-ioda.c | 240 ++++++++++++++++--------------
> 3 files changed, 132 insertions(+), 118 deletions(-)
>
>Thanks,
>Gavin
>
