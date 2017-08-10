Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSYcb4PYvzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:33:03 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7A3TMXX069866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 23:33:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c89geg18p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 23:33:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 13:32:58 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7A3VfiG20381890
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:31:41 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7A3Ve9v009224
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:31:41 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, ego@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V11 0/3] powernv : Add support for OPAL-OCC command/response
 interface
Date: Thu, 10 Aug 2017 09:01:17 +0530
Message-Id: <1502335880-30686-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

Changes from V10:
- Rebased on powerpc-next
- Add sysfs interface instead of IOCTL
  (Skiboot patch for Patch3 is posted below:
  https://lists.ozlabs.org/pipermail/skiboot/2017-August/008553.html )

Shilpasri G Bhat (3):
  powernv: powercap: Add support for powercap framework
  powernv: Add support to set power-shifting-ratio
  powernv: Add support to clear sensor groups data

 .../ABI/testing/sysfs-firmware-opal-powercap       |  31 +++
 Documentation/ABI/testing/sysfs-firmware-opal-psr  |  18 ++
 .../bindings/powerpc/opal/sensor-groups.txt        |  27 +++
 arch/powerpc/include/asm/opal-api.h                |   6 +
 arch/powerpc/include/asm/opal.h                    |  10 +
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/opal-powercap.c     | 244 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-psr.c          | 175 +++++++++++++++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 212 ++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   5 +
 arch/powerpc/platforms/powernv/opal.c              |  10 +
 11 files changed, 739 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-powercap
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-psr
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt
 create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-psr.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-sensor-groups.c

-- 
1.8.3.1
