Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB4AA2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:58 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 21 Oct 2013 21:44:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4C8012BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:38 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9LBiQca12189840
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9LBibuB002878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:38 +1100
Subject: [PATCH 0/3] sched: Fixes for task placement in SMT threads
To: Peter Zijlstra <peterz@infradead.org>,
 Mike Galbraith <bitbucket@online.de>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 21 Oct 2013 17:14:32 +0530
Message-ID: <20131021114002.13291.31478.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following series fixes scheduler loadbalancing issues where we are
missing opportunity to place tasks in SMT threads optimally especially
on a POWER7 system.

PATCH 1/3, Fixes the scenario where load balancing fails to move tasks
away from the cpus in a domain which has SHARE_PKG_RESOURCES set even
under the presence of idle cpus in other domains.

PATCH 2/3, ensures lower order SMT threads are used for the
SD_ASYM_PACKING load balancing case.

PATCH 3/3, tries to fix the problem that is explained in its
changelog. The following experiment expose the scenario:

A task placement test was conducted on a POWER7 as well as multi-core
x86 system. At the beginning, tasks are pinned to all the threads
within a core and later only the tasks pinned to the secondary threads
in a core are unpinned. This leaves the primary thread with tasks that
are unmovable, while the rest are free to be moved.

Under the above setup, load balancing today does not move the unpinned
tasks away from the secondary threads of the core in the above
experiment although there are other idle cpus. The PATCH 3/3 fixes
this situation and improves task placement even if some of the tasks
in a core are pinned.

This series applies on v3.12-rc6 and tested on x86 and powerpc.

--Vaidy

---

Preeti U Murthy (2):
      sched: Fix nohz_kick_needed to consider the nr_busy of the parent domain's group
      sched: Aggressive balance in domains whose groups share package resources

Vaidyanathan Srinivasan (1):
      sched: Fix asymmetric scheduling for POWER7


 kernel/sched/fair.c |   41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)
