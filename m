Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB0F1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 07:47:06 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 15:47:02 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBGKk4A132440538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 20:46:04 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBGKk3xZ013827
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:46:03 -0500
Received: from [9.41.105.164] ([9.41.105.164])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBGKk2Fu013649
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:46:02 -0500
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH v3] powerpc/pseries: Move CPU DLPAR into the kernel
Message-ID: <5671CD8A.8000500@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 14:46:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To better support CPU hotplug in PowerKVM and PowerVM environments, the
handling of CPU dlpar should be done entirely in the kernel. This will allow
a common entry point to be used for PowerVM and PowerKVM CPU dlpar requests.

For both environments the entry point is the same one introduced in a previous
patch set that moved memory hotplug into the kernel. This entry point accepts
a rtas hotplug event which is either constructed when using the 
/sys/kernel/dlpar interface or is passed to the kernel when handling a
ras epow interrupt.

-Nathan

Patch 1/6:
- Consolidate cpu hotplug code from pseries/dlpar.c to pseries/hotplug-cpu.c

Patch 2/6:
- Factor out common code pieces for both environments

Patch 3/6:
- Update cpu dlpar error recovery

Patch 4/6:
- Add cpu hotplug remove capability

Patch 5/6:
- Add cpu hotplug add capability

Patch 6/6:
- Enable sysfs interface for cpu hotplug


 dlpar.c       |  232 ---------------------
 hotplug-cpu.c |  627 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 pseries.h     |    9 
 3 files changed, 599 insertions(+), 269 deletions(-)
