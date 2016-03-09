Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF75F1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 14:41:23 +1100 (AEDT)
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 69EA9140327
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 14:41:23 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id x188so28710109pfb.2
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Mar 2016 19:41:23 -0800 (PST)
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
To: Torsten Duwe <duwe@lst.de>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308104552.GA16502@lst.de> <56DED903.2000209@gmail.com>
 <20160308153435.GA23804@lst.de>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, jikos@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56DF9B5B.6070300@gmail.com>
Date: Wed, 9 Mar 2016 14:41:15 +1100
MIME-Version: 1.0
In-Reply-To: <20160308153435.GA23804@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/03/16 02:34, Torsten Duwe wrote:
> On Wed, Mar 09, 2016 at 12:52:03AM +1100, Balbir Singh wrote:
>> On 08/03/16 21:45, Torsten Duwe wrote:
>>> To be fair, my last mail still was not 100% correct, but the conclusion
> Wrote a correction to the correction. It should be clear now. Please nag me
> if it isn't clear why klp_return_helper and its stack frame is needed.
>
>>> that the mini frame is not needed at all is invalid. Please leave it as it
>>> was, I'm working on a test / demonstrator for how to handle these.
>> Why, the magic will be in the patched function? Please share the test/demonstrator
> Here it comes...
>
>>> NAKed-by: Torsten Duwe <duwe@suse.de>
>> Why? For using CR+4 or removing the frame? Or you believe there is a better way to
>> handle this that work, IOW what is broken?
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
>
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

Leaving it to the patch to do the right thing I think makes it more
complex and each livepatch hardware dependent to a large extent.
I find it hard to read the patch, let alone audit it and apply it or
worse create one

>
> 	Torsten
>
Balbir Singh.
