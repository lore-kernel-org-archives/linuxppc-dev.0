Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9640B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 14:27:39 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p133MVA9021477
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:22:31 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p133RcVp1798200
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:38 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p133RavH021251
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:38 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: PowerPC,
	ftrace: Add PPC raw syscall tracepoints & ftrace fixes (mimimal
	subset only) v4
Date: Thu,  3 Feb 2011 14:27:19 +1100
Message-Id: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
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

Hi All,

This is a partial version of my 'ftrace syscalls, PowerPC: Various fixes,
Compat Syscall support and PowerPC implementation'. This is updated from
yesterday with arch_syscall_addr changed to a static inline function from
Steven's suggestion.

This subset implements the raw syscall tracepoints on PowerPC which has been
requested recently.  It also fixes ftrace syscalls to ensure that events will
only be created for syscalls that successfully map their metadata to a syscall
number, so that non-working phantom events are not created. Patches #2 and #6
in this series are not strictly necessary for this, they just optimise ftrace
syscalls a bit.

What's missing from this series that was in the full 40 patch v2 series is the
conversion of all the syscalls implemented under /arch/powerpc, Jason Baron's
compat syscall support and the conversion of the remaining native and compat
syscalls to this infrastructure.

Cheers,
-Ian


Changelog:
Subset v4:
- Changed arch_syscall_addr to a static inline function from Steven's
  suggestion. Archs implementing their own function must now define
  ARCH_HAS_SYSCALL_MATCH_SYM_NAME in their asm/ftrace.h

Subset v3:
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

Subset v2:
- Minimal unchanged subset from 'ftrace syscalls, PowerPC: Various fixes,
  Compat Syscall support and PowerPC implementation' v2 patch series.
