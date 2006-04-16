Return-Path: <tony.luck@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 1A1B667A73
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 04:03:25 +1000 (EST)
Received: by uproxy.gmail.com with SMTP id k3so260544ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 11:03:23 -0700 (PDT)
Message-ID: <12c511ca0604161103l3013f5f1t99c93ee38f102e95@mail.gmail.com>
Date: Sun, 16 Apr 2006 11:03:03 -0700
From: "Tony Luck" <tony.luck@intel.com>
Sender: tony.luck@gmail.com
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <200604161734.20256.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1145049535.1336.128.camel@localhost.localdomain>
	<17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	<1145194804.27407.103.camel@localhost.localdomain>
	<200604161734.20256.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	rusty@rustcorp.com.au, Steven Rostedt <rostedt@goodmis.org>,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
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

On 4/16/06, Arnd Bergmann <arnd@arndb.de> wrote:
> #define PER_CPU_BASE 0xe000000000000000UL /* arch dependant */

On ia64 the percpu area is at 0xffffffffffff0000 so that it can be
addressed without tying up another register (all percpu addresses
are small negative offsets from "r0").  When David Mosberger
chose this address he said that gcc 4 would actually make
ue of this, but I haven't checked the generated code to see
whether it really is doing so.

-Tony
