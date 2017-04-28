Return-Path: <SRS0=N7JN=4E=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDwql3CdJzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 00:17:07 +1000 (AEST)
Date: Fri, 28 Apr 2017 10:16:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Russell
 King <rmk+kernel@arm.linux.org.uk>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Metcalf
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
Message-ID: <20170428101659.7cd879e7@gandalf.local.home>
In-Reply-To: <20170428125725.GA3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170427121458.2be577cc@gandalf.local.home>
 <20170428013532.GB383@jagdpanzerIV.localdomain>
 <20170428125725.GA3452@pathway.suse.cz>
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

On Fri, 28 Apr 2017 14:57:25 +0200
Petr Mladek <pmladek@suse.com> wrote:


> Of course, if the problem is reproducible, the easiest solution
> is to use bigger main log buffer, for example boot with
> log_buf_len=32M.

Of course that may not be enough. Especially when I have a machine with
240 CPUs. But it also has a ton of RAM, I could easily do
log_buf_len=32G

-- Steve
