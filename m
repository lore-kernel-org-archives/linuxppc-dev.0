Return-Path: <srs0=mudr=kw=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGlV2yTqzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:16:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lGlV0PZWz8tx8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:16:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lGlT2BPgz9s4s
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 00:16:04 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77EFeiU030520
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2018 10:16:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kqb3xnds3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Aug 2018 10:16:01 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 7 Aug 2018 15:16:00 +0100
Subject: [PATCH v7 0/9] powerpc/pseries: Machine check handler improvements.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Suchanek <msuchanek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 07 Aug 2018 19:45:54 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some improvement to Machine check handler
for pseries. Patch 1 fixes a buffer overrun issue if rtas extended error
log size is greater than RTAS_ERROR_LOG_MAX.
Patch 2 fixes an issue where machine check handler crashes
kernel while accessing vmalloc-ed buffer while in nmi context.
Patch 3 fixes endain bug while restoring of r3 in MCE handler.
Patch 5 implements a real mode mce handler and flushes the SLBs on SLB error.
Patch 6 display's the MCE error details on console.
Patch 7 saves and dumps the SLB contents on SLB MCE errors to improve the
debugability.
Patch 8 adds sysctl knob for recovery action on recovered MCEs.
Patch 9 consolidates mce early real mode handling code.

Change in V7:
- Fold Michal's patch into patch 5
- Handle MSR_RI=0 and evil context case in MC handler in patch 5.
- Patch 7: Print slb cache ptr value and slb cache data.
- Move patch 8 to patch 9.
- Introduce patch 8 add sysctl knob for recovery action on recovered MCEs.

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

Mahesh Salgaonkar (9):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
      powerpc/pseries: Defer the logging of rtas error to irq work queue.
      powerpc/pseries: Fix endainness while restoring of r3 in MCE handler.
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.
      powerpc/pseries: Dump the SLB contents on SLB MCE errors.
      powerpc/mce: Add sysctl control for recovery action on MCE.
      powernv/pseries: consolidate code for mce early handling.


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    8 +
 arch/powerpc/include/asm/machdep.h            |    1 
 arch/powerpc/include/asm/mce.h                |    2 
 arch/powerpc/include/asm/paca.h               |    7 +
 arch/powerpc/include/asm/rtas.h               |  116 ++++++++++++
 arch/powerpc/kernel/exceptions-64s.S          |   42 ++++
 arch/powerpc/kernel/mce.c                     |   73 +++++++-
 arch/powerpc/kernel/traps.c                   |    3 
 arch/powerpc/mm/slb.c                         |   79 ++++++++
 arch/powerpc/platforms/powernv/setup.c        |   15 ++
 arch/powerpc/platforms/pseries/pseries.h      |    1 
 arch/powerpc/platforms/pseries/ras.c          |  242 +++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/setup.c        |   27 +++
 13 files changed, 588 insertions(+), 28 deletions(-)

--
Signature
