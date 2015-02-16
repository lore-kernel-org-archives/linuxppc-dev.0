Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C05741A0176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:46:50 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91E7A14021A
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:46:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 63D702BB0051
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3kcfc51445914
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kDNf005307
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/10] powerpc/powernv: Simplify EEH Implementation
Date: Mon, 16 Feb 2015 14:45:38 +1100
Message-Id: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH was implemented for PowerNV platform with 2 layers, which are
supported by "struct eeh_ops" and "struct pnv_eeh_ops" separately. The
latter, called chip layer, was introduced for EEH guest support initially.
However, the EEH guest support was implemented depending on "struct eeh_ops"
completely. So it's uncessary to maintain 2 layers for EEH implementation
on PowerNV platform, as Ben pointed out.

The series of patches is pretty much mechanically to move all functions
in eeh-ioda.c to eeh-powernv.c, which enables us to remove the chip
layer, equivalently to remove "struct pnv_eeh_ops" and eeh-ioda.c, to
have simplifed EEH implementation on PowerNV platform.

Gavin Shan (10):
  powerpc/powernv: Shorten EEH function names
  powerpc/powernv: Drop PHB operation err_inject()
  powerpc/powernv: Drop PHB operation post_init()
  powerpc/powernv: Drop PHB operation get_log()
  powerpc/powernv: Drop PHB operation configure_bridge()
  powerpc/powernv: Drop PHB operation set_option()
  powerpc/powernv: Drop PHB operation get_state()
  powerpc/powernv: Drop PHB operation next_error()
  powerpc/powernv: Drop PHB operation reset()
  powerpc/powernv: Remove unused file

 arch/powerpc/platforms/powernv/Makefile      |    2 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 1149 --------------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 1146 ++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci-ioda.c    |    7 +-
 arch/powerpc/platforms/powernv/pci.h         |   25 +-
 5 files changed, 1041 insertions(+), 1288 deletions(-)
 delete mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c

-- 
1.8.3.2
