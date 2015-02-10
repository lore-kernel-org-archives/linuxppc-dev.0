Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16A791A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:40:55 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 12:40:52 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A04E31FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:32:01 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1AJenZM35455088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:40:49 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AJenUP026728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:40:49 -0700
Received: from [9.41.149.215] (dhcp-9-41-149-215.austin.ibm.com [9.41.149.215])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1AJen9T026709
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:40:49 -0700
Message-ID: <54DA5EC1.2060403@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:40:49 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 0/5] pseries: Move memory hotplug to the kernel
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to improve hotplug support for cpus, memory, and pci devices in
the PowerVM and PowerKVM environments, the handling of hotplugging devices
should be updated to perform the hotplug operation entirely in the kernel.
This patch set begins to address this by providing a framework and a common
entry point for hotplug operations for the PowerVM anbd PowerKVM environments.
This patch set also moves memory hotplug into the kernel. Patches to follow
will do the same for cpus and pci devices.

To provide background, the current handling of memory hotplug is
done by the drmgr command in user space. This command is invoked when memory
add/remove requests are made at the HMC and conveyed to a partition
through the RSCT framework. The drmgr command then performs parts
of the hotplug in user-space and makes requests to the kernel to perform
other pieces. This is not really ideal, we can do everything in the
kernel and do it faster.

In this patch set the handling of hotplug requests for pseries kernels
uses rtas hotplug events to communicate the hotplug request. For PowerKVM
systems the rtas hotplug request is communicated to the guest by qemu
using the ras epow interrupt, the current scheme also used for pci hotplug.
For PowerVM systems the drmgr command will be updated to communicate the
hotplug request by writing to /sys/kernel/dlpar. The format for hotplug
requests for this file is of the form "<resource> <action> <id_type> <id>".
The kernel will parse this request and create a rtas hotplug section that
can be passed to a common kernel hotplug entry point for PowerVM and PowerKVM
environments.

-Nathan

Patch 1/5
- Add definition of hotplug rtas event sections.

Patch 2/5
- export the dlpar_[acquire|release]_drc() routines.

Patch 3/5
- Create the new /sys/kernel/dpar interface

Patch 4/5
- Implement memory hotplug add in the kernel.

Patch 5/5
- Implement memory hotplug remove in the kernel.

 include/asm/rtas.h                 |   26 ++
 platforms/pseries/dlpar.c          |  118 ++++++++-
 platforms/pseries/hotplug-memory.c |  477 ++++++++++++++++++++++++++++++++++++-
 platforms/pseries/pseries.h        |   12 
 4 files changed, 629 insertions(+), 4 deletions(-)
