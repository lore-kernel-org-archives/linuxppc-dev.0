Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309A11A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:56:36 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 13:26:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 684F73940049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7Q7uqDu56230100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7Q7uStA030133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:28 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc/eeh: More precisely error injection
Date: Tue, 26 Aug 2014 17:56:15 +1000
Message-Id: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: qiudayu@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, we inject PCI errors through various debugfs entries in
/sys/kernel/debug/powerpc/PCIxxxx/. Unfortunately, the PCI errors
are injected with PHB granularity. It's hard to injection errors to
specified PE. The series of patches adds one more debugfs entry, which
allows to inject errors to specified PE for testing purpose.

echo "pe_no:0:function:0:0" > /sys/kernel/debug/powerpc/PCIxxxx/err_injct

The frequently used "function" would be:
    0 : MMIO read
    4 : CFG read
    6 : MMIO write
    10: CFG write

Gavin Shan (1):
  powerpc/powernv: Clear PAPR error injection registers

Mike Qiu (3):
  powerpc/powernv: Sync header with firmware
  powerpc/eeh: Introduce eeh_ops::err_inject
  powerpc/powernv: Add error injection debugfs entry

 arch/powerpc/include/asm/eeh.h                 |   2 +
 arch/powerpc/include/asm/opal.h                |  30 +++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 115 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  26 ++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/pci.h           |   2 +
 arch/powerpc/platforms/pseries/eeh_pseries.c   |   1 +
 7 files changed, 177 insertions(+)

-- 
1.8.3.2
