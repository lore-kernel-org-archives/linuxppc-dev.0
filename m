Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDbx629jHzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 11:35:38 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g23so15039967pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:35:38 -0700 (PDT)
Date: Fri, 28 Apr 2017 10:35:32 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20170428013532.GB383@jagdpanzerIV.localdomain>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427121458.2be577cc@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (04/27/17 12:14), Steven Rostedt wrote:
[..]
> I tried this patch. It's better because I get the end of the trace, but
> I do lose the beginning of it:
> 
> ** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path

many thanks!

so we now drop messages from logbuf, not from per-CPU buffers. that
"queue printk_deferred irq_work on every online CPU when we bypass per-CPU
buffers from NMI" idea *probably* might help here - we need someone to emit
messages from the logbuf while we printk from NMI. there is still a
possibility that we can drop messages, though, since log_store() from NMI
CPU can be much-much faster than call_console_drivers() on other CPU.

	-ss
