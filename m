Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E83AD2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 19:02:28 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 14:24:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DA0651258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 14:31:43 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6N92GHT49020974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 14:32:16 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6N92HqP009265
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 09:02:18 GMT
Subject: [PATCH 0/3] cpuidle: (powernv) cpuidle driver. 
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 23 Jul 2013 14:31:22 +0530
Message-ID: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following patch series ports the cpuidle framework for powernv
platform and also implements a cpuidle back-end powernv 
idle driver calling on to power7_nap and snooze idle states.

Moving the idle states over to cpuidle framework can take advantage 
of advanced heuristics, tunables and features provided by cpuidle 
framework. Additional idle states can be exploited using the cpuidle 
framework. The statistics and tracing infrastructure provided by 
the cpuidle framework also helps in enabling power management 
related tools and help tune the system and applications.

This series aims to maintain compatibility and functionality to
existing powernv idle cpu management code.  There are no new functions
or idle states added as part of this series. This can be extended by 
adding more states to this existing framework.

With this patch series the powernv cpuidle functionalities
are on-par with pSeries idle management.

For POWERNV platform to hook into CPUIDLE framework, one
needs to enable CONFIG_POWERNV_IDLE and disable
CONFIG_PSERIES_IDLE 

 Deepthi Dharwar (3):
      cpuidle/powernv: cpuidle backend driver for powernv
      cpuidle/powernv: Enable idle powernv cpu to call into the cpuidle framework.
      cpuidle/powernv: Support smt-snooze-delay parameter in powernv idle.


 arch/powerpc/include/asm/processor.h            |    2 
 arch/powerpc/platforms/powernv/Kconfig          |    9 +
 arch/powerpc/platforms/powernv/Makefile         |    1 
 arch/powerpc/platforms/powernv/powernv.h        |    3 
 arch/powerpc/platforms/powernv/processor_idle.c |  275 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c          |   12 +
 6 files changed, 300 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/processor_idle.c


-- Deepthi
