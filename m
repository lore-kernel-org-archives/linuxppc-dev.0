Return-Path: <srs0=mams=lk=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zgTC4830zDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:31:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41zgTC3TX8z8tQV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:31:43 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41zgTB6vhqz9s55
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 04:31:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7RIUR9c056035
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2018 14:31:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m4ms3mmv6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2018 14:31:40 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 27 Aug 2018 19:31:38 +0100
Subject: [PATCH v9 0/5] powerpc/pseries: Machine check handler improvements.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michal Suchanek <msuchanek@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>
Date: Tue, 28 Aug 2018 00:01:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153539459821.20001.16391636830334046461.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes some improvement to Machine check handler
for pSeries. First 3 patches from v7 revision are already in powerpc next.
Posting rest of the patches with review comments. This patch series drops
the sysctl knob patch that was proposed in v7. The SLB recovery code now
uses flush_and_reload_slb() from mce_power.c.

Patch 1 defines MCE error event section.
Patch 2 implements a real mode mce handler and flushes the SLBs on SLB error.
Patch 3 display's the MCE error details on console.
Patch 4 saves and dumps the SLB contents on SLB MCE errors to improve the
debugability.
Patch 5 consolidates mce early real mode handling code.

Change in V9:
- Move mce_exceptions counting to powernv's virtual mode handler.
- Recover from ERAT errors.
- Minor changes to fix few warnings/checks from checkpatch.pl

Change in V8:
- Move mce error log structure definition to ras.c
- Use flush_and_reload_slb() from mce_power.c.
- Limit the slb saving to single level of mce recursion.
- Move mce_faulty_slbs and slb_save_cache_ptr under CONFIG_PPC_BOOK3S_64
  instead of CONFIG_PPC_PSERIES.
- Drop the sysctl knob patch.

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

Mahesh Salgaonkar (5):
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.
      powerpc/pseries: Dump the SLB contents on SLB MCE errors.
      powernv/pseries: consolidate code for mce early handling.


 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    7 +
 arch/powerpc/include/asm/machdep.h            |    1 
 arch/powerpc/include/asm/mce.h                |    3 
 arch/powerpc/include/asm/paca.h               |    6 
 arch/powerpc/include/asm/rtas.h               |   13 +
 arch/powerpc/kernel/exceptions-64s.S          |   42 +++
 arch/powerpc/kernel/mce.c                     |    9 -
 arch/powerpc/kernel/mce_power.c               |    2 
 arch/powerpc/mm/slb.c                         |   72 ++++++
 arch/powerpc/platforms/powernv/opal.c         |    2 
 arch/powerpc/platforms/powernv/setup.c        |   11 +
 arch/powerpc/platforms/pseries/pseries.h      |    1 
 arch/powerpc/platforms/pseries/ras.c          |  303 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c        |   14 +
 14 files changed, 474 insertions(+), 12 deletions(-)

--
-Mahesh
