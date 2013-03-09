Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F32192C0363
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 14:56:27 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 22:56:24 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4DE49C9001A
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 22:56:21 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r293uLba286898
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 22:56:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r293uKet026992
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Mar 2013 00:56:20 -0300
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r293uJ2X026961
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Mar 2013 00:56:20 -0300
Message-ID: <513AB2E3.6090209@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 21:56:19 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/11] NUMA CPU Reconfiguration using PRRN
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
---

 arch/powerpc/include/asm/prom.h                   |   42 +++--
 arch/powerpc/include/asm/rtas.h                   |    2 
 arch/powerpc/kernel/prom_init.c                   |   89 +---------
 arch/powerpc/kernel/rtasd.c                       |   35 ++++
 arch/powerpc/mm/numa.c                            |  183 ++++++++++++++--------
 powerpc/arch/powerpc/include/asm/prom.h           |   73 ++++++++
 powerpc/arch/powerpc/include/asm/rtas.h           |    1 
 powerpc/arch/powerpc/include/asm/topology.h       |    5 
 powerpc/arch/powerpc/kernel/prom.c                |   19 ++
 powerpc/arch/powerpc/kernel/prom_init.c           |    2 
 powerpc/arch/powerpc/kernel/rtasd.c               |    6 
 powerpc/arch/powerpc/mm/numa.c                    |   62 +++++++
 powerpc/arch/powerpc/platforms/pseries/mobility.c |   21 +-
 13 files changed, 372 insertions(+), 168 deletions(-)
