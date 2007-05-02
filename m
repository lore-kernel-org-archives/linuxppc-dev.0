Return-Path: <kevcorry@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B866DDDEDC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:09:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l42H8wS8019136
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 13:08:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l42H8wfC170440
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:08:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l42H8wUJ014147
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 11:08:58 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] powerpc: perfmon2 prereqs
Date: Wed, 2 May 2007 12:08:57 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705021208.59068.kevcorry@us.ibm.com>
Cc: Stephane Eranian <eranian@hpl.hp.com>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This is a repost of a couple patches I posted about a month ago related to 
porting perfmon2 to powerpc. I wanted to see if there were any further 
comments on these patches, and also wanted to ask if these should be 
submitted separately to the ppc kernel maintainers, or if they should be kept 
with the perfmon2 patches until those are submitted.

The first patch adds an smp_call_function_single() routine for powerpc. In 
2.6.21, there's a prototype for this routine in include/linux/smp.h, and it 
is implemented on i386, ia64, and x86-64. Since this routine is very similar 
to the existing smp_call_function() routine, the common portions have been 
pulled out into __smp_call_function(). Perfmon2 uses this unload a context 
that's loaded on a CPU other than the one that's performing the close-context 
routine.

The second patch changes the powerpc version of topology_init() from an 
__initcall to a subsys_initcall, which matches the definition of 
topology_init() on all other architectures. Perfmon2's initialization is done 
as a subsys_initcall, but it fails to set up its sysfs information if 
topology_init() has not yet run. Changing perfmon2 to an __initcall() was 
discussed, but we came to the conclusion that this would not work because the 
perfmon2 core must be initialized before any of its sub-modules. These 
sub-modules are located in arch/*/perfmon/, and thus if they are built 
statically they would run their module_init routines before the perfmon2 core 
ran its __initcall routine.

We have been running tests with these patches for the last few weeks on Cell 
and Power5 systems without any problems.

Thanks,
-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
