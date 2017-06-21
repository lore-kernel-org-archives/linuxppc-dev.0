Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsy3X5lMlzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:06:48 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L83kcN078257
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 04:06:46 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7kd2mdfs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 04:06:45 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 18:06:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L86dOj4784484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:06:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L86UdA022919
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:06:31 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V4 0/2] Add support for OCC command/response interface
Date: Wed, 21 Jun 2017 13:36:25 +0530
Message-Id: <1498032387-26010-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/opal-occ.c      | 313 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   8 +
 7 files changed, 413 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c

-- 
1.8.3.1
