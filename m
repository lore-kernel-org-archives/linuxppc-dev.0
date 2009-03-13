Return-Path: <rsa@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2483DE0CE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 07:23:55 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2DKLm4T023928
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 14:21:48 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2DKNqnJ160618
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 14:23:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2DKNqNW010876
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 14:23:52 -0600
Subject: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs in
	the MSR
From: Ryan Arnold <rsa@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 13 Mar 2009 15:23:51 -0500
Message-Id: <1236975831.3137.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>,
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

Those of us working on the POWER toolchain can envision a certain class
of customers who may benefit from intelligently disabling certain
register class enable bits on context switches, i.e. not disabling by
default.

Currently, per process, if the MSR enable bits for FPs, VRs or VSRs are
set to disabled, an interrupt will be generated as soon as an FP, VMX,
or VSX instruction is encountered.  At this point the kernel enables the
relevant bits in the MSR and returns.

Currently, the kernel will disable all of the bits on a context switch.

If a customer _knows_ a process will be using a register class
extensively, e.g. VRs, they're paying the interrupt->enable-VMX price
with every context switch.  It'd be nice if we could intelligently leave
the bits enabled.

Solutions:
- A boot flag which always enables VSRs, VRs, FPRs, etc.  These are
cumulative, i.e. VSRs implies VRs and FPRS; VRs implies FPRs.

- A heuristic which permanently enables said register classes for a
process if they've been enabled during the previous X interrupts.

- The same heuristic could disable the register class bits after a
certain criteria is met.

We have some ideas on how to benchmark this to verify the expense of the
interrupt->enable.  As it presently works this stands in the way of
using VMX or VSX for optimized string routines in GLIBC.

Regards,

Ryan S. Arnold
IBM Linux Technology Center
Linux Toolchain Development
