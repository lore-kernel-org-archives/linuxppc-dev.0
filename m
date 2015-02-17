Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8AAB1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 09:01:14 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:01:12 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EE33638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 16:57:23 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HM18TD16056416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 22:01:08 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HM15bk031302
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 17:01:07 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/9] powerpc/hv-24x7: Reorganize single_24x7_request()
Date: Tue, 17 Feb 2015 14:00:25 -0800
Message-Id: <1424210434-28070-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently issue a new hcall for to retrieve the value of each 24x7
counter that we want to read.  However, the H_GET_24x7_DATA hcall can
retrieve several counters in a single call, which would be useful in
getting a more consistent snapshot of the system.

Reorganize the code that prepares a 24x7 hcall request, submits it and
processes the result to allow reading seveal counters at once. We still
submit a fresh hcall for each event for now. A follow-on patch-set will
build on this to submit multiple perf_events in a single hcall.

Thanks to Peter Zijlstra for his input.

Sukadev Bhattiprolu (9):
  powerpc/perf: hv-24x7: Modify definition of request and result buffers
  powerpc: perf/hv24x7: Remove unnecessary parameter
  powerpc: perf/hv-24x7: Drop event_24x7_request()
  powerpc: perf/hv24x7: Move debug prints to separate function
  perf: powerpc/hv-24x7: Rename hv_24x7_event_update
  powerpc: perf/hv-24x7: Define add_event_to_24x7_request()
  powerpc: perf/hv-24x7: Define update_event_count()
  powerpc: perf/hv-24x7: Break up single_24x7_request
  powerpc: perf/hv-24x7: Add missing put_cpu_var()

 arch/powerpc/perf/hv-24x7.c | 198 ++++++++++++++++++++++++++++----------------
 arch/powerpc/perf/hv-24x7.h |   8 +-
 2 files changed, 130 insertions(+), 76 deletions(-)

-- 
1.8.3.1
