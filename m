Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4BB81A0DFD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:13:44 +1100 (AEDT)
Date: Fri, 4 Dec 2015 17:12:55 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Petr Mladek <pmladek@suse.com>
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
Message-ID: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204152709.GA20935@pathway.suse.cz>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2015 at 04:27:09PM +0100, Petr Mladek wrote:
> On Tue 2015-12-01 23:44:37, Russell King - ARM Linux wrote:
> > On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> > > What we can do, though, is to zap all printk locks. We already do this
> > > when a printk recursion is detected. This should be safe because
> > > the system is crashing and there shouldn't be any printk caller
> > > that would cause the deadlock.
> > 
> > What about serial consoles which may call out to subsystems like the
> > clk subsystem to enable a clock, which would want to take their own
> > spinlocks in addition to the serial console driver?
> 
> Yes, there might be more locks used by the serial console but I do
> not know how to handle them all easily. IMHO, this patch is just better
> than nothing.

I have a slightly different view...

> > I don't see bust_spinlocks() dealing with any of these locks, so IMHO
> > trying to make this work in NMI context strikes me as making the
> > existing solution more unreliable on ARM systems.
> 
> bust_spinlocks() calls printk_nmi_flush() that would call printk()
> that would zap "lockbuf_lock" and "console_sem" when in Oops and NMI.
> Yes, there might be more locks blocked but we try to break at least
> the first two walls. Also zapping is allowed only once per 30 seconds,
> see zap_locks(). Why do you think that it might make things more
> unreliable, please?

Take the scenario where CPU1 is in the middle of a printk(), and is
holding its lock.

CPU0 comes along and decides to trigger a NMI backtrace.  This sends
a NMI to CPU1, which takes it in the middle of the serial console
output.

With the existing solution, the NMI output will be written to the
temporary buffer, and CPU1 has finished handling the NMI it resumes
the serial console output, eventually dropping the lock.  That then
allows CPU0 to print the contents of all buffers, and we get NMI
printk output.

With this solution, as I understand it, we'll instead end up with
CPU1's printk trying to output direct to the console, and although
we've busted a couple of locks, we won't have busted the serial
console locks, so CPU1 will deadlock - and that will stop any output
what so ever.

If this is correct, then the net result is that we go from NMI with
serial console producing output to NMI with serial console being
less reliable at producing output.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
