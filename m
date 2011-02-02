Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C51C7B70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 18:12:20 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p1277BVG016020
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 18:07:11 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p127CITA2064408
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 18:12:18 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p127CGLZ030406
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 18:12:17 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: PowerPC,
	ftrace: Add PPC raw syscall tracepoints & ftrace fixes (mimimal
	subset only) v3
Date: Wed,  2 Feb 2011 18:11:52 +1100
Message-Id: <1296630718-17537-1-git-send-email-imunsie@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, Alexander Graf <agraf@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Gibson <dwg@au1.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

git send-email just failed to save or send this message, so retyping...


Hi All,

This is a partial version of my 'ftrace syscalls, PowerPC: Various fixes,
Compat Syscall support and PowerPC implementation'.

I finally found some time this week to go back and work on this patchset, but
now I've been hit with another more pressing work item, so this will once again
have to go on the backburner :-(. Even though I haven't finished fixing up the
complete 40 patch series I would still like to get this smaller minimal subset
in. I've had a request for the raw syscall tracepoints on PowerPC that this
subset implements, and these patches have proven to be pretty stable.

This subset also fixes ftrace syscalls to ensure that events will only be
created for syscalls that successfully map their metadata to a syscall number,
so that non-working phantom events are not created. Patches #2 and #6 in this
series are not strictly necessary for this, they just optimise ftrace syscalls
a bit.

What's missing from this series that was in the v2 is the conversion of
all the syscalls implemented under /arch/powerpc, Jason Baron's compat
syscall support and the conversion of the remaining native and compat
syscalls to this infrastructure.


This is based on tip/master. The PowerPC specific patch will need Ben's ACK
before it goes in.

Changes from the last subset I posted:
- Rather than removing the redundant syscall_nr checks completely, I have
  turned them into WARN_ON_ONCE to catch possible future regressions, from
  Steven Rostedt's suggestion.
- From Mike Frysinger's suggestion, arch_syscall_addr is now a macro rather
  than a weak function to minimise the overhead at boot. Archs with special
  requirements (such as ppc64) can define their own macro in asm/ftrace.h.
  Steven Rostedt suggested this be made a static inline function, but I don't
  see how this would be possible (at least without #defines and #ifndefs) given
  that it has to be weak to allow archs to override it (Unless I misunderstood
  something?  Steven?).
