Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVFYS4S8NzDvxq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 11:35:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB20YPuu134166
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 19:35:22 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 272sxqwxtw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 19:35:22 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 2 Dec 2016 10:35:20 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2FA383578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 11:35:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB20ZGpa51576900
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 11:35:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB20ZG7L022932
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 11:35:16 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 0/4] Support power9 PMU Raw event format
Date: Fri,  2 Dec 2016 06:04:58 +0530
Message-Id: <1480638902-23416-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patchset to factor out the PowerISA v2.07 PMU raw event
format encoding and add support to the power9 PMU
raw event format encoding.

Changelog v3:
1)Rename the raw event format to power9 from PowerISA v3.0
2)Modified the new helper functions suggested by mpe

Changelog v2:
1)Initialized return variable to avoid compile errors in pasemi_defconfig

Changelog v1:
1) Initialized "mmcra" variable to avoid compile time errors
2) Made changes to commit message


Madhavan Srinivasan (4):
  powerpc/perf: factor out the event format field
  powerpc/perf: update attribute_group data structure
  powerpc/perf: power9 raw event format encoding
  powerpc/perf: macros for power9 format encoding

 arch/powerpc/perf/isa207-common.c |  91 +++++++++++++++++++++++++++---
 arch/powerpc/perf/isa207-common.h |  30 +++++++++-
 arch/powerpc/perf/power8-pmu.c    |  39 ++-----------
 arch/powerpc/perf/power9-pmu.c    | 114 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 227 insertions(+), 47 deletions(-)

-- 
2.7.4
