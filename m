Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpqBN5YW7zDrZZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 06:47:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v88KjTlT070798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 16:47:05 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cuvgws8yr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 16:47:05 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 14:47:04 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V14 0/4] powerpc/vphn: Update CPU topology when VPHN enabled
Date: Fri, 8 Sep 2017 15:47:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <74fb879c-19bf-3abf-4491-1f0db162e7d8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/numa: On Power systems with shared configurations of CPUs
and memory, there are some issues with the association of additional
CPUs and memory to nodes when hot-adding resources.  This patch
addresses some of those problems.

First, it corrects the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each CPU was being set to node zero.  Now
when numa_update_cpu_topology() is called appropriately, the Virtual
Processor Home Node (VPHN) capabilities information provided by the
pHyp allows the appropriate node in the shared configuration to be
selected for the CPU.

Next, it updates the initialization checks to independently recognize
PRRN or VPHN support.

Next, during hotplug CPU operations, it resets the timer on topology
update work function to a small value to better ensure that the CPU
topology is detected and configured sooner.

Also, fix an end-of-updates processing problem observed occasionally
in numa_update_cpu_topology().

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (4):
  powerpc/vphn: Update CPU topology when VPHN enabled
  powerpc/vphn: Improve recognition of PRRN/VPHN
  powerpc/hotplug: Improve responsiveness of hotplug change
  powerpc/vphn: Fix numa update end-loop bug
  ---
Changes in V14:
  -- Cleanup and compress some code after split.
