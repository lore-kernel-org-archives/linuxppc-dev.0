Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcwHW2HvNzDvhJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 08:01:27 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCKwmM9036694
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:01:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27a1csrddq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 16:01:24 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 14:01:22 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0A97C3E40060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 14:01:20 -0700 (MST)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/pseries: Perform PRRN topology updates in kernel
Date: Mon, 12 Dec 2016 15:01:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <7125fe8e-60f9-2152-d159-0f4c07183547@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Formerly, when we received a PRRN rtas event, device tree updating was
performed in the kernel and the actual topology updating was performed in
userspace. This was necessary as in order to update the topology for memory,
we must perform a hot remove and a subsequent hot add and until recently,
memory hotplug was not included in the kernel. Since memory hotplug is now
available, this patchset moves the PRRN topology updating into the kernel.

John Allen (2):
      powerpc/pseries: Introduce memory hotplug READD operation
      powerpc/pseries: Update affinity for memory and cpus specified in a PRRN event

 arch/powerpc/include/asm/rtas.h                 |    1
 arch/powerpc/kernel/rtasd.c                     |    7 +++
 arch/powerpc/platforms/pseries/hotplug-memory.c |    5 ++
 arch/powerpc/platforms/pseries/mobility.c       |   48 +++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)
