Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 198BC1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:47:54 +1100 (AEDT)
Date: Fri, 4 Dec 2015 16:47:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'yalin wang' <yalin.wang2010@gmail.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Ingo Molnar <mingo@redhat.com>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Message-ID: <20151204154749.GC20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBE1231@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2015-12-02 16:20:41, David Laight wrote:
> From: yalin wang
> > Sent: 30 November 2015 16:42
> > > On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > Testing has shown that the backtrace sometimes does not fit
> > > into the 4kB temporary buffer that is used in NMI context.
> > >
> > > The warnings are gone when I double the temporary buffer size.
> 
> You are wasting a lot of memory for something that is infrequently used.
> There ought to be some way of copying partial tracebacks into the
> main buffer.

I have already tried to use a separate ring buffer that might be
shared between all CPUs. But it was rejected because it was too
complex. See
http://thread.gmane.org/gmane.linux.kernel/1700059/focus=1700066

If we would want to crate a lockless access to the main ring
buffer, we would end up with something like
kernel/trace/ring_buffer.c. It is even more complicated.
And reading of the messages is pretty slow.

Note that we already have this buffer allocated on x86 and arm.
It is used there for printing backtrace from all CPUs.
This patchset makes it usable for all NMI messages.

But I'll make the size configurable in the next version.

Thanks for review,
Petr
