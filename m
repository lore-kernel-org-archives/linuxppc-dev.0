Return-Path: <srs0=y3wq=ju=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LTG44M8fzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:57:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41LTG43n2Xz8tKh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:57:00 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41LTG36kXCz9s29
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2018 03:56:59 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64Hnmc5063813
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2018 13:56:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k104dx4f3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 04 Jul 2018 13:56:57 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 4 Jul 2018 18:56:55 +0100
Subject: [PATCH v6 0/8] powerpc/pseries: Machine check handler improvements.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Suchanek <msuchanek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 04 Jul 2018 23:26:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153072695700.29016.8614312307132803349.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some improvement to Machine check handler
for pSeries. Patch 1 fixes a buffer overrun issue if rtas extended error
log size is greater than RTAS_ERROR_LOG_MAX.
Patch 2 fixes an issue where machine check handler crashes
kernel while accessing vmalloc-ed buffer while in nmi context.
Patch 3 fixes endain bug while restoring of r3 in MCE handler.
Patch 5 implements a real mode mce handler and flushes the SLBs on SLB error.
Patch 6 display's the MCE error details on console.
Patch 7 saves and dumps the SLB contents on SLB MCE errors to improve the
debugability.
Patch 8 consolidates mce early real mode handling code.

Change in V6:
- Introduce patch 8 to consolidate early real mode handling code.
- Address Nick's comment on erroneous hunk.

Change in V5:
- Use min_t instead of max_t.
- Fix an issue reported by kbuild test robot and address review comments.

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

Mahesh Salgaonkar (8):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
      powerpc/pseries: Defer the logging of rtas error to irq work queue.
      powerpc/pseries: Fix endainness while restoring of r3 in MCE handler.
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.
      powerpc/pseries: Dump the SLB contents on SLB MCE errors.
      powernv/pseries: consolidate code for mce early handling.


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    8 +
 arch/powerpc/include/asm/machdep.h            |    1 
 arch/powerpc/include/asm/paca.h               |    4 
 arch/powerpc/include/asm/rtas.h               |  116 ++++++++++++
 arch/powerpc/kernel/exceptions-64s.S          |   18 +-
 arch/powerpc/kernel/mce.c                     |   16 +-
 arch/powerpc/mm/slb.c                         |   63 +++++++
 arch/powerpc/platforms/pseries/pseries.h      |    1 
 arch/powerpc/platforms/pseries/ras.c          |  242 +++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/setup.c        |   27 +++
 10 files changed, 471 insertions(+), 25 deletions(-)

--
Signature
