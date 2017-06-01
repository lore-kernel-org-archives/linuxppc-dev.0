Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf0Dh2xtvzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 07:03:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51KwpXu048241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 17:03:10 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ats1a3h3r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 17:03:10 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 18:03:08 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51L34Mh15728696
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:05 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51L35RD002805
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:05 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/8] Support for 24x7 hcall interface version 2
Date: Thu,  1 Jun 2017 18:02:19 -0300
Message-Id: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

The hypervisor interface to access 24x7 performance counters (which collect
performance information from system power on to system power off) has been
extended in POWER9 adding new fields to the request and result element
structures.

Also, results for some domains now return more than one result element and
those need to be added to get a total count.

The first two patches fix bugs in the existing code. The following 4
patches are code improvements and the last two finally implement support
for the changes in POWER9 described above.

POWER8 systems only support version 1 of the interface, while POWER9
systems only support version 2. I tested these patches on POWER8 to verify
that there are no regressions, and also on POWER9 DD1.

Thiago Jung Bauermann (8):
  powerpc/perf/hv-24x7: Fix passing of catalog version number
  powerpc/perf/hv-24x7: Fix off-by-one error in request_buffer check
  powerpc/perf/hv-24x7: Properly iterate through results
  powerpc-perf/hx-24x7: Don't log failed hcall twice
  powerpc/perf/hv-24x7: Fix return value of hcalls
  powerpc/perf/hv-24x7: Minor improvements
  powerpc/perf/hv-24x7: Support v2 of the hypervisor API
  powerpc/perf/hv-24x7: Aggregate result elements on POWER9 SMT8

 arch/powerpc/perf/hv-24x7.c            | 255 +++++++++++++++++++++++++--------
 arch/powerpc/perf/hv-24x7.h            |  70 +++++++--
 arch/powerpc/platforms/pseries/Kconfig |   2 +-
 3 files changed, 255 insertions(+), 72 deletions(-)

-- 
2.7.4
