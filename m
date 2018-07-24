Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZXhm2lrzzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 19:13:28 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6O94iqC093486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 05:13:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kdx3qptb2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 05:13:24 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 24 Jul 2018 10:13:22 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 stewart@linux.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v8 0/2] hwmon/powernv: Add attributes to enable/disable sensors
Date: Tue, 24 Jul 2018 14:43:07 +0530
Message-Id: <1532423589-18730-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds new attribute to enable or disable a sensor at
runtime.

Changes from v7:
- Use of_for_each_phandle() and of_count_phandle_with_args() to parse
  through the phandle array

v7 : https://lkml.org/lkml/2018/7/20/72
v6 : https://lkml.org/lkml/2018/7/18/806
v5 : https://lkml.org/lkml/2018/7/15/15
v4 : https://lkml.org/lkml/2018/7/6/379
v3 : https://lkml.org/lkml/2018/7/5/476
v2 : https://lkml.org/lkml/2018/7/4/263
v1 : https://lkml.org/lkml/2018/3/22/214

Shilpasri G Bhat (2):
  powernv:opal-sensor-groups: Add support to enable sensor groups
  hwmon: ibmpowernv: Add attributes to enable/disable sensor groups

 Documentation/hwmon/ibmpowernv                     |  43 +++-
 arch/powerpc/include/asm/opal-api.h                |   1 +
 arch/powerpc/include/asm/opal.h                    |   2 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c |  28 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 drivers/hwmon/ibmpowernv.c                         | 238 ++++++++++++++++++---
 6 files changed, 279 insertions(+), 34 deletions(-)

-- 
1.8.3.1
