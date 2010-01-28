Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAC9CB7D07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 10:20:31 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SNH8Dl029883
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:17:08 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0SNKM3w258664
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:20:22 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0SNKCjE029038
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 16:20:13 -0700
Subject: [PATCHv3 0/2] sched: arch_scale_smt_powers
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264548479.12239.54.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264548479.12239.54.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 17:20:08 -0600
Message-ID: <1264720808.9660.18.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: ego@in.ibm.com, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new Power7 processor has 4 way SMT.  This 4 way SMT benefits from
dynamic power updates that arch_scale_smt_power was designed to provide.
The first patch fixes a generic scheduler bug necessary for arch_scale_smt
to properly function.  The second patch implements arch_scale_smt_power 
for powerpc, and in particular for Power7 processors.

Version 2 changes:
- Drop Patch 1 from the original series since it's in the -tip tree now
- Move enabling the cpu feature into it's own patch (now patch 1)
- Add stubbing out broken x86 implementation to patch 1
- clean up coding style in patch 2

Version 3 changes:
- Added a comment to Patch 2

---
Joel Schopp (2):
powerpc: implement arch_scale_smt_power for Power7
sched: enable ARCH_POWER

 arch/powerpc/include/asm/cputable.h |    3 +
 arch/powerpc/kernel/smp.c           |   56
++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sched.c         |    6 +--
 kernel/sched_features.h             |    2 -
 4 files changed, 61 insertions(+), 6 deletions(-)
