Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 918BB1A06CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 16:03:51 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 02:03:48 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C445CC9004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:52:30 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9163kdh52428898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 06:03:46 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9163iA4006703
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 02:03:46 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 0/5] powerpc/perf: Miscellaneous fixes
Date: Tue, 30 Sep 2014 23:03:16 -0700
Message-Id: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Miscellaenous fixes for perf and 24x7 counters in powerpc.

Patches 1,3,4 were submitted earlier as a part of the parametrized
events for 24x7 counters. But they are not directly related to the
parametrized events.

Patch 2 simplifies and fixes a bug in catalog_read() which causes the
catalog file to not read first page.

Changelog[v3]
	[Michael Ellerman] Cleanup patches 1 and 2 and fix a bug
	Add patch 5/5 to update contact info for 24x7 and GPCI counters

Changelog[v2]
	Rebase to perf/core tree.

Cody P Schafer (3):
  powerpc/perf/hv-24x7: use kmem_cache instead of aligned stack
    allocations
  perf Documentation: sysfs events/ interfaces
  perf Documentation: remove duplicated docs for powerpc cpu specific
    events

Sukadev Bhattiprolu (2):
  Simplify catalog_read()
  powerpc: Update contact info in Documentation files

 .../testing/sysfs-bus-event_source-devices-events  | 611 ++-------------------
 .../testing/sysfs-bus-event_source-devices-hv_24x7 |   6 +-
 .../testing/sysfs-bus-event_source-devices-hv_gpci |  12 +-
 arch/powerpc/perf/hv-24x7.c                        | 156 ++----
 4 files changed, 109 insertions(+), 676 deletions(-)

-- 
1.8.3.1
