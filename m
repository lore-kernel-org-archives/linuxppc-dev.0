Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B23C1A065A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:21:41 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 137FD1401AB
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 09:21:39 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 660432CE804E
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2PNLRrH35061884
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:36 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2PNL2tJ019134
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:02 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 0/4] EEH Error Injection Support for VFIO Devices
Date: Thu, 26 Mar 2015 10:20:33 +1100
Message-Id: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

Gavin Shan (4):
  powerpc/eeh: Eliminate duplicated PE states
  powerpc/eeh: Introduce eeh_pe_inject_err()
  drivers/vfio: Support EEH error injection
  drivers/vfio: Remove duplicated PE states

 Documentation/vfio.txt              | 12 ++++++++
 arch/powerpc/include/asm/eeh.h      |  9 +++---
 arch/powerpc/include/uapi/asm/eeh.h | 56 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c           | 35 +++++++++++++++++++++++
 drivers/vfio/vfio_spapr_eeh.c       | 10 +++++++
 include/uapi/linux/vfio.h           | 19 +++++++++----
 6 files changed, 130 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/eeh.h

-- 
1.8.3.2
