Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E167A1A02F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:42:42 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 11:42:39 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7E318C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:42:31 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFgb4m5636474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:42:37 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFgb1q026768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:42:37 -0400
Received: from localhost.localdomain ([9.80.40.207])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5HFga5O026694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:42:36 -0400
Message-ID: <53A061EC.10403@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 10:42:36 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC PATCH 0/4] Update hotplug for pseries systems
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support device hotplug (cpu, memory, and pci) in both the
PowerVM and the PowerKVM environments the handling of hotplug events
will need to be updated. This patch set adresses this by creating a
common entry point for handling hotplug events in the kernel that
can be used in both PowerVM and PowerKVM environments. To accomplish
this several changes need to be made.

For PowerVM systems hotplug (DLPAR) events are requested by users from the
HMC which then communicates the request to the partitions via the RSCT
framework. The RSCT framework then invokes the drmgr command to handle
the hotplug event. The drmgr command performs some of the work in user
space and makes calls into the kernel to handle the remaining work.

For PowerKVM systems hotplug events are communicated to the guest via
the ras epow interrupt by qemu. We could have the rtas event sent up
to user space through rtas_errd that would then invoke drmgr. This is
not the most ideal solution and it would be nicer to have hotplug
handled completely in the kernel.

To do this, hotplug events will now be communicated to the kernel in
the form of rtas hotplug events. For PowerKVM systems this is done
by qemu using the ras epow interrupt. For PowerVM systems the drmgr
command will be updated to create a rtas hotplug event and send it to
the kernel via a new /proc/powerpc/dlpar interface. Both of these
entry points for hotplug rtas events then call a common routine
for handling rtas hotplug events.

Additionally we will need to be able to handle all of the work to
do resource hotplug in the kernel. This patch set addresses this for
cpu and memory hotplug, pci hotplug will be done later.

Once all of the work is done to move hotplug handling into the kernel
we should also be able to get rid of the /proc/powerpc/ofdt interface.

Of course these updates do depend on updating the drmgr command. If
you care to look the updates for this is here;

https://github.com/nfont/powerpc-utils/tree/mem_rtas_hp

Patch 1/4:
o Create a common rtas hotplug event handling routine
o Create the /proc/powerpc/dlpar interface for PowerVM systems
o Implement memory hotplug handling in the kernel.

Patch 2/4:
o Move the cpu hotplug code from pseries/dlpar.c to pseries/hotplug-cpu.c

Patch 3/4:
o Update cpu hotplug handling to allow for invocation from rtas event
  notifications.

Patch 4/4:
o Update the ras epow interrupt handler to recognize hotplug rtas events

This code (except for patch 4/4 which I cannot test right now) has been tested
on PowerVM systems. There are some error paths that still need to be tested
and of course testing on PowerKVM when cpu and memory hotplug is enabled
for Power.

Thoughts?

-Nathan
---
 include/asm/rtas.h                 |   27 ++
 kernel/rtas.c                      |    7 
 platforms/pseries/dlpar.c          |  253 ++++++--------------------
 platforms/pseries/hotplug-cpu.c    |  358 +++++++++++++++++++++++++++++++++++++
 platforms/pseries/hotplug-memory.c |  351 ++++++++++++++++++++++++++++++------ 
 platforms/pseries/pseries.h        |    6                                      
 platforms/pseries/ras.c            |   12 +                                    
 platforms/pseries/reconfig.c       |    6 
 8 files changed, 780 insertions(+), 240 deletions(-)
