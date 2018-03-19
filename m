Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404L6P5YvQzDqph
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 13:46:04 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2J2hr7o098240
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:46:02 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gsjw6sb26-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:46:02 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 19 Mar 2018 02:46:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w2J2jvWD65863796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:45:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1C66AE045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:36:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E17AAE053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:36:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:36:19 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (unknown [9.192.172.254])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 62B4AA003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 13:45:55 +1100 (AEDT)
Date: Mon, 19 Mar 2018 13:45:53 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/9] EEH refactoring 1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

Here is a set of some small, mostly idempotent, changes to improve
maintainability in some of the EEH code, primarily in eeh_driver.c.

I've kept them all small to aid review but perhaps they should be squashed down
before being applied.

Cheers,
Sam.

Patch set changelog follows:

====== v1 -> v2: ======

Patch 1/9: powerpc/eeh: Remove eeh_handle_event()

Patch 2/9: powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()

Patch 3/9: powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()

Patch 4/9: powerpc/eeh: Remove misleading test in eeh_handle_normal_event()

Patch 5/9: powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()

Patch 6/9: powerpc/eeh: Clarify arguments to eeh_reset_device()
* Re-ordered parameters to eeh_reset_device() to keep pe first.
* Changed eeh_aware_driver to driver_eeh_aware.

Patch 7/9: powerpc/eeh: Remove always-true tests in eeh_reset_device()

Patch 8/9: powerpc/eeh: Factor out common code eeh_reset_device()
* In one case, added braces to "if" to match "else".

Patch 9/9: powerpc/eeh: Add eeh_state_active() helper

====== v1: ======

Patch 1/9: powerpc/eeh: Remove eeh_handle_event()
Patch 2/9: powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
Patch 3/9: powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
Patch 4/9: powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
Patch 5/9: powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
Patch 6/9: powerpc/eeh: Clarify arguments to eeh_reset_device()
Patch 7/9: powerpc/eeh: Remove always-true tests in eeh_reset_device()
Patch 8/9: powerpc/eeh: Factor out common code eeh_reset_device()
Patch 9/9: powerpc/eeh: Add eeh_state_active() helper

Sam Bobroff (9):
  powerpc/eeh: Remove eeh_handle_event()
  powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
  powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
  powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
  powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
  powerpc/eeh: Clarify arguments to eeh_reset_device()
  powerpc/eeh: Remove always-true tests in eeh_reset_device()
  powerpc/eeh: Factor out common code eeh_reset_device()
  powerpc/eeh: Add eeh_state_active() helper

 arch/powerpc/include/asm/eeh.h               |   6 ++
 arch/powerpc/include/asm/eeh_event.h         |   3 +-
 arch/powerpc/kernel/eeh.c                    |  19 ++--
 arch/powerpc/kernel/eeh_cache.c              |   3 +-
 arch/powerpc/kernel/eeh_driver.c             | 137 +++++++++++----------------
 arch/powerpc/kernel/eeh_event.c              |   6 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |   9 +-
 7 files changed, 72 insertions(+), 111 deletions(-)

-- 
2.16.1.74.g9b0b1f47b
