Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98CD21A0464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:22:01 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 12:21:59 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 329DA1FF004B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:10:08 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIKYxF066046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 11:20:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RILuVx015751
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:21:56 -0600
Received: from [9.41.105.89] ([9.41.105.89])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RILtq3015659
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:21:55 -0600
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] powerpc/pseries: Move CPU DLPAR into the kernel
Message-ID: <562FC0C3.7000303@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:21:55 -0500
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

Note: The patches are based on top of two previous patches I sent out;

[PATCH] powerpc/pseries: Verify CPU doesn't exist before adding
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135550.html 

[PATCH v2] powerpc/pseries: Correct string length in pseries_of_derive_parent()
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135667.html

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

 dlpar.c       |  232 ----------------------
 hotplug-cpu.c |  596 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 pseries.h     |    9 
 3 files changed, 568 insertions(+), 269 deletions(-)
