Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBcp2CjYzDsZn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GAbc9T090636
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:08 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fu1fehgs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:07 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 20:40:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 821DB2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8GAe1FE64880688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8GAe0s5016065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:01 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, benh@kernel.crashing.org,
 gwshan@linux.vnet.ibm.com
Subject: [RFC 0/3] powerpc/powernv: support CAPI + kexec
Date: Fri, 16 Sep 2016 20:39:43 +1000
Message-Id: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if you attempt to kexec into a new kernel from a machine with a
CAPI card and the cxl driver loaded, you are going to have an exceedingly
bad time. It turns out that the hardware doesn't really cope very well with
going through the standard Linux PCI initialisation process while a PHB is
still in CAPI mode. Checkstops everywhere!

I've submitted RFC patches for skiboot[0][1] to disable CAPI mode when we
do a complete reset on a PHB. This series ensures that when we enter the
new kernel, we ask skiboot to do a complete reset on any PHBs that have
been left in CAPI mode before we initialise everything.

At this stage, I haven't thought too hard about getting to the point where
we can do this after Linux has booted for stuff like PCI hotplug...
triggering a creset after the Linux EEH handling is all set up can get
interesting.

This has only gotten the very lightest of testing - I've kexec-ed quite a
few times with no real problems, and I've run some basic CAPI tests that
don't seem to fail too much more than they normally fail. It does look like
we get spammed with a tonne of HMIs and frozen PE messages in the skiboot
log, not sure how bad this is.

Thanks to Vaibhav Jain (who made a previous attempt at this), Mikey
Neuling, Ben Herrenschmidt, Gavin Shan, Bill Daly and JT Kellington for
advice on various bits of this.

Andrew

[0] http://patchwork.ozlabs.org/patch/670781/
[1] http://patchwork.ozlabs.org/patch/670782/

Andrew Donnellan (3):
  powerpc/powernv: fix comment style and spelling
  powerpc/powernv: add opal_pci_get_phb_capi_mode() call
  powerpc/powernv: reset any PHBs in CAPI mode during initialisation

 arch/powerpc/include/asm/opal-api.h            |  3 ++-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 17 ++++++++++++++---
 4 files changed, 18 insertions(+), 4 deletions(-)

base-commit: 024c7e3756d8a42fc41fe8a9488488b9b09d1dcc
-- 
git-series 0.8.10
