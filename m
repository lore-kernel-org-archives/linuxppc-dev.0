Return-Path: <jschopp@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F3A9B89DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 07:58:23 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o15KnNIF025412
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Feb 2010 15:49:23 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o15KwKxe135012
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Feb 2010 15:58:20 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o15KvnGU018985
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Feb 2010 13:57:49 -0700
Subject: [PATCHv4 0/2] sched: arch_scale_smt_powers
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264720808.9660.18.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264548479.12239.54.camel@jschopp-laptop>
	<1264720808.9660.18.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Feb 2010 14:57:46 -0600
Message-ID: <1265403466.6089.39.camel@jschopp-laptop>
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

Version 4 changes:
- Wrap arch_scale_smt_power() in #ifdef CONFIG_SCHED_SMT in Patch 2

---
Joel Schopp (2):
sched: enable ARCH_POWER
powerpc: implement arch_scale_smt_power for Power7

 arch/powerpc/include/asm/cputable.h |    3 +
 arch/powerpc/kernel/smp.c           |   58
++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sched.c         |    6 +--
 kernel/sched_features.h             |    2 -
 4 files changed, 63 insertions(+), 6 deletions(-)
