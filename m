Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10024B7DE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 17:43:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4D7eaYY003872
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:40:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4D7hwFC1650916
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:43:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4D7hvsi011992
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 17:43:58 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: ftrace syscalls,
	PowerPC: Fixes and PowerPC raw syscall tracepoint implementation
Date: Thu, 13 May 2010 17:43:10 +1000
Message-Id: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series implements raw system call tracepoints on PowerPC that can be
used with ftrace and perf. Some problems with the generic ftrace syscall
tracepoint code have also been addressed.

The patches are based upon Ben's powerpc/next tree merged with tip/tracing/core

Patch #1 removes all ftrace syscall events that fail to map the system call
name from the system call metadata with the system call's number, preventing
the events which will not work from showing up in perf list and removing them
from /sys/kernel/debug/tracing/events/syscalls.

Patches #2 and #3 allow for archs with unusual system call tables (#2) or
unusual symbol names (#3) to override the appropriate functions so that they
can still work with ftrace syscalls.

Patch #4 implements the actual raw system call tracepoints that ftrace syscalls
builds upon, allowing all of the system calls to be used with the raw_syscalls
events category and most to be used with the syscalls category.


Not all the raw_syscalls are currently mapped to ftrace syscalls - the syscalls
defined in /arch/powerpc/include/asm/syscalls.h do not use the SYSCALL_DEFINE
class of macros and as such have no meta data, likewise some of the ppc_*
syscalls have assembly wrappers. These are on their way, but I wanted to put
the work I have done so far out first.

Some of those syscalls have different return types than the __SYSCALL_DEFINE
macro uses (unsigned long, int, time_t) and some have different prefixes (ppc,
ppc64) - I didn't particularly want to change them straight over without asking
the list first, and I certainly don't want to change the return types. I see
that Jason Baron ran into similar issues, but his "add compat syscall support"
patches have yet to be merged, and do not tackle the differing return types.
