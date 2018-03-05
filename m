Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH0x6RrczF0tq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:58:25 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25Noodg025033
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 18:58:23 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghbk8hnr5-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:58:22 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:58:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25NwIs947710270
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:58:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B824FA4051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6659BA4040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:16 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B16D1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:58:16 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:58:15 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/9] EEH refactoring 1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
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
 arch/powerpc/kernel/eeh_driver.c             | 143 +++++++++++----------------
 arch/powerpc/kernel/eeh_event.c              |   6 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |   9 +-
 7 files changed, 75 insertions(+), 114 deletions(-)

-- 
2.16.1.74.g9b0b1f47b
