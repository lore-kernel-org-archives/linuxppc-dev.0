Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C51CA2C014E
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 04:16:51 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:16:49 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2727EC9001D
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:16:47 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MI34M4259130
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 14:16:46 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MHvIVH013285
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 11:57:18 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MHvHgR013233
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 11:57:18 -0600
Message-ID: <51757951.2080007@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 12:54:25 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/12] NUMA CPU Reconfiguration using PRRN
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

Additionally, these updates solve an existing problem with the VPHN (Virtual
Processor Home Node) capability and allow us to re-enable this feature.

Nathan Fontenot

 arch/powerpc/include/asm/firmware.h               |    3 
 arch/powerpc/include/asm/prom.h                   |   46 ++--
 arch/powerpc/include/asm/rtas.h                   |    2 
 arch/powerpc/kernel/prom_init.c                   |   98 ++--------
 arch/powerpc/kernel/rtasd.c                       |   37 +++
 arch/powerpc/mm/numa.c                            |  214 +++++++++++++++-------
 arch/powerpc/platforms/pseries/firmware.c         |    1 
 arch/powerpc/platforms/pseries/mobility.c         |   24 +-
 powerpc/arch/powerpc/include/asm/firmware.h       |    4 
 powerpc/arch/powerpc/include/asm/machdep.h        |    2 
 powerpc/arch/powerpc/include/asm/prom.h           |   73 +++++++
 powerpc/arch/powerpc/include/asm/rtas.h           |    1 
 powerpc/arch/powerpc/include/asm/topology.h       |    5 
 powerpc/arch/powerpc/kernel/prom_init.c           |    2 
 powerpc/arch/powerpc/kernel/rtas.c                |   10 +
 powerpc/arch/powerpc/kernel/rtasd.c               |    7 
 powerpc/arch/powerpc/mm/numa.c                    |   62 ++++++
 powerpc/arch/powerpc/platforms/pseries/firmware.c |   49 ++++-
 powerpc/arch/powerpc/platforms/pseries/mobility.c |   20 +-
 powerpc/arch/powerpc/platforms/pseries/pseries.h  |    5 
 powerpc/arch/powerpc/platforms/pseries/setup.c    |   40 ++--
 21 files changed, 500 insertions(+), 205 deletions(-)

Updates for v3 of the patchset:

1/12 - Updated to use a ppc_md interface to invoke device tree updates, this
corrects the build break previously seen in patch 2/12 for non-pseries
platforms.

2/12 - New patch in the series to correct the parsing of the buffer returned
from ibm,update-properties rtas call.

5/12 - The parsing of architecture vector 5 has been made more efficient.

7/12 - Correct #define used in call the firmware_has_feature()

8/12 - Updated calling of stop_machine() to only call it once per PRRN event.

12/12 - Added inclusion of topology.h to rtasd.c to correct a build failure
on non-pseries platforms.
