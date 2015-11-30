Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AFB01A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 01:25:53 +1100 (AEDT)
Date: Mon, 30 Nov 2015 15:25:45 +0100
From: Petr Mladek <pmladek@suse.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BLACKFIN ARCHITEC..."
 <adi-buildroot-devel@lists.sourceforge.net>,
 "open list:CRIS PORT" <linux-cris-kernel@axis.com>,
 Linux/MIPS Mailing List <linux-mips@linux-mips.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-ID: <20151130142545.GB8047@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2015-11-27 17:26:16, Max Filippov wrote:
Hi Max,

> > Another exception is Xtensa architecture that uses just a
> > fake NMI.
> 
> It's called fake because it's actually maskable, but sometimes
> it is safe to use it as NMI (when there are no other IRQs at the
> same priority level and that level equals EXCM level). That
> condition is checked in arch/xtensa/include/asm/processor.h
> So 'fake' here is to avoid confusion with real NMI that exists
> on xtensa (and is not currently used in linux), otherwise code
> that runs in fake NMI must follow the NMI rules.
> 
> To make xtensa compatible with your change we can add a
> choice whether fake NMI should be used to kconfig. It can
> then set HAVE_NMI accordingly. I'll post a patch for xtensa.

Thanks a lot for explanation. I'll wait for the destiny of
the patch adding CONFIG_XTENSA_FAKE_NMI. It is not easy
for me to review. Anyway, we could select HAVE_NMI for
Xtensa anytime later if this patchset goes in earlier.

Best Regards,
Petr
