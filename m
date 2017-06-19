Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrggG69yszDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5J6EXK1060578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 02:14:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b64mr9bu7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 02:14:48 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 16:14:44 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5J6EeeD4718858
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5J6EV9K027289
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:14:31 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V3 0/2] Add support for OCC command/response interface
Date: Mon, 19 Jun 2017 11:44:30 +0530
Message-Id: <1497852872-7985-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P9, OCC(On Chip Controller) can be sent commands inband via shared
memory based command response interface.  This patch adds a platform
driver to support the OCC command-response interface.

The skiboot patch for the interface is posted here:
https://lists.ozlabs.org/pipermail/skiboot/2017-June/007705.html

Shilpasri G Bhat (2):
  powerpc/powernv: Get a unique token for async completions
  powerpc/powernv : Add support for OPAL-OCC command/response interface

 arch/powerpc/include/asm/opal-api.h            |  41 +++-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-async.c    |  46 ++++
 arch/powerpc/platforms/powernv/opal-occ.c      | 307 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   8 +
 7 files changed, 407 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c

-- 
1.8.3.1
