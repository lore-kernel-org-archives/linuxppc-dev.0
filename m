Return-Path: <srs0=tbmk=jo=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GcX14lHLzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 21:10:41 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41GcX13WzVz8w0H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 21:10:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41GcX105Jgz9s31
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 21:10:40 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SB9sg8051306
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 07:10:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jvtseb6px-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2018 07:10:37 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 28 Jun 2018 12:10:35 +0100
Subject: [PATCH v4 0/6] powerpc/pseries: Machien check handler improvements.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 28 Jun 2018 16:40:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153018397703.31589.3105355336278825912.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some improvement to Machine check handler
for pseries. Patch 1 fixes an issue where machine check handler crashes
kernel while accessing vmalloc-ed buffer while in nmi context.
Patch 2 fixes endain bug while restoring of r3 in MCE handler.
Patch 4 implements a real mode mce handler and flushes the SLBs on SLB error.
Patch 5 display's the MCE error details on console.
Patch 6 saves and dumps the SLB contents on SLB MCE errors to improve the
debugability.

Change in V4:
- Flush the SLBs in real mode mce handler to handle SLB errors for entry 0.
- Allocate buffers per cpu to hold rtas error log and old slb contents.
- Defer the logging of rtas error log to irq work queue.

Change in V3:
- Moved patch 5 to patch 2

Change in V2:
- patch 3: Display additional info (NIP and task info) in MCE error details.
- patch 5: Fix endain bug while restoring of r3 in MCE handler.


---

Mahesh Salgaonkar (6):
      powerpc/pseries: Defer the logging of rtas error to irq work queue.
      powerpc/pseries: Fix endainness while restoring of r3 in MCE handler.
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.
      powerpc/pseries: Dump the SLB contents on SLB MCE errors.


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    8 +
 arch/powerpc/include/asm/machdep.h            |    1 
 arch/powerpc/include/asm/paca.h               |    4 
 arch/powerpc/include/asm/rtas.h               |  116 ++++++++++++
 arch/powerpc/kernel/exceptions-64s.S          |   42 ++++
 arch/powerpc/kernel/mce.c                     |   16 +-
 arch/powerpc/mm/slb.c                         |   63 +++++++
 arch/powerpc/platforms/powernv/opal.c         |    1 
 arch/powerpc/platforms/pseries/pseries.h      |    1 
 arch/powerpc/platforms/pseries/ras.c          |  236 +++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/setup.c        |   27 +++
 11 files changed, 497 insertions(+), 18 deletions(-)

--
Signature
