Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 948A967B1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 17:09:50 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id 591C5A4065
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 08:50:25 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
Date: Wed, 24 May 2006 08:50:24 +0200
References: <20060524061205.53935.qmail@web8405.mail.in.yahoo.com>
In-Reply-To: <20060524061205.53935.qmail@web8405.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200605240850.24333.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On onsdag 24 maj 2006 08.12, sandeep malik wrote:
> Hi All...
>
>   I am trying to run an application compiled with gcc toolchain gcc--3.4.3
> and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I
> am getting following error....
>
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>
>   I was suspecting this error might be because the hardware is not
> supporting floating point operations and hence i tried a simple program in
> which I intentionally did some floating point operation but that program
> was running as expected. 
No, the warning is more serious than that.

Linux does not save floating point registers when entering kernel.
It might even optimize not to store/reload when doing a context switch.

If your kernel module is using floating point in your kernel code.
It will probably work on a processor not having floating point but will
break in mysterious ways on one supporting hardware floating point.

Do not use floating point in kernel. If you still have to you must take
extremely care.
  Turn off kernel preemption.
  Save FP registers.
  Do your stuff.
  Reload FP registers.
  Turn on preemption.
But the question is why would you have to?
Simple calculations can be done in fixed point, and complex calculations
does not belong in the kernel.

/RogerL
