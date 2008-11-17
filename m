Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18720.60351.611649.125429@drongo.ozlabs.ibm.com>
Date: Mon, 17 Nov 2008 14:57:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] ftrace, ppc: convert to new dynamic ftrace arch API
In-Reply-To: <20081116212515.331278109@goodmis.org>
References: <20081116212428.938752312@goodmis.org>
	<20081116212515.331278109@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt writes:

> +static int test_24bit_addr(unsigned long ip, unsigned long addr)
> +{
> +	unsigned long diff;
> +
> +	/* can we get to addr from ip in 24 bits? */
> +	diff = ip > addr ? ip - addr : addr - ip;
> +
> +	return !(diff & ((unsigned long)-1 << 24));

Since a branch instruction can reach +/- 32MB, the 24 needs to be 25.
It's 25 not 26 since you have effectively accounted for one bit by
taking the absolute value of the offset.  Also, this will say that an
offset of -0x2000000 is out of range whereas it is just in range.
That probably doesn't matter unless you're relying on this to give
exactly the same answer in all cases as tests done elsewhere (e.g. in
module_64.c).

Note that the address difference being too large isn't the only reason
for a procedure call to go via a trampoline on ppc64.  A trampoline is
also needed when the called function uses a different TOC from the
caller.  The most obvious example of this is when the caller is in a
module and the callee is in the main kernel or another module.

Currently all functions in the main kernel use the same TOC, but the
linker is capable of dividing up a large executable into groups of
functions and assigning a different TOC to each group, in order to
avoid any of the TOCs getting too large (a TOC is limited to 64kB).
If the linker does that, it automatically inserts trampolines to
handle the TOC change.

Paul.
