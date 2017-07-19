Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCQpN1sc6zDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:40:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6JIdPDA026886
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:40:57 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btcgkryey-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:40:56 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 04:40:54 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6JIehKP22085792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:40:51 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6JIeIF4004416
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:40:19 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V7 0/3] powernv : Add support for OPAL-OCC command/response
 interface
Date: Thu, 20 Jul 2017 00:09:53 +0530
Message-Id: <1500489596-23255-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

The skiboot patch for this interface is posted here:
https://lists.ozlabs.org/pipermail/skiboot/2017-July/008293.html

Shilpasri G Bhat (3):
  powernv: powercap: Add support for powercap framework
  powernv: Add support to set power-shifting-ratio
  powernv : Add support to clear sensor groups data

 arch/powerpc/include/asm/opal-api.h            |   8 +-
 arch/powerpc/include/asm/opal.h                |   8 +
 arch/powerpc/include/uapi/asm/opal-occ.h       |  23 +++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-occ.c      | 108 +++++++++++
 arch/powerpc/platforms/powernv/opal-powercap.c | 237 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-psr.c      | 169 ++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   5 +
 arch/powerpc/platforms/powernv/opal.c          |  10 ++
 9 files changed, 568 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/opal-occ.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-psr.c

-- 
1.8.3.1
