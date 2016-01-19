Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0E261A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 07:18:32 +1100 (AEDT)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 19 Jan 2016 18:18:26 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 1FFF11DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:18:19 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JKFqZb30278080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:15:52 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JKIMpG000517
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:18:22 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com, paulus@samba.org,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Two patches regarding EEH availability checks - DLPAR/DDW
Date: Tue, 19 Jan 2016 18:18:18 -0200
Message-Id: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have 2 patches here to deal with checks of EEH availability before its use.
The issue that triggered these patches was related to hotplug-add a PCI device
with no other PCI device present in machine. Since EEH wouldn't be enabled in
this case, we hit an oops.

We already sent a patch to ppc-dev ("[PATCH] powerpc/eeh: Validate arch in
eeh_add_device_early()"), but Michael Ellerman made some good points that led us
to elaborate more our approach. Now, we have two patches instead of one:

(i) The first one aims to solve a specific issue in hotplug process: we have
lowered the "constraints" imposed by checking for eeh_enabled() result. To
achieve this, we've added a small function named eeh_available(). Instead of
checking if EEH is enabled on hotplug process (which is not always true), we
check if it's available based on running architecture (currently, only pSeries
and PowerNV have EEH capabilities).

(ii) The DDW mechanism has a "non-exposed" intrinsic dependency of EEH. We
rely on EEH to obtain the devices' config. address, so if EEH is not enabled
(for example if we boot with "eeh=off" on kernel command-line), we hit an oops
during device probe caused by DDW trying to use EEH struct. The 2nd patch in
this series inserts a check based on eeh_enabled() function, so the DDW
mechanism safely fallbacks to non-dynamic iommu if EEH is not enabled.

Guilherme G. Piccoli (2):
  powerpc/eeh: Check for EEH availability in eeh_add_device_early()
  powerpc/pseries: Check if EEH is enabled on DDW mechanism code

 arch/powerpc/kernel/eeh.c              | 19 ++++++++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c |  6 ++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

--
2.1.0
