Return-Path: <jcmvbkbc@gmail.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DD811A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2015 01:26:19 +1100 (AEDT)
Received: by oies6 with SMTP id s6so63294362oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 06:26:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
Date: Fri, 27 Nov 2015 17:26:16 +0300
Message-ID: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
From: Max Filippov <jcmvbkbc@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BLACKFIN ARCHITEC..."
 <adi-buildroot-devel@lists.sourceforge.net>,
 "open list:CRIS PORT" <linux-cris-kernel@axis.com>,
 "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Fri, Nov 27, 2015 at 2:09 PM, Petr Mladek <pmladek@suse.com> wrote:
> printk() takes some locks and could not be used a safe way in NMI
> context.
>
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").
>
> This patch reuses most of the code and makes it generic. It is
> useful for all messages and architectures that support NMI.
>
> The alternative printk_func is set when entering and is reseted when
> leaving NMI context. It queues IRQ work to copy the messages into
> the main ring buffer in a safe context.
>
> __printk_nmi_flush() copies all available messages and reset
> the buffer. Then we could use a simple cmpxchg operations to
> get synchronized with writers. There is also used a spinlock
> to get synchronized with other flushers.
>
> We do not longer use seq_buf because it depends on external lock.
> It would be hard to make all supported operations safe for
> a lockless use. It would be confusing and error prone to
> make only some operations safe.
>
> The code is put into separate printk/nmi.c as suggested by
> Steven Rostedt. It needs a per-CPU buffer and is compiled only
> on architectures that call nmi_enter(). This is achieved by
> the new HAVE_NMI Kconfig flag.
>
> One exception is arm where the deferred printing is used for
> printing backtraces even without NMI. For this purpose,
> we define NEED_PRINTK_NMI Kconfig flag. The alternative
> printk_func is explicitly set when IPI_CPU_BACKTRACE is
> handled.
>
> Another exception is Xtensa architecture that uses just a
> fake NMI.

It's called fake because it's actually maskable, but sometimes
it is safe to use it as NMI (when there are no other IRQs at the
same priority level and that level equals EXCM level). That
condition is checked in arch/xtensa/include/asm/processor.h
So 'fake' here is to avoid confusion with real NMI that exists
on xtensa (and is not currently used in linux), otherwise code
that runs in fake NMI must follow the NMI rules.

To make xtensa compatible with your change we can add a
choice whether fake NMI should be used to kconfig. It can
then set HAVE_NMI accordingly. I'll post a patch for xtensa.

-- 
Thanks.
-- Max
