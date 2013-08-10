Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DD272C011E
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 03:49:04 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 18:49:00 +0100
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3DCC038C8027
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:48:56 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AHmvh2111082
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:48:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AHmusd032340
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 14:48:57 -0300
Date: Sat, 10 Aug 2013 10:48:32 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/7]: Enable 'perf mem' command for Power
Message-ID: <20130810174831.GA15551@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 0/7]: Enable 'perf mem' command for Power

'perf mem' command enables analyzing the memory operations of an
application. It needs the kernel to export the memory hierarcy
level from which a load instruction was satisfied.

It also needs the Power kernel to make the 'mem-loads' and 'mem-stores'
generic events available in sysfs. While there, we also export the
other Power8 generic events in sysfs.

Thanks to input from Stephane Eranian and Michael Ellerman.

P.S. The patchset builds on several configurations including pmac32_defconfig.
     But I am unable to verify the build on few other configs due to a problem
     unrleated to this patchset. That is being discussed in a separate thread.
     I would like some feedback on this patchset in the meanwhile.

Sukadev Bhattiprolu (7):
  powerpc/perf: Rename Power8 macros to start with PME
  powerpc/perf: Export Power8 generic events in sysfs
  powerpc/perf: Create mem-loads/mem-stores events for Power8
  powerpc/perf: Create mem-loads/mem-stores events for Power7
  powerpc/perf: Define big-endian version of perf_mem_data_src
  powerpc/perf: Export Power8 memory hierarchy info to user space.
  powerpc/perf: Export Power7 memory hierarchy info to user space.

 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/perf/core-book3s.c              |   11 +++
 arch/powerpc/perf/power7-pmu.c               |   81 ++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c               |  106 +++++++++++++++++++++++---
 include/uapi/linux/perf_event.h              |   55 +++++++++++++
 5 files changed, 243 insertions(+), 12 deletions(-)
