Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdfgc3ZKZzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 14:50:36 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id td3so135313913pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Apr 2016 21:50:36 -0700 (PDT)
Date: Mon, 4 Apr 2016 13:52:00 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
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
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160404045200.GE6164@swordfish>
References: <1459353210-20260-6-git-send-email-pmladek@suse.com>
 <201603310000.dKufp7mg%fengguang.wu@intel.com>
 <20160331123657.GN5522@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160331123657.GN5522@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On (03/31/16 14:36), Petr Mladek wrote:
[..]
>  #ifdef CONFIG_PRINTK_NMI
> +#define deferred_console_in_nmi() in_nmi()
>  #else
> +#define deferred_console_in_nmi() 0
[..]
> +	if (!in_sched && !deferred_console_in_nmi()) {
>  		lockdep_off();
>  		/*
>  		 * Try to acquire and then immediately release the console

or use SCHED level for nmi messages instead of defining deferred_console_in_nmi()?
so !in_sched will work for both SCHED and NMI messages.

	-ss
