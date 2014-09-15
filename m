Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5451A0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 06:26:51 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 14:26:45 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D21CAC90043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:26:33 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FKQgR27733612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 20:26:42 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FKQg1N001794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:26:42 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8FKQfrc001777
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:26:42 -0400
Message-ID: <54174B81.50504@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:26:41 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/5] pseries: Move memory hotplug to the kernel
Content-Type: text/plain; charset=ISO-8859-1
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
the kernel via a new /proc/powerpc/dlpar interface. Both of these
entry points for hotplug rtas events then call a common routine
for handling rtas hotplug events.

-Nathan

Patch 1/5
- Add definition of hotplug rtas event sections.

Patch 2/5
- export the dlpar_[acquire|release]drc() routines.

Patch 3/5
- Create the new /proc/powerpc/dlpar interface

Patch 4/5
- Implement memory hotplug add in the kernel.

Patch 5/5
- Implement memory hotplug remove in the kernel.

 include/asm/rtas.h                 |   26 ++
 platforms/pseries/dlpar.c          |   63 ++++++-
 platforms/pseries/hotplug-memory.c |  332 ++++++++++++++++++++++++++++++++++++-
 platforms/pseries/pseries.h        |   12 +
 4 files changed, 431 insertions(+), 2 deletions(-)
