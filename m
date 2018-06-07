Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBB6WD5zF34D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:50 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FOOm4121279
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5pewb7q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:47 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 09:25:46 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPiRK12386588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 08:25:44 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A569778066
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D86C7805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/5] powerpc: Misc. ptrace regset fixes
Date: Thu,  7 Jun 2018 12:25:29 -0300
Message-Id: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series attempts to fix a few issues with ptrace regsets.

Patch 1 simply inverts the active predicate for ebb_set. I don't know
if there was a reason for having opposite predicates in
ebb_get/ebb_set, but I assumed this was a typo.

Patch 2 adds the usual HTM prologue for regsets to the tm_cgpr32
get/set functions, so that the cgprs are flushed. I don't really
understand the need for flushing the fp and altivec states, but I
copied that over since it was done in the regular tm_cgpr get/set
functions.

Patch 3 changes the pmu get/set functions so that they don't read or
write outside the bounds of thread_struct.mmcr0. The endianess of the
kernel is used to determine where the mmcr0 word should be placed (or
read from) in its corresponding 64-bit slot in the regset. I am not
sure if this is the correct way to go, or if the endianess of the
thread being traced should determine this position (can the kernel run
threads with a different endianess?). I used the kernel endianess
because that is what seems to happen for other registers smaller than
their regset fields (for instance, it seems that checkpointed CR is
saved by the kernel as a doubleword, so the the position of the word
depends on the kernel's endianess). The rest of the function assumes
that unsigned longs are doublewords, so the patch assumes that an
unsigned is a word. This patch (and the original pmu_get/set
functions) might not work if the kernel is compiled in 32 bits.

Patch 4 adds the VSX regset to compat_regsets, which could cause out
of bounds writes in fs/binfmt_elf.c.

Patch 5 adds the PMU regset to compat_regsets.

I also noticed that the regset for CGPRs for 32-bit threads has 48 * 8
bytes (same as the one for 64-bit threads), but the data only occupies
the first 48 * 4 bytes (like for the 32-bit GPR regset). I am not sure
if this was intended, or if it can be changed now that other programs
might already assume the 48 * 8 size. If the kernel is compiled in
32-bits, the size will change (because it depends on sizeof (long)),
but I don't know if HTM and the corresponding regsets are supported in
the first place for a 32-bit kernel.

I haven't added the PKEY regset to compat_regsets. Does that make
sense for 32-bit threads?

Pedro Franco de Carvalho (5):
  powerpc: Fix inverted active predicate for setting the EBB regset
  powerpc: Flush checkpointed gpr state for 32-bit processes in ptrace
  powerpc: Fix pmu get/set functions
  powerpc: Add VSX regset to compat_regsets
  powerpc: Add PMU regset to compat_regsets

 arch/powerpc/kernel/ptrace.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

-- 
2.13.6
