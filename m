Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE9022C0104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 01:35:34 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 09:35:31 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C612FC9001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:35:28 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OFZSnj294334
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:35:28 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OFYNfP016743
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:34:23 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OFYGHH016146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:34:17 -0600
Message-ID: <5177FB74.2050709@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 10:34:12 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/13] NUMA CPU Reconfiguration using PRRN
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

 arch/powerpc/include/asm/firmware.h               |    7 
 arch/powerpc/include/asm/prom.h                   |   46 ++--
 arch/powerpc/include/asm/rtas.h                   |    2 
 arch/powerpc/kernel/prom_init.c                   |   98 ++--------
 arch/powerpc/kernel/rtasd.c                       |   46 ++++
 arch/powerpc/mm/numa.c                            |  214 +++++++++++++++-------
 arch/powerpc/platforms/pseries/firmware.c         |   50 ++++-
 arch/powerpc/platforms/pseries/mobility.c         |   21 +-
 powerpc/arch/powerpc/include/asm/firmware.h       |    1 
 powerpc/arch/powerpc/include/asm/prom.h           |   71 +++++++
 powerpc/arch/powerpc/include/asm/rtas.h           |    4 
 powerpc/arch/powerpc/include/asm/topology.h       |    5 
 powerpc/arch/powerpc/kernel/prom_init.c           |    2 
 powerpc/arch/powerpc/kernel/rtasd.c               |    7 
 powerpc/arch/powerpc/mm/numa.c                    |   62 ++++++
 powerpc/arch/powerpc/platforms/pseries/firmware.c |    8 
 powerpc/arch/powerpc/platforms/pseries/mobility.c |   20 +-
 powerpc/arch/powerpc/platforms/pseries/pseries.h  |    5 
 powerpc/arch/powerpc/platforms/pseries/setup.c    |   40 ++--
 19 files changed, 496 insertions(+), 213 deletions(-)

Updates for v4 of the patchset:
------------------------------
1/13 - Remove the hook in ppc_md for updating te device tree.

3/13 - Put the rtas code to handle PRRN events in #ifdef CONFIG_PPC_PSERIES

4/13 - New patch. Update the iteration over arrays in firmware.c to use
ARRAY_SIZE()

5/13 (was 4/12) - Remove the unnecessary #ifdef

6/13 (was 5/12) - Removed the references to platform_has_feature() and update
the firmware.c updates to use ARRAY_SIZE() for iteration.

8/13 (was 7/12) - Correct subject.

13/13 (was 12/12) - Remove inlining of prrn_is_enabled().

Updates for v3 of the patchset:
------------------------------
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
