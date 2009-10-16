Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 12B84B7B92
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 16:14:59 +1100 (EST)
Received: by yxe8 with SMTP id 8so1549314yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 22:14:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255668219.19032.12.camel@pasglop>
References: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
	<1255668219.19032.12.camel@pasglop>
Date: Fri, 16 Oct 2009 13:14:58 +0800
Message-ID: <e997b7420910152214h2443e2c0k700ff2a9919cbca5@mail.gmail.com>
Subject: Re: Problem when disabled interrupt in system call (ppc8270)
From: "wilbur.chan" <wilbur512@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/10/16, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Fri, 2009-10-16 at 09:12 +0800, wilbur.chan wrote:
>
>> static inline unsigned long local_irq_disable(void)
>> {
>> 	unsigned long flags, zero;
>>
>> 	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
>> 	: "=r" (flags), "=&r" (zero)
>> 	: "i" (offsetof(struct paca_struct, soft_enabled))
>> 	: "memory");
>>
>> 	return flags;
>> }
>
> This is not the variant of local_irq_disable() used on that machine :-)
>
> The above is the 64-bit version.
>
> Ben.
Hmmm...

I just called  local_irq_disable in sys_reboot, but actually, I don't
know which

local_irq_disable  function it really called , So I just paste one of
them here ...
