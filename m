Return-Path: <76306.1226@compuserve.com>
Received: from liaag2aa.mx.compuserve.com (liaag2aa.mx.compuserve.com
	[149.174.40.154]) by ozlabs.org (Postfix) with ESMTP id 1DDEF67BA8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 11:35:30 +1000 (EST)
Date: Mon, 17 Jul 2006 21:22:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Sender: Chuck Ebbert <76306.1226@compuserve.com>
To: Horms <horms@verge.net.au>
Message-ID: <200607172126_MC3-1-C544-E35A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
	Tony Luck <tony.luck@intel.com>,
	linux-ia64 <linux-ia64@vger.kernel.org>, discuss@x86-64.org,
	Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In-Reply-To: <31687.FP.7244@verge.net.au>

On Mon, 17 Jul 2006 12:17:20 -0400, Horms wrote:

> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.
> 
> It was pointed out to me by Andi Kleen that if an oops has occured
> in interrupt context, then calling sleep() in the oops path will only cause
> a panic, and that it would be really better for it not to be in the path at
> all. 

i386 already checks in_interrupt() and panics immediately:

--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -442,11 +442,9 @@ #endif
===>    if (in_interrupt())
===>            panic("Fatal exception in interrupt");
 
-       if (panic_on_oops) {
-               printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-               ssleep(5);
-               panic("Fatal exception");
-       }
+       if (panic_on_oops)
+               panic("Fatal exception: panic_on_oops");
+
        oops_exit();
        do_exit(SIGSEGV);
 }

-- 
Chuck
And did we tell you the name of the game, boy, we call it Riding the Gravy Train.
