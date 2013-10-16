Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBCFD2C00C8
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:11 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 20:07:09 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CB1A33E4003E
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:06 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G276uU324536
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:06 -0600
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G275qs022438
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:06 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 00/10][v6] powerpc/perf: Export memory hierarchy level in
 Power7/8.
Date: Tue, 15 Oct 2013 19:06:32 -0700
Message-Id: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
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

Thanks to input from Stephane Eranian, Michael Ellerman, Michael Neuling
and Anshuman Khandual.

Sukadev Bhattiprolu (10):
  powerpc: Rename branch_opcode() to instr_opcode()
  powerpc/Power7: detect load/store instructions
  tools/perf: silence compiler warnings
  tools/perf: Remove local byteorder.h.
  powerpc/perf: Remove PME_ prefix for power7 events
  powerpc/perf: Export Power8 generic events in sysfs
  powerpc/perf: Add Power8 event PM_MRK_GRP_CMPL to sysfs.
  powerpc/perf: Define big-endian version of perf_mem_data_src
  powerpc/perf: Export Power8 memory hierarchy info to user space.
  powerpc/perf: Export Power7 memory hierarchy info to user space.

 arch/powerpc/include/asm/code-patching.h     |    1 +
 arch/powerpc/include/asm/perf_event_server.h |    4 +-
 arch/powerpc/lib/code-patching.c             |   51 +++++++++++-
 arch/powerpc/perf/core-book3s.c              |   11 +++
 arch/powerpc/perf/power7-pmu.c               |  112 +++++++++++++++++++++++---
 arch/powerpc/perf/power8-events-list.h       |   21 +++++
 arch/powerpc/perf/power8-pmu.c               |   97 ++++++++++++++++++++--
 include/uapi/linux/perf_event.h              |   16 ++++
 tools/perf/Makefile                          |    1 -
 tools/perf/util/include/asm/byteorder.h      |    2 -
 tools/perf/util/include/linux/types.h        |   20 +++++
 tools/perf/util/srcline.c                    |    4 +-
 12 files changed, 316 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h
 delete mode 100644 tools/perf/util/include/asm/byteorder.h

-- 
1.7.9.5
