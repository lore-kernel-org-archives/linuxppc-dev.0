Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxSFQ3VlczDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:58:02 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBD6tItT085858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:58:00 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etrs7xyh4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:58:00 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 01:57:59 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, viresh.kumar@linaro.org,
 rjw@rjwysocki.net, huntbag@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 0/3] powernv-cpufreq: Multiple pstate related fixes.
Date: Wed, 13 Dec 2017 12:27:38 +0530
Message-Id: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

 This is a third version of the patch to fix pstate related issues in
 the powernv-cpufreq driver.

 The previous versions can be found here:
 [v2]: https://lkml.org/lkml/2017/12/7/1562
 [v1]: https://lkml.org/lkml/2017/11/29/1338

 On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
 negatively numbered while on POWER9 they are positively
 numbered. Thus, on POWER9, the maximum number of pstates could be as
 high as 256.
    
 In multiple places, the current code interprets pstates as a signed
 8-bit value which subsequently gets assigned to a signed integer
 variable. This causes a problem on POWER9 platforms which have more
 than 128 pstates.  On such systems, on a CPU that is in a lower
 pstate whose number is greater than 128, querying the current pstate
 via the pstate_to_idx() returns a "pstate X is out of bound" error
 message and the current pstate is reported as the nominal
 pstate. This is due to the manner in which the bounds are checked in
 pstate_to_idx which again depends on the sign of pstates and whether
 the pstates max to min are monotonically increasing or decreasing.
    
 Further the current code makes a couple of assumptions which is not
 guaranteed by the device-tree bindings:

      1) Pstate ids are continguous.
    
      2) Every Pstate should always lie between the max and the min
         pstates that are explicitly reported in the device tree.
    
Both these assumptions are unwarranted and can change on future
platforms.
    
In this patch-series, we fix the implementation via the following
changes:

PATCH 1: Define a helper function to correctly extract the pstates
         from the PMCR and take care of any sign extentions. This is
         an immediate fix to add the ability to handle more than 128
         pstates on POWER9 systems.
    
PATCH 2: Define a hash-map which will return the index into the
         cpufreq frequency table for a given pstate. Use this hashmap
         in the implementation of pstate_to_idx(). This does away with
         the assumptions (1) mentioned above, and will work with non
         continguous pstate ids. If no entry exists for a particular
         pstate, then such a pstate is treated as being out of
         bounds. This gets rid of assumption (2).

PATCH 3: Treat pstates as opaque 8-bit values consistent with the
         definitions in the PMSR and PMCR. We no longer need any
         sign-extentions nor do we require to interpret the sign of
         the pstates anywhere in the code.
    

Gautham R. Shenoy (3):
  powernv-cpufreq: Add helper to extract pstate from PMSR
  powernv-cpufreq: Fix pstate_to_idx() to handle non-continguous pstates
  powernv-cpufreq: Treat pstates as opaque 8-bit values

 drivers/cpufreq/powernv-cpufreq.c | 139 ++++++++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 49 deletions(-)

-- 
1.9.4
