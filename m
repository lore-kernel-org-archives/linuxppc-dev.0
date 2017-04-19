Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7TMJ098gzDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:22:04 +1000 (AEST)
Date: Wed, 19 Apr 2017 19:21:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20170419172139.hipylcdsarhvnsby@hirez.programming.kicks-ass.net>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419131341.76bc7634@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 01:13:41PM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2016 13:48:42 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI context.
> 
> I just found a problem with this solution. It kills ftrace dumps from
> NMI context :-(
> 
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-_raw_spin_lock
> [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime: comm=cc1 pid=67423 runtime=96858 [ns] vruntime=11924198270 [ns]
> [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: ffffffff81c5c940 read rcu_read_lock
> [ 1295.168497]
> [ 1295.168498] Lost 4890096 message(s)!
> [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x27/0x40)
> [ 1296.811553] Call Trace:
> [ 1296.811553]  <NMI>
> 
> I was hoping to see a cause of a hard lockup by enabling
> ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> gets flushed, we need to find a new way to print out the full ftrace
> buffer over serial.
> 
> Thoughts?

early_printk ;-)
