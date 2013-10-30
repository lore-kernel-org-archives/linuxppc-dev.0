Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 686882C0379
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:15:39 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 21:15:36 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3A2B9C90044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:15:33 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9U3FYUZ38535396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 03:15:34 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9U3FWgX003361
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:15:33 -0400
Subject: [PATCH V2 0/2] sched: Cleanups,fixes in nohz_kick_needed()
To: peterz@infradead.org, mikey@neuling.org, svaidy@linux.vnet.ibm.com,
 mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 08:42:33 +0530
Message-ID: <20131030031145.23426.22930.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: vincent.guittot@linaro.org, bitbucket@online.de,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 Morten.Rasmussen@arm.com, pjt@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from V1:https://lkml.org/lkml/2013/10/21/248

1. Swapped the order of PATCH1 and PATCH2 in V1 so as to not mess with the
nr_busy_cpus parameter computation during asymmetric balancing, while fixing
it.

2. nohz_busy_cpus parameter is to be updated and queried at only one level of
the sched domain-sd_busy where it is relevant.

3. Introduce sd_asym to represent the sched domain where asymmetric load
balancing has to be done.
---

Preeti U Murthy (1):
      sched: Remove un-necessary iteration over sched domains to update nr_busy_cpus

Vaidyanathan Srinivasan (1):
      sched: Fix asymmetric scheduling for POWER7


 kernel/sched/core.c  |    6 ++++++
 kernel/sched/fair.c  |   38 ++++++++++++++++++++------------------
 kernel/sched/sched.h |    2 ++
 3 files changed, 28 insertions(+), 18 deletions(-)
