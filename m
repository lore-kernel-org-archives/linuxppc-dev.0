Return-Path: <tom.huynh@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CA431A0C28
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Feb 2015 10:00:32 +1100 (AEDT)
From: Tom Huynh <tom.huynh@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <a.p.zijlstra@chello.nl>, <mingo@redhat.com>, <acme@kernel.org>
Subject: [PATCH 0/3] Add e6500 perf events to sysfs and update perf doc
Date: Fri, 6 Feb 2015 16:43:53 -0600
Message-ID: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tom Huynh <tom.huynh@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set adds generic events, specific events, and format attribute
for the e6500 pmu to sysfs. This makes perf more convenient to use on the
e6500 by allowing the users to see all supported events and specify
events using meaningful names instead of raw event codes.

This patchset includes similar features in the following commits:
 - 1c53a270724d
   ("perf/POWER7: Make generic event translations available in sysfs").
 - 886c3b2d677f
   ("perf/POWER7: Make some POWER7 events available in sysfs")
 - cfe0d8ba14a1
   ("perf tools: Make Power7 events available for perf")
 - 3bf7b07ece6e
   ("perf/POWER7: Create a sysfs format entry for Power7 events").

This patchset also update tool/perf/design.txt to account for the changes
in commit a21ca2cac582 ("perf_counter: Separate out attr->type from
attr->config").

Attached patches:
  1/3 perf/e6500: Make event translations available in sysfs
  2/3 perf/e6500: Create a sysfs format entry for e6500 events
  3/3 perf/doc: Update perf_event_attr struct

 arch/powerpc/include/asm/perf_event_fsl_emb.h |  20 +-
 arch/powerpc/perf/core-fsl-emb.c              |  12 ++
 arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++
 arch/powerpc/perf/e6500-pmu.c                 |  63 +++++-
 tools/perf/design.txt                         | 159 ++++++++++----
 5 files changed, 491 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/perf/e6500-events-list.h

-- 
1.9.1
