Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF13D1A0F69
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 06:54:30 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 16:54:26 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1C552C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:45:30 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5MKsNDL58654932
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 20:54:23 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5MKsN9t012983
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:54:23 -0400
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5MKsNkX012937
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 16:54:23 -0400
Message-ID: <558875FF.2040000@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 15:54:23 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/6] pseries: Move CPU dlpar into the kernel
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
a common entry point for PowerVM and PowerKVM CPU dlpar requests. For both
environments, the entry point is the same one introduced in a previous
patch set that moved memory hotplug into the kernel. The entry point accepts
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

 dlpar.c       |  195 -------------------
 hotplug-cpu.c |  578 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 pseries.h     |    5 
 3 files changed, 549 insertions(+), 229 deletions(-)
