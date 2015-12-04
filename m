Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C8881A000B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:27:16 +1100 (AEDT)
Date: Fri, 4 Dec 2015 16:27:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
Message-ID: <20151204152709.GA20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151201234437.GA8644@n2100.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2015-12-01 23:44:37, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> > What we can do, though, is to zap all printk locks. We already do this
> > when a printk recursion is detected. This should be safe because
> > the system is crashing and there shouldn't be any printk caller
> > that would cause the deadlock.
> 
> What about serial consoles which may call out to subsystems like the
> clk subsystem to enable a clock, which would want to take their own
> spinlocks in addition to the serial console driver?

Yes, there might be more locks used by the serial console but I do
not know how to handle them all easily. IMHO, this patch is just better
than nothing.

> I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> trying to make this work in NMI context strikes me as making the
> existing solution more unreliable on ARM systems.

bust_spinlocks() calls printk_nmi_flush() that would call printk()
that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
Yes, there might be more locks blocked but we try to break at least
the first two walls. Also zapping is allowed only once per 30 seconds,
see zap_locks(). Why do you think that it might make things more
unreliable, please?


Thanks for looking,
Petr
