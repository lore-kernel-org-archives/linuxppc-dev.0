Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABB041A004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 03:10:29 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E7C71401AF
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 03:10:28 +1100 (AEDT)
Date: Wed, 9 Mar 2016 17:10:25 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309161025.GN10940@pathway.suse.cz>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308104552.GA16502@lst.de> <56DED903.2000209@gmail.com>
 <20160308153435.GA23804@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308153435.GA23804@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-03-08 16:34:35, Torsten Duwe wrote:
> On Wed, Mar 09, 2016 at 12:52:03AM +1100, Balbir Singh wrote:
> > 
> > On 08/03/16 21:45, Torsten Duwe wrote:
> > > To be fair, my last mail still was not 100% correct, but the conclusion
> 
> Wrote a correction to the correction. It should be clear now. Please nag me
> if it isn't clear why klp_return_helper and its stack frame is needed.
> 
> > > that the mini frame is not needed at all is invalid. Please leave it as it
> > > was, I'm working on a test / demonstrator for how to handle these.
> > Why, the magic will be in the patched function? Please share the test/demonstrator
> 
> Here it comes...
> 
> > > NAKed-by: Torsten Duwe <duwe@suse.de>
> > Why? For using CR+4 or removing the frame? Or you believe there is a better way to
> > handle this that work, IOW what is broken?
> 
> The stack frame removal. You're risking a memory access or jump into nirvana
> or and endless loop.
> 
> klp_return_helper will do the right thing, and functions like e.g. printk
> I would live patch like this (untested :-) :
> 
> ------------------------8<----------------------
> #include <stdarg.h>
> 
> /* compile using "-ffixed-r14"! */
> register unsigned long pass_TOC asm("r14");

BTW: Is this reentrant, please? I mean, is it possible to use this
hack for two functions? Could the functions call each other?

Sigh, I still need to sort all the information. I am not sure
what are the exact limitations of each proposed solution.

Thanks,
Petr

> /*
>  * Function pre-prologue to pop the klp_return_helper
>  * mini stack frame. The saved r2 TOC value is read and
>  * passed in pass_TOC (r14), the original LR is passed
>  * in r0 and the LR itself. R12 is updated appropriately
>  * for local TOC recalculation.
>  */
> extern void caller(void) asm("printk");
> void caller(void)
> {
>   asm("ld %0,24(1)" : "=r" (pass_TOC));
>   asm("addi 1,1,32");
>   asm("addi 12,12,(real_printk-printk)@l");
>   asm("ld 0,16(1)\n\tmtlr 0");
>   asm("b real_printk");
> }
> 
> extern int vprintk_default(const char *fmt, va_list args);
> 
> extern int printk(const char *fmt, ...) asm("real_printk");
> int printk(const char *fmt, ...)
> {
>         va_list args;
>         int r;
> 
>         va_start(args, fmt);
> 
>         r = vprintk_default(fmt, args);
> 
>         va_end(args);
> 
> 	asm("mr 2,%0" : : "r" (pass_TOC));
>         return r;
> }
> ------------------------8<----------------------
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> As you can see, the extra effort for args on the stack is limited.
> 
> 	Torsten
> 
