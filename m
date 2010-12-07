Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00829B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 16:00:34 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id oB750YEb020931
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Dec 2010 16:00:34 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB750Y5x2478290
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Dec 2010 16:00:34 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB750WIF017531
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Dec 2010 16:00:34 +1100
Content-Type: text/plain; charset=UTF-8
Subject: PowerPC,
	ftrace: Add PPC raw syscall tracepoints & ftrace fixes (subset from
	v2)
From: Ian Munsie <imunsie@au1.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-reply-to: <1291696151-4336-1-git-send-email-imunsie@au1.ibm.com>
References: <1291696151-4336-1-git-send-email-imunsie@au1.ibm.com>
Date: Tue, 07 Dec 2010 16:00:31 +1100
Message-Id: <1291698004-sup-2452@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Kosina <jkosina@suse.cz>, Jason Baron <jbaron@redhat.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>,
	David Gibson <dwg@au1.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Namhyung Kim <namhyung@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, It seems that I missed LKML in the to address of the cover email
for this set. Guess I shouldn't send a patch set just as the fire alarm
goes off.  Resending:


Hi all,

This is a partial version of my 'ftrace syscalls, PowerPC: Various fixes,
Compat Syscall support and PowerPC implementation'.

I've been tied up with other work and haven't had time to complete the
work on the v3 of the full set, but the patches I'm including here are
pretty stable and there has been a request for the raw syscall
tracepoints in PowerPC.

The actual patches included here have not been changed from the v2 other than
rebasing them on tip/master. They add support for *raw* syscall tracepoints on
PowerPC, while fixing ftrace syscalls to ensure that events will only be created
for syscalls that successfully map their metadata to a syscall number,
so that non-working phantom events are not created.

Patch #2 and #6 in this series are not strictly necessary for this, they just
optimise ftrace syscalls a bit.


What's missing from this series that was in the v2 is the conversion of
all the syscalls implemented under /arch/powerpc, Jason Baron's compat
syscall support and the conversion of the remaining native and compat
syscalls to this infrastructure.

Cheers,
-Ian

GIT: [PATCH 1/6] ftrace syscalls: don't add events for unmapped syscalls
GIT: [PATCH 2/6] trace syscalls: Remove redundant syscall_nr checks
GIT: [PATCH 3/6] ftrace syscalls: Make arch_syscall_addr weak
GIT: [PATCH 4/6] ftrace syscalls: Allow arch specific syscall symbol matching
GIT: [PATCH 5/6] trace, powerpc: Implement raw syscall tracepoints on PowerPC
GIT: [PATCH 6/6] trace syscalls: Early terminate search for sys_ni_syscall
