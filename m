Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E256E1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 16:43:23 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B58AA1400DD
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 15:43:23 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7DF452BB0047
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q5hBbV27394172
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q5gkKS014552
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:42:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 0/3] EEH Error Injection Support for VFIO Devices
Date: Thu, 26 Mar 2015 16:42:06 +1100
Message-Id: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches are extention to EEH support for VFIO PCI devices,
which allows to inject EEH errors to VFIO PCI devices from userspace
for testing purpose.

Changelog
=========
v4 -> v5:
        * Adjusted commit log for PATCH[1]
        * Dropped the last patch which deletes VFIO_EEH_PE_STATE_* from
          uapi/linux/vfio.h because we're uncertain if there're any one
          used or will use them in future as pointed by Alex.W.
v3 -> v4:
        * Move constants for EEH PE states defined in uapi/linux/vfio.h
          to uapi/asm/eeh.h.
v2 -> v3:
        * Use offsetofend(), instead of sizeof(struct vfio_eeh_pe_op)
          to calculate argument buffer size.
v1 -> v2:
        * Use EEH_ERR_FUNC_{MIN,MAX} to validate PCI error function.
        * Put additional arguments for error injection to union in
          struct vfio_eeh_pe_op.

Gavin Shan (3):
  powerpc/eeh: Move PE state constants around
  powerpc/eeh: Introduce eeh_pe_inject_err()
  drivers/vfio: Support EEH error injection

 Documentation/vfio.txt              | 12 ++++++++
 arch/powerpc/include/asm/eeh.h      |  9 +++---
 arch/powerpc/include/uapi/asm/eeh.h | 56 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c           | 35 +++++++++++++++++++++++
 drivers/vfio/vfio_spapr_eeh.c       | 10 +++++++
 include/uapi/linux/vfio.h           | 14 +++++++++-
 6 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/eeh.h

-- 
1.8.3.2
