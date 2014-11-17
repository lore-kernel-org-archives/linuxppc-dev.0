Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E824E1A010D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 08:44:08 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 14:44:06 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 125611FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:32:49 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHLi4lt44040194
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 22:44:04 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHLi3BC002308
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:44:04 -0700
Message-ID: <546A6C23.1080800@linux.vnet.ibm.com>
Date: Mon, 17 Nov 2014 15:44:03 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 0/6] pseries: Move memory hotplug to the kernel
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to better support device hotplug (cpu, memory, and pci) in the
PowerVM and PowerKVM environments, the handling of device hotplug
could be updated so that the act of hotplugging a device occurs entirely
in the kernel. This patch set begins to address this by moving
memory hotplug to the kernel. Patches to follow will do the same
for cpu and pci devices.

To provide background, the current handling of memory hotplug is
handled by the drmgr command. This command is invoked when memory
add/remove requests are made at the HMC and conveyed to a partition
through the RSCT framework. The drmgr command then performs parts
of the hotplug in user-space and makes requests to the kernel to perform
other pieces. This is not really ideal, we can do everything in the
kernel and do it faster.

In this patchset, hotplug events will now be communicated to the kernel
in the form of rtas hotplug events. For PowerKVM systems this is done
by qemu using the ras epow interrupt. For PowerVM systems the drmgr
command will be updated to create a rtas hotplug event and send it to
the kernel via a new /sys/kernel/dlpar interface. Both of these
entry points for hotplug rtas events then call a common routine
for handling rtas hotplug events.

-Nathan

Patch 1/6
- Add definition of hotplug rtas event sections.

Patch 2/6
- Update struct of_drconf_cell to use __be64/__be32
 
Patch 3/6
- Export the dlpar_[acquire|release]drc() routines.

Patch 4/6
- Create the new /sys/kernel/dlpar interface

Patch 5/6
- Implement memory hotplug add in the kernel.

Patch 6/6
- Implement memory hotplug remove in the kernel.

 include/asm/prom.h                 |   10 
 include/asm/rtas.h                 |   26 ++
 platforms/pseries/dlpar.c          |   72 +++++
 platforms/pseries/hotplug-memory.c |  469 ++++++++++++++++++++++++++++++++++++-
 platforms/pseries/pseries.h        |   12 
 5 files changed, 576 insertions(+), 13 deletions(-)
