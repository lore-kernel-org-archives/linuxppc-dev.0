Return-Path: <rsa@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4228BDE13F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 06:35:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2DJXH0d008264
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 13:33:17 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2DJZ8DO101046
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 13:35:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2DJZ6Ms019301
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 13:35:08 -0600
Subject: Program Priority Registers per ISA 2.06
From: Ryan Arnold <rsa@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 13 Mar 2009 14:34:49 -0500
Message-Id: <1236972889.3137.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sean P Curry <spcurry5@linux.vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I haven't checked the kernel source in the few weeks since ISA 2.06 was
released but I suspect that the default Program Priority level hasn't
been changed in the kernel yet.

Program Priority:

Per ISA 2.06: Section 3.1 (page 671) titled "Program Priority
Registers", The 'normal' process priority level has changed from "001
medium" to "100 medium low".

There are three levels of priority available to user space and prior to
ISA 2.06 the 'normal' priority is the highest priority.  This is a
relative process priority and 'normal' doesn't immediately set clock
rate to an explicit frequency.

The ISA change simply re-bases 'normal' to the middle of the three
priorities so that user-space can increase or decrease relative program
priority without having to explicitly re-base to `100 medium low'.

This, of course, means that the kernel should implicitly re-base the
priority to the new normal of `100 medium low'.

This change can retroactively benefit applications running on POWER6
hardware and since the default program priority is relative it shouldn't
effect the performance on older hardware.

Sean Curry wrote a patch for GLIBC to increase & decrease thread
priority during lock contention loops, i.e. if you don't get the lock,
decrease priority.  Conversely if you get the lock, increase priority
over the critical section.

We have some data on cost vs. benefits and we'll supply this when the
userspace patch is submitted to GLIBC.  We can present that data here in
the meantime if requested.

Regards,

Ryan S. Arnold
IBM Linux Technology Center
Linux Toolchain development
