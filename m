Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id ABFFCDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Mar 2007 12:48:00 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so44810nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 19:47:59 -0700 (PDT)
Message-ID: <528646bc0703281947s5ab2e971y395abda5462e9870@mail.gmail.com>
Date: Wed, 28 Mar 2007 20:47:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Zhou Rui" <vancasperz@yahoo.com.cn>
Subject: Re: Try to Disable PPC Interrupt
In-Reply-To: <904550.26206.qm@web15609.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <904550.26206.qm@web15609.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/28/07, Zhou Rui <vancasperz@yahoo.com.cn> wrote:
> Hi, all
>     I am trying to disable interrupt on a PPC405EP board. I have checked
> from the 405 maunual that once the EE bit of MSR is set to 0, the external
> interrupt will be disabled. So I write a simple test module for that:
>
> #ifndef MODULE
> #define MODULE
> #endif
>
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/types.h>
> #include <linux/errno.h>
>
> void hw_disable_irq (void) {
>         int c;
>         __asm__ __volatile__(
>                 "mfmsr %%r0; \
>                 wrteei 0; \
>                 mfmsr %0;":"=r"(c) : );
>
>         printk("%h\n",c);
> }
>
> int init_module(void)
> {
> }
>
> void cleanup_module(void)
> {
> }
>
> MODULE_LICENSE("GPL");
>
> When I insert this module, it seems nothing happens and there is no output
> of the varible "c". So would you like to tell me what the problem is here?
> Thank you very much.

Umm, because this modules doesn't do anything perhaps?  You've
declared init and cleanup routines, but there are two problems with
them.
1. You haven't used the module_init and module_exit macros to actually
register them as init/exit routines.
2. They're empty

There is no possible way for your hw_disable_irq() routine to get called.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
