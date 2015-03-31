Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C11AC1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:54:51 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Mar 2015 19:54:49 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A8BEE1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:45:58 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2V1sqrO48038040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 18:54:52 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2V1skq0002933
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:54:47 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH v2 00/10] powerpc/hv-24x7: Reorganize single_24x7_request()
Date: Mon, 30 Mar 2015 18:53:37 -0700
Message-Id: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
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

Changelog[v2]
	- Split independent changes in patch 2 into patch 3.
	- Minor changes to pr_err() (Patch 4).
	- Move whitespace changes to separate patch (Patch  8).
	- Minor function renames (Patch 10).

Sukadev Bhattiprolu (10):
  powerpc/hv-24x7: Modify definition of request and result buffers
  powerpc/hv24x7: Remove unnecessary parameter
  perf/hv24x7: Use pr_devel() to log message
  powerpc/hv-24x7: Drop event_24x7_request()
  powerpc/hv24x7: Move debug prints to separate function
  powerpc/hv-24x7: Rename hv_24x7_event_update
  powerpc/hv-24x7: Define add_event_to_24x7_request()
  perf/hv24x7: Whitespace cleanup
  powerpc/hv-24x7: Define update_event_count()
  powerpc/hv-24x7: Break up single_24x7_request

 arch/powerpc/perf/hv-24x7.c | 212 +++++++++++++++++++++++++++-----------------
 arch/powerpc/perf/hv-24x7.h |   8 +-
 2 files changed, 137 insertions(+), 83 deletions(-)

-- 
1.8.3.1
