Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405061A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:12:29 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C8E5140083
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:12:27 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so152035366pdb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 22:12:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Add dma_set_mask to pci_controller_ops
Date: Tue, 28 Apr 2015 15:12:04 +1000
Message-Id: <1430197927-24814-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds dma_set_mask to pci_controller_ops.

Currently it's only implemented on PowerNV, because it gets very messy
on systems that have more than just simple PCI busses.

On the plus side, this series massively simplifies the code path on
PowerNV (see patch #3).

It is based on my recent MSI patch series[0], although it doesn't
depend on it. It could easily be respun on top of -rc1 if required.

It does depend on a PowerNV bug fix[1].

Tested on PowerNV big-endian.

Regards,
Daniel

[0] http://lkml.kernel.org/r/1428985683-24767-1-git-send-email-dja@axtens.net
[1] http://patchwork.ozlabs.org/patch/464765/

Daniel Axtens (3):
  powerpc/powernv: Specialise pci_controller_ops for each controller
    type
  powerpc/pci: add dma_set_mask to pci_controller_ops
  powerpc/powernv: Move dma_set_mask from pnv_phb to pci_controller_ops

 arch/powerpc/include/asm/pci-bridge.h       |  2 ++
 arch/powerpc/kernel/dma.c                   | 11 +++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   | 25 ++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 12 +++++++++++-
 arch/powerpc/platforms/powernv/pci.c        | 23 +++--------------------
 arch/powerpc/platforms/powernv/pci.h        |  8 ++++++--
 arch/powerpc/platforms/powernv/powernv.h    |  8 --------
 arch/powerpc/platforms/powernv/setup.c      |  8 --------
 8 files changed, 51 insertions(+), 46 deletions(-)

-- 
2.1.4
