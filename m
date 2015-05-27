Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 864411A0D12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:30 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 00/24] cxl: Add AFU virtual PHB and in kernel API
Date: Wed, 27 May 2015 16:06:54 +1000
Message-Id: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds the ability to present AFUs as PCI devices on a virtual
PHB.

It also adds an in kernel API (to the existing userspace API) so AFU drivers
can be written as kernel drivers.

This series is dependant on Daniel DMA set mask and MSI PCI controller ops
patch series.

v3:
Cleans up device disable and adds a new API call. Details:
 - Added pci_disable_device() hook to powerpc.
 - Added cxl pci_disable_device() to PCI controller ops.
 - Added cxl_fops_get_context() API call for cxlflash team.
 - Fixed error path on probe().
 - Removed a verbose print from cxl_remove().

v2:
 - Address comments from Ian
   o Rename some functions now they are global
   o Rework context lifetime
   o Merge and fix SR calculation
   o Added ACKs from Ian
   o correct from Ian on one patch
 - Fixed powernv pci shutdown hook

Mikey
