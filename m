Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F97D2C00B6
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 10:15:32 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 18:15:30 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6CF1D3E4003F
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 18:15:27 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r920FRfC332422
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:15:27 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r920IV6t028005
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:18:32 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: 
Date: Tue,  1 Oct 2013 17:15:01 -0700
Message-Id: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Subject: [PATCH 0/9][v5] powerpc/perf: Export memory hierarchy level in Power7/8.

Power7 and Power8 processors save the memory hierarchy level (eg: L2, L3)
from which a load or store instruction was satisfied. Export this hierarchy
information to the user via the perf_mem_data_src object.

Thanks to input from Stephane Eranian, Michael Ellerman, Michael Neuling
and Anshuman Khandual.

Sukadev Bhattiprolu (9):
  powerpc/perf: Rename Power8 macros to start with PME
  powerpc/perf: Export Power8 generic events in sysfs
  powerpc/perf: Add Power8 event PM_MRK_GRP_CMPL to sysfs.
  powerpc: Rename branch_opcode() to instr_opcode()
  powerpc: implement is_instr_load_store().
  powerpc/perf: Define big-endian version of perf_mem_data_src
  powerpc/perf: Export Power8 memory hierarchy info to user space.
  powerpc/perf: Export Power7 memory hierarchy info to user space.
  powerpc/perf: Update perf-mem man page for Power

 arch/powerpc/include/asm/code-patching.h     |    1 +
 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/lib/code-patching.c             |   96 ++++++++++++++++++++++-
 arch/powerpc/perf/core-book3s.c              |   11 +++
 arch/powerpc/perf/power7-pmu.c               |   94 +++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c               |  105 +++++++++++++++++++++++---
 include/uapi/linux/perf_event.h              |   58 ++++++++++++++
 tools/perf/Documentation/perf-mem.txt        |   11 +++
 tools/perf/util/include/asm/byteorder.h      |    1 +
 9 files changed, 364 insertions(+), 15 deletions(-)

-- 
1.7.9.5
