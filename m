Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 123B11A1277
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 22:21:52 +1100 (AEDT)
Date: Tue, 8 Dec 2015 12:21:45 +0100
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
Message-ID: <20151208112145.GK20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Take the scenario where CPU1 is in the middle of a printk(), and is
> holding its lock.
> 
> CPU0 comes along and decides to trigger a NMI backtrace.  This sends
> a NMI to CPU1, which takes it in the middle of the serial console
> output.
> 
> With the existing solution, the NMI output will be written to the
> temporary buffer, and CPU1 has finished handling the NMI it resumes
> the serial console output, eventually dropping the lock.  That then
> allows CPU0 to print the contents of all buffers, and we get NMI
> printk output.
> 
> With this solution, as I understand it, we'll instead end up with
> CPU1's printk trying to output direct to the console, and although
> we've busted a couple of locks, we won't have busted the serial
> console locks, so CPU1 will deadlock - and that will stop any output
> what so ever.
> 
> If this is correct, then the net result is that we go from NMI with
> serial console producing output to NMI with serial console being
> less reliable at producing output.

You are right. I thought about it a lot and I think that the best
solution is to avoid this patch at all. I guess that it will make
Peter Zijlstra happy as well.

Best Regards,
Petr
