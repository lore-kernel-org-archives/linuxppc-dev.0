To: MAC21C@chollian.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QM_MODULES
References: <200010260055.JAA14919@ldap.dacom.co.kr>
From: Marcus Sundberg <marcus@cendio.se>
Date: 26 Oct 2000 21:35:14 +0200
In-Reply-To: MAC21C@chollian.net's message of "Thu, 26 Oct 2000 09:56:23 +0900"
Message-ID: <ver953jszx.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MAC21C@chollian.net writes:

> hello all!!
>
> I have a problum.
>
> I made the test.c file for device driver test.
>
> ========== test.c ===================
> #define MODULE
> #include <linux/kernel.h>
> #include <linux/module.h>
>
> #if CONFIG_MODVERSIONS==1
> #define MODVERSION
> #include <linux/modversions.h>
> #endif

That should read:
========== test.c ===================
#define MODULE
#include <linux/config.h>
#ifdef CONFIG_MODVERSIONS
# define MODVERSIONS
# include <linux/modversions.h>
#endif

#include <linux/kernel.h>
#include <linux/module.h>

> int init_module(void) { printk("Hello, kim\n"); return 0; }
> void cleanup_module(void) { printk("Goodbye Kim\n"); }
> ======================================
> And, compile options
> powerpc-linux-gcc -D__KERNEL__ -O -c test.c
> /tmp/cc8k7ews.s: Assembler messages:
> /tmp/cc8k7ews.s:6: Warning: Ignoring changed section attributes for .modinfo

Haven't seen that message before. If the above doesn't help, try
changing the -O flag to -O2.

Also, what version of binutils are you using?

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
