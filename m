Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwvdc07vBzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 04:28:18 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8IIQREm043187
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2gdt3r6r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:16 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 18 Sep 2017 14:28:15 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/nodes/hotplug: Fix problem with memoryless nodes
Date: Mon, 18 Sep 2017 13:28:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <49626c85-d466-3f99-bde8-f459e278f6ee@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/nodes: Ensure enough nodes avail for operations.
On systems like PowerPC which allow 'hot-add' of CPU or memory
resources, it may occur that the new resources are to be inserted
into nodes that were not used for these resources at bootup.  In
the kernel, any node that is used must be defined and initialized
at boot.  This patch extracts the value of the lowest domain level
(number of allocable resources) from the "rtas" device tree property
"ibm,current-associativity-domains" or the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system.

powerpc/hotplug: Fix CPU-only node bringup bug
On systems like PowerPC which allow 'hot-add' of CPU, it may occur
that the new resources are to be inserted into nodes that were not
used for memory resources at bootup.  Many different configurations
of PowerPC resources may need to be supported depending upon the
environment.  This patch fixes some problems encountered at runtime
with configurations that support memory-less nodes, but which allow
CPUs to be added at and after boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  powerpc/vphn: Ensure enough nodes avail for operations
  powerpc/hotplug: Fix CPU-only node bringup bug
