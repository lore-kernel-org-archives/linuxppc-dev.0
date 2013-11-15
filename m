Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E38132C00A6
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:50 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 14:20:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 962B73578040
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF42tOi3342706
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:02:55 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF4KiQa006926
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:45 +1100
Subject: [PATCH 0/2] powerpc/powernv: Plumb fsp memory errors to memory poison
 infrastructure.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 09:50:43 +0530
Message-ID: <20131115041952.5748.19640.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please find the patch set that implements FSP memory error handling and
plumbs then into memory poison infrastructure.

Patch 1 enables the generic memory hwpoisoning infrastructure for ppc64.
Patch 2 reads the memory errors reported from opal layer and plumbs them
into memory poison infrastructure.

This patch uses new messaging channel infrastructure (proposed through a
separate patch at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-November/113331.html)
to pull the fsp memory errors to linux.

Thanks,
-Mahesh.
---

Mahesh Salgaonkar (2):
      powerpc/powernv: Add config option for hwpoisoning.
      powerpc/powernv: Get FSP memory errors and plumb into memory poison infrastructure.


 arch/powerpc/Kconfig                               |    6 +
 arch/powerpc/include/asm/opal.h                    |   52 +++++++
 arch/powerpc/platforms/powernv/Makefile            |    1 
 .../powerpc/platforms/powernv/opal-memory-errors.c |  146 ++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-memory-errors.c

-- 
-Mahesh
