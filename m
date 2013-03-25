Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83C682C009E
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Mar 2013 05:44:13 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 25 Mar 2013 12:44:07 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2903519D8067
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2013 12:43:59 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2PIhstn149810
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2013 12:43:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2PIhrZG017722
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2013 12:43:53 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2PIhrt8017699
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2013 12:43:53 -0600
Message-ID: <51509AE8.8070803@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2013 13:43:52 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/11] NUMA CPU Reconfiguration using PRRN
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer firmware on Power systems can transparently reassign platform resources
(CPU and Memory) in use. For instance, if a processor or memory unit is
predicted to fail, the platform may transparently move the processing to an
equivalent unused processor or the memory state to an equivalent unused
memory unit. However, reassigning resources across NUMA boundaries may alter
the performance of the partition. When such reassignment is necessary, the
Platform Resource Reassignment Notification (PRRN) option provides a
mechanism to inform the Linux kernel of changes to the NUMA affinity of
its platform resources.

PRRN Events are RTAS events sent up through the event-scan mechanism on
Power. When these events are received the system needs can get the updated
device tree affinity information for the affected CPUs/memory via the
rtas update-nodes and update-properties calls. This information is then
used to update the NUMA affinity of the CPUs/Memory in the kernel.

This patch set adds the ability to recognize PRRN events, update the device
tree and kernel information for CPUs (memory will be handled in a later
patch), and add an interface to enable/disable toplogy updates from /proc.

Additionally, these updates solve an exisitng problem with the VPHN (Virtual
Processor Home Node) capability and allow us to re-enable this feature.

Nathan Fontenot

Updates for Version 2 of this patchset

- Merged the functionality of platform_has_feature into the existing
  firmware_has_feature routine.
- Corrected the new way certain bits in the architecture vector are
  defined based on config options.
---

 arch/powerpc/include/asm/firmware.h               |    3 
 arch/powerpc/include/asm/prom.h                   |   46 ++---
 arch/powerpc/include/asm/rtas.h                   |    2 
 arch/powerpc/kernel/prom_init.c                   |   98 ++---------
 arch/powerpc/kernel/rtasd.c                       |   35 ++++
 arch/powerpc/mm/numa.c                            |  183 ++++++++++++++--------
 arch/powerpc/platforms/pseries/firmware.c         |    1 
 powerpc/arch/powerpc/include/asm/firmware.h       |    4 
 powerpc/arch/powerpc/include/asm/prom.h           |   73 ++++++++
 powerpc/arch/powerpc/include/asm/rtas.h           |    1 
 powerpc/arch/powerpc/include/asm/topology.h       |    5 
 powerpc/arch/powerpc/kernel/prom_init.c           |    2 
 powerpc/arch/powerpc/kernel/rtasd.c               |    6 
 powerpc/arch/powerpc/mm/numa.c                    |   62 +++++++
 powerpc/arch/powerpc/platforms/pseries/firmware.c |   67 +++++++-
 powerpc/arch/powerpc/platforms/pseries/mobility.c |   21 +-
 powerpc/arch/powerpc/platforms/pseries/pseries.h  |    5 
 powerpc/arch/powerpc/platforms/pseries/setup.c    |   40 +++-
 18 files changed, 455 insertions(+), 199 deletions(-)
