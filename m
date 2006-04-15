Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-04.nyroc.rr.com (ms-smtp-04.nyroc.rr.com [24.24.2.58])
	by ozlabs.org (Postfix) with ESMTP id D6406679F6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 13:10:52 +1000 (EST)
Subject: [PATCH 00/08] robust per_cpu allocation for modules - V2
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:10:24 -0400
Message-Id: <1145070624.27407.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, SamRavnborg <sam@ravnborg.org>,
	bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	grundler@parisc-linux.org, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is version 2 of the percpu patch set.

Changes from version 1:

- Created a PERCPU_OFFSET variable to use in vmlinux.lds.h
  (suggested by Sam Ravnborg)

- Added support for x86_64 (Steven Rostedt)

The support for x86_64 goes back to the asm-generic handling when both
CONFIG_SMP and CONFIG_MODULES are set. This is due to the fact that the
__per_cpu_offset array is no longer referenced in per_cpu, but instead a
per per_cpu variable is used to find the offset.

Again, the rest of the patches are only sent to the LKML.

Still I need help to port this to the rest of the architectures.

Thanks,

-- Steve
