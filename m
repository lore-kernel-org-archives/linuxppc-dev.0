Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ECDA1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 02:34:40 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3731A140B99
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 02:34:39 +1100 (AEDT)
Date: Tue, 8 Mar 2016 16:34:35 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, jikos@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160308153435.GA23804@lst.de>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308104552.GA16502@lst.de> <56DED903.2000209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56DED903.2000209@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 12:52:03AM +1100, Balbir Singh wrote:
> 
> On 08/03/16 21:45, Torsten Duwe wrote:
> > To be fair, my last mail still was not 100% correct, but the conclusion

Wrote a correction to the correction. It should be clear now. Please nag me
if it isn't clear why klp_return_helper and its stack frame is needed.

> > that the mini frame is not needed at all is invalid. Please leave it as it
> > was, I'm working on a test / demonstrator for how to handle these.
> Why, the magic will be in the patched function? Please share the test/demonstrator

Here it comes...

> > NAKed-by: Torsten Duwe <duwe@suse.de>
> Why? For using CR+4 or removing the frame? Or you believe there is a better way to
> handle this that work, IOW what is broken?

The stack frame removal. You're risking a memory access or jump into nirvana
or and endless loop.

klp_return_helper will do the right thing, and functions like e.g. printk
I would live patch like this (untested :-) :

------------------------8<----------------------
#include <stdarg.h>

/* compile using "-ffixed-r14"! */
register unsigned long pass_TOC asm("r14");

/*
 * Function pre-prologue to pop the klp_return_helper
 * mini stack frame. The saved r2 TOC value is read and
 * passed in pass_TOC (r14), the original LR is passed
 * in r0 and the LR itself. R12 is updated appropriately
 * for local TOC recalculation.
 */
extern void caller(void) asm("printk");
void caller(void)
{
  asm("ld %0,24(1)" : "=r" (pass_TOC));
  asm("addi 1,1,32");
  asm("addi 12,12,(real_printk-printk)@l");
  asm("ld 0,16(1)\n\tmtlr 0");
  asm("b real_printk");
}

extern int vprintk_default(const char *fmt, va_list args);

extern int printk(const char *fmt, ...) asm("real_printk");
int printk(const char *fmt, ...)
{
        va_list args;
        int r;

        va_start(args, fmt);

        r = vprintk_default(fmt, args);

        va_end(args);

	asm("mr 2,%0" : : "r" (pass_TOC));
        return r;
}
------------------------8<----------------------
Signed-off-by: Torsten Duwe <duwe@suse.de>

As you can see, the extra effort for args on the stack is limited.

	Torsten
