Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C10EA2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:29:07 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 10 Oct 2012 17:27:33 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9A7JIus44498954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:19:19 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9A7SxJ1025167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:28:59 +1100
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RESEND PATCH v1 0/3] cpuidle: (pSeries) pseries idle driver fixes. 
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
Date: Wed, 10 Oct 2012 12:59:00 +0530
Message-ID: <20121010072859.29317.71472.stgit@deepthi.in.ibm.com>
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
