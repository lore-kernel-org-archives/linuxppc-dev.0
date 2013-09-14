Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDE3E2C0144
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 10:49:24 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 13 Sep 2013 20:49:20 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 112B7C9003E
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 20:49:18 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8E0nI3t65470672
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 00:49:18 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8E0nGT8001339
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 21:49:17 -0300
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8][v4] powerpc/perf: Export memory hierarchy level in
 Power7/8.
Date: Fri, 13 Sep 2013 17:49:07 -0700
Message-Id: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michaele@au1.ibm.com>, Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power7 and Power8 processors save the memory hierarchy level (eg: L2, L3)
from which a load or store instruction was satisfied. Export this hierarchy
information to the user via the perf_mem_data_src object.

Thanks to input from Stephane Eranian, Michael Ellerman, Michael Neuling.

Sukadev Bhattiprolu (8):
  powerpc/perf: Rename Power8 macros to start with PME
  powerpc/perf: Export Power8 generic events in sysfs
  powerpc/perf: Add PM_MRK_GRP_CMPL event to sysfs.
  powerpc/perf: Define big-endian version of perf_mem_data_src
  powerpc/perf: Export Power8 memory hierarchy info to user space.
  powerpc: Rename branch_opcode() to instr_opcode()
  power: implement is_instr_load_store().
  powerpc/perf: Export Power7 memory hierarchy info to user space.

 arch/powerpc/include/asm/code-patching.h     |    1 +
 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/lib/code-patching.c             |   96 ++++++++++++++++++++++-
 arch/powerpc/perf/core-book3s.c              |   11 +++
 arch/powerpc/perf/power7-pmu.c               |   94 +++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c               |  105 +++++++++++++++++++++++---
 include/uapi/linux/perf_event.h              |   58 ++++++++++++++
 7 files changed, 352 insertions(+), 15 deletions(-)

-- 
1.7.9.5
