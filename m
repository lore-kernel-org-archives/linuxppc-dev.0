Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428BWW46mtzF39h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 01:18:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8AFEtlG038050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:18:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mdtaq2ps1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:18:12 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 10 Sep 2018 11:18:12 -0400
Subject: [PATCH v5 0/2] powerpc/pseries: Improve serialization of PRRN events
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: johnallen3991@gmail.com, desnesn@linux.vnet.ibm.com,
 haren@linux.vnet.ibm.com, pmac@au1.ibm.com
Date: Mon, 10 Sep 2018 09:56:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153659128238.7764.14440832607437622051.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stress testing has uncovered issues with handling continuously queued PRRN
events. Running PRRN events in this way can seriously load the system given
the sheer volume of dlpar actions being handled, eventually resulting
in a system oops (see below). This patchset ensures that PRRN
events are handled more synchronously. It also updates dlpar invocation
so that it can be done directly instead of waiting on a workqueue.

Oops: Bad kernel stack pointer, sig: 6 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Supported: Yes, External                                                     54
CPU: 7 PID: 18967 Comm: kworker/u96:0 Tainted: G                 X 4.4.126-94.22-default #1
Workqueue: pseries hotplug workque pseries_hp_work_fn
task: c000000775367790 ti: c00000001ebd4000 task.ti: c00000070d140000
NIP: 0000000000000000 LR: 000000001fb3d050 CTR: 0000000000000000
REGS: c00000001ebd7d40 TRAP: 0700   Tainted: G                 X  (4.4.126-94.22-default)
MSR: 8000000102081000 <41,VEC,ME5  CR: 28000002  XER: 20040018   4
CFAR: 000000001fb3d084 40 419   1                                3
GPR00: 000000000000000040000000000010007 000000001ffff400 000000041fffe200 
GPR04: 000000000000008050000000000000000 000000001fb15fa8 0000000500000500 
GPR08: 000000000001f40040000000000000001 0000000000000000 000005:5200040002
GPR12: 00000000000000005c000000007a05400 c0000000000e89f8 000000001ed9f668 
GPR16: 000000001fbeff944000000001fbeff94 000000001fb545e4 0000006000000060 
GPR20: ffffffffffffffff4ffffffffffffffff 0000000000000000 0000000000000000 
GPR24: 00000000000000005400000001fb3c000 0000000000000000 000000001fb1b040 
GPR28: 000000001fb240004000000001fb440d8 0000000000000008 0000000000000000 
NIP [0000000000000000] 5         (null)
LR [000000001fb3d050] 031fb3d050
Call Trace:            4
Instruction dump:      4                                       5:47 12    2
XXXXXXXX XXXXXXXX XXXXX4XX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXX5XX XXXXXXXX 60000000 60000000 60000000 60000000 

-Nathan
---

Nathan Fontenot (2):
      powerpc/pseries: Remove prrn_work workqueue
      powerpc/pseries:Remove unneeded uses of dlpar work queue


 arch/powerpc/kernel/rtasd.c               |   17 ++-----------
 arch/powerpc/platforms/pseries/dlpar.c    |   37 +++++++----------------------
 arch/powerpc/platforms/pseries/mobility.c |   18 +++++---------
 arch/powerpc/platforms/pseries/pseries.h  |    5 ++--
 arch/powerpc/platforms/pseries/ras.c      |    2 +-
 5 files changed, 22 insertions(+), 57 deletions(-)
