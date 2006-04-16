Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
Date: Sun, 16 Apr 2006 17:02:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	<4441B02D.4000405@yahoo.com.au>
	<Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, benedict.gaster@superh.com,
	bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	rusty@rustcorp.com.au, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
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

Steven Rostedt writes:

> So now I'm asking for advice on some ideas that can be a work around to
> keep the robustness and speed.

Ideally, what I'd like to do on powerpc is to dedicate one register to
storing a per-cpu base address or offset, and be able to resolve the
offset at link time, so that per-cpu variable accesses just become a
register + offset memory access.  (For modules, "link time" would be
module load time.)

We *might* be able to use some of the infrastructure that was put into
gcc and binutils to support TLS (thread local storage) to achieve
this.  (See http://people.redhat.com/drepper/tls.pdf for some of the
details of that.)

Also, I've added Rusty Russell to the cc list, since he designed the
per-cpu variable stuff in the first place, and would be able to
explain the trade-offs that led to the PERCPU_ENOUGH_ROOM thing.  (I
think you're discovering them as you go, though. :)

Paul.
