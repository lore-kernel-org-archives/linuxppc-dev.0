Return-Path: <jschopp@austin.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7592B7CC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 07:01:10 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0KJxdIg011511
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 12:59:39 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0KK0jlJ159592
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 13:00:47 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0KK0e3W023944
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 13:00:42 -0700
Subject: [PATCH 0/2] sched: arch_scale_smt_powers
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 14:00:38 -0600
Message-ID: <1264017638.5717.121.camel@jschopp-laptop>
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

---
Gautham R Shenoy (1):
sched: Fix the place where group powers are updated.

Joel Schopp (1):
powerpc: implement arch_scale_smt_power for Power7

 arch/powerpc/kernel/smp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c            |    7 +++----
 kernel/sched_features.h   |    2 +-
 3 files changed, 45 insertions(+), 5 deletions(-)
