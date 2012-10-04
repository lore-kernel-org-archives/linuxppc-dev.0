Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29C782C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 14:42:08 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 4 Oct 2012 14:39:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q944WJlW65142788
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 14:32:20 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q944g1EH031273
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 14:42:01 +1000
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH v1 0/3] cpuidle: (pSeries) pseries idle driver fixes. 
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Date: Thu, 04 Oct 2012 10:12:01 +0530
Message-ID: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series consists of a bunch of fixes for 
cpuidle back-end driver for ppc64 (pSeries) platform.

The series applies on 3.6-rc7 and has been tested on ppc64 pSeries
POWER7 system with snooze and nap states.

With these fixes, avg idle residency for nap on 50 percent idle system
increased from 96 to 99.4 percent and idle residency for snooze for
the same decreased from 4 to 0.6 percent, determined running spec power
benchmark runs.

 Deepthi Dharwar (3):
      cpuidle: (POWER) Fix snooze state problem persistant in the current cpuidle design on pseries.
      cpuidle: (POWER) Fix smt_snooze_delay functionality.
      cpuidle: (POWER) Fix target residency initialisation in pseries cpuidle


  arch/powerpc/include/asm/processor.h            |    4 +
 arch/powerpc/kernel/sysfs.c                     |    2 -
 arch/powerpc/platforms/pseries/processor_idle.c |   62 +++++++++++------------
 3 files changed, 32 insertions(+), 36 deletions(-)


-- Deepthi
