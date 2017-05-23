Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXJxR49DzzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 01:15:23 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4NF9Ggv048758
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 11:15:18 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2amq8w97xm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 11:15:18 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 23 May 2017 09:15:17 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove CPUs
 and memory
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 23 May 2017 10:15:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <790af26b-7055-7997-2080-f967aef2d26d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


powerpc/numa: Correct the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each shared CPU is set to node zero, however,
this is now updated correctly using the Virtual Processor Home Node
(VPHN) capabilities information provided by the pHyp. The VPHN handling
in Linux is disabled, if PRRN handling is present.

powerpc/hotplug-memory: Removing or adding memory via the PowerPC
hotplug interface shows anomalies in the association between memory
and nodes.  The code was updated to better take advantage of defined
nodes in order to associate memory to nodes not needed at boot time,
but relevant to dynamically added memory.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  powerpc/numa: Update CPU topology when VPHN enabled
  powerpc/hotplug-memory: Fix hot-add memory node assoc
---
