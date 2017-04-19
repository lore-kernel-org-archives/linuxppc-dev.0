Return-Path: <SRS0=KtvL=33=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7T9p4cmRzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:13:50 +1000 (AEST)
Date: Wed, 19 Apr 2017 13:13:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Daniel
 Thompson <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>, Ingo
 Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sergey
 Senozhatsky <sergey.senozhatsky.work@gmail.com>, Chris Metcalf
 <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jan Kara <jack@suse.cz>, Ralf Baechle
 <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, David Miller
 <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20170419131341.76bc7634@gandalf.local.home>
In-Reply-To: <1461239325-22779-2-git-send-email-pmladek@suse.com>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Apr 2016 13:48:42 +0200
Petr Mladek <pmladek@suse.com> wrote:

> printk() takes some locks and could not be used a safe way in NMI context.

I just found a problem with this solution. It kills ftrace dumps from
NMI context :-(

[ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
[ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
[ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
[ 1295.168497]
[ 1295.168498] Lost 4890096 message(s)!
[ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
[ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
[ 1296.811553] Call Trace:
[ 1296.811553]  <NMI>

I was hoping to see a cause of a hard lockup by enabling
ftrace_dump_on_oops. But as NMIs now have a very small buffer that
gets flushed, we need to find a new way to print out the full ftrace
buffer over serial.

Thoughts?


-- Steve


> 
> The chance of a deadlock is real especially when printing stacks from all
> CPUs.  This particular problem has been addressed on x86 by the commit
> a9edc8809328 ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> 
> The patchset brings two big advantages.  First, it makes the NMI
> backtraces safe on all architectures for free.  Second, it makes all NMI
> messages almost safe on all architectures (the temporary buffer is
> limited.  We still should keep the number of messages in NMI context at
> minimum).
> 
> Note that there already are several messages printed in NMI context:
> WARN_ON(in_nmi()), BUG_ON(in_nmi()), anything being printed out from MCE
> handlers.  These are not easy to avoid.
> 
> This patch reuses most of the code and makes it generic.  It is useful for
> all messages and architectures that support NMI.
> 
> The alternative printk_func is set when entering and is reseted when
> leaving NMI context.  It queues IRQ work to copy the messages into the
> main ring buffer in a safe context.
> 
> __printk_nmi_flush() copies all available messages and reset the buffer.
> Then we could use a simple cmpxchg operations to get synchronized with
> writers.  There is also used a spinlock to get synchronized with other
> flushers.
> 
> We do not longer use seq_buf because it depends on external lock.  It
> would be hard to make all supported operations safe for a lockless use.
> It would be confusing and error prone to make only some operations safe.
> 
> The code is put into separate printk/nmi.c as suggested by Steven Rostedt.
> It needs a per-CPU buffer and is compiled only on architectures that call
> nmi_enter().  This is achieved by the new HAVE_NMI Kconfig flag.
> 
> The are MN10300 and Xtensa architectures.  We need to clean up NMI
> handling there first.  Let's do it separately.
> 
> The patch is heavily based on the draft from Peter Zijlstra, see
> https://lkml.org/lkml/2015/6/10/327
> 
> [arnd@arndb.de: printk-nmi: use %zu format string for size_t]
> [akpm@linux-foundation.org: min_t->min - all types are size_t here]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jiri Kosina <jkosina@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
