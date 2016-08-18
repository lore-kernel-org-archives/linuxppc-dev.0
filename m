Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFghB4CfzzDr5P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 08:27:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7IMNlwe112426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:20 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wg7fmnvg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:19 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 16:27:19 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC/PATCH 0/2] powernv:cpuidle: Enable winkle idle state
Date: Fri, 19 Aug 2016 03:56:53 +0530
Message-Id: <cover.1471557381.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

The patches in these series enable support for Winkle idle state in
CPU-Idle.

The first patch is a platform-independent CPU-Idle patch that allows
CPU-Idle states to be  disabled at start (Currently they are all
enabled by default).

The second patch adds the winkle enablement for powernv-cpuidle. By
default, the winkle idle-state is disabled. It can be enabled by
writing zero to the per-cpu cpuidle sysfs control file named
"disable".

This series has been lightly tested on a 2-socket POWER8 system and
the machine was pretty stable while running kernbench and ebizzy. I
didn't see any regressions with those.

I haven't yet evaluated the impact that these patches might have
on latency sensitive workloads. I hope to do that in a day or two.

On the power-savings front, I could observe 6-8% additional
power-savings when winkle state was enabled on an idle system with
SMT=on. With SMT=off, additional idle power-savings observed with
winkle enabled were greater than 15%.  The numbers indicate that it
might be worth the while to pursue this!


Gautham R. Shenoy (2):
  cpuidle: Allow idle-states to be disabled at start
  powernv:cpuidle: Enable winkle idle state in CPU-Idle.

 drivers/cpuidle/cpuidle-powernv.c | 44 ++++++++++++++++++++++++++++++++-------
 drivers/cpuidle/cpuidle.c         |  7 +++++++
 include/linux/cpuidle.h           |  7 ++++++-
 3 files changed, 49 insertions(+), 9 deletions(-)

-- 
1.9.4
