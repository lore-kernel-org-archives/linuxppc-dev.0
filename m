Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLWV35Cd6zDrnG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 17:36:27 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6V7YLXK030639
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 03:36:24 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c1yh5sxc8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 03:36:24 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 17:36:21 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6V7aIfN26738762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 17:36:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6V7a9Jj013298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 17:36:09 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V9 0/3] powernv : Add support for OPAL-OCC command/response
 interface
Date: Mon, 31 Jul 2017 13:06:02 +0530
Message-Id: <1501486565-16079-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P9, OCC (On-Chip-Controller) supports shared memory based
commad-response interface. Within the shared memory there is an OPAL
command buffer and OCC response buffer that can be used to send
inband commands to OCC. The following commands are supported:

1) Set system powercap
2) Set CPU-GPU power shifting ratio
3) Clear min/max for OCC sensor groups

Changes from V9:
- Fixed return after erroring from mutex_lock_interruptible()
- Added documentation

Shilpasri G Bhat (3):
  powernv: powercap: Add support for powercap framework
  powernv: Add support to set power-shifting-ratio
  powernv: Add support to clear sensor groups data

 .../ABI/testing/sysfs-firmware-opal-powercap       |  31 +++
 Documentation/ABI/testing/sysfs-firmware-opal-psr  |  18 ++
 .../bindings/powerpc/opal/sensor-groups.txt        |  23 ++
 arch/powerpc/include/asm/opal-api.h                |   8 +-
 arch/powerpc/include/asm/opal.h                    |   9 +
 arch/powerpc/include/uapi/asm/opal-occ.h           |  23 ++
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/opal-occ.c          | 116 ++++++++++
 arch/powerpc/platforms/powernv/opal-powercap.c     | 244 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-psr.c          | 175 +++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   5 +
 arch/powerpc/platforms/powernv/opal.c              |  10 +
 12 files changed, 662 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-powercap
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-psr
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt
 create mode 100644 arch/powerpc/include/uapi/asm/opal-occ.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-psr.c

-- 
1.8.3.1
