Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FXZT1QMGzF3JN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 18:09:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J8913w119282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkhra2enw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:13 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 09:08:36 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/4] Add a tracepoint for DTL entries
Date: Wed, 19 Sep 2018 13:38:17 +0530
Message-Id: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a tracepoint for the DTL entries to enable processing the DTL 
entries via the kernel tracing infrastructure. In addition to that, the 
tracpoint also exposes where a vcpu was dispatched in a SPLPAR 
environment, relative to the Power Hypervisor's idea of that vcpu's home 
node.

This is working fine for me, so posting this out to get some early 
feedback. The one aspect I need to look into is in terms of updating the 
pcpu associativity masks on appropriate events.


- Naveen


Naveen N. Rao (4):
  powerpc/pseries: Use macros for referring to the DTL enable mask
  powerpc/pseries: Do not save the previous DTL mask value
  powerpc/pseries: Introduce helpers to change the DTL enable mask
  powerpc/pseries: Introduce dtl_entry tracepoint

 arch/powerpc/include/asm/lppaca.h      | 15 ++++
 arch/powerpc/include/asm/trace.h       | 53 +++++++++++++++
 arch/powerpc/kernel/time.c             |  9 +++
 arch/powerpc/mm/numa.c                 | 94 ++++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/dtl.c   | 15 ++--
 arch/powerpc/platforms/pseries/lpar.c  | 64 +++++++++++++++++-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 7 files changed, 233 insertions(+), 19 deletions(-)

-- 
2.18.0
