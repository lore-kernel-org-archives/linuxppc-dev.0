Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E85351A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:25:00 +1100 (AEDT)
Date: Wed, 2 Dec 2015 00:24:49 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Petr Mladek <pmladek@suse.com>
cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linux-am33-list@redhat.com
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
In-Reply-To: <20151127153804.GC2648@pathway.suse.cz>
Message-ID: <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
 <20151127153804.GC2648@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 27 Nov 2015, Petr Mladek wrote:

> MN10300 has its own implementation for entering and exiting NMI 
> handlers. It does not call nmi_enter() and nmi_exit(). Please, find 
> below an updated patch that adds printk_nmi_enter() and 
> printk_nmi_exit() to the custom entry points. Then we could add HAVE_NMI 
> to arch/mn10300/Kconfig and avoid the above warning.

Hmm, so what exactly would go wrong if MN10300 (whatever that architecture 
is) would call nmi_enter() and nmi_exit() at the places where it's 
starting and finishing NMI handler?

>From a cursory look, it seems like most (if not all) of the things called 
from nmi_{enter,exit}() would be nops there anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs
