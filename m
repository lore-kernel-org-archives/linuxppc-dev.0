Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7Qf6bdpzDr23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:24:26 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHMXYO121326
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:24:23 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9e1wkg4s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:24:23 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:24:22 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V7 0/2] powerpc/nodes: Fix issues with memoryless nodes
Date: Thu, 16 Nov 2017 11:24:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <c88f7263-4f99-c13d-c4d2-9fa8f3d59b8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/nodes: Ensure enough nodes avail for operations

powerpc/initnodes: Ensure nodes initialized for hotplug

hotplug/cpu: Fix crash with memoryless nodes

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (3):
  powerpc/nodes: Ensure enough nodes avail for operations
  powerpc/initnodes: Ensure nodes initialized for hotplug
  hotplug/cpu: Fix crash with memoryless nodes
---
Changes in V7:
  -- Remove some node initialization/allocation from boot setup
     to later in runtime to try to limit memory needs early on
  -- Add some needed node initialization to runtime code that maps
     CPUs based on VPHN associativity
  -- Add error checks and alternate recovery for compile flag
     CONFIG_MEMORY_HOTPLUG
  -- Add alternate node selection recovery for !CONFIG_MEMORY_HOTPLUG
  -- Add initialization for systems that start using nodes before new
     CPU brought online.
  -- Make function find_cpu_nid() externally visible/usable so that
     it may be used from hotplug-cpu.c
