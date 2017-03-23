Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpr1f4t8rzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:24:06 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2NFNnoh042270
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 11:24:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29c57ed2gx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 11:24:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 01:23:57 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2NFNkUi47382696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:23:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2NFNJ8M015088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 02:23:19 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] cpuidle: Fixes in cpuidle driver
Date: Thu, 23 Mar 2017 20:52:45 +0530
Message-Id: <20170323152247.14733-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_HOTPLUG_CPU=n and cpu_present is less than cpu_possible,
then cpuidle-powernv not passing an explicit drv->cpu_mask allows
generic cpuidle driver to try create sysfs objects for cpus that does
not have cpu_devices created by calling register_cpu().

This caused kernel to access incorrect address and crash. The
following patch series fixes the cpuidle-powernv driver and also adds
additional checks in cpuidle_add_sysfs()

This patch set is against v4.11-rc3.

Changed from v1: Updated commit message and comments.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
