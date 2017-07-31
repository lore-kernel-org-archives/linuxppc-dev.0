Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLNZ92kXdzDrLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:33 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6V2NsYs008404
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 22:24:30 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c11c7tqw8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 22:24:30 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 12:24:28 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6V2OPxY33357912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:25 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6V2OOR3013440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:25 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V9 0/3] powernv : Add support for OPAL-OCC command/response
 interface
Date: Mon, 31 Jul 2017 07:54:15 +0530
Message-Id: <1501467858-8887-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

Shilpasri G Bhat (3):
  powernv: powercap: Add support for powercap framework
  powernv: Add support to set power-shifting-ratio
  powernv: Add support to clear sensor groups data

 arch/powerpc/include/asm/opal-api.h            |   8 +-
 arch/powerpc/include/asm/opal.h                |   9 +
 arch/powerpc/include/uapi/asm/opal-occ.h       |  23 +++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-occ.c      | 115 ++++++++++++
 arch/powerpc/platforms/powernv/opal-powercap.c | 243 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-psr.c      | 173 ++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   5 +
 arch/powerpc/platforms/powernv/opal.c          |  10 +
 9 files changed, 586 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/opal-occ.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-psr.c

-- 
1.8.3.1
