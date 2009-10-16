Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE028B7BAA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 15:43:47 +1100 (EST)
Subject: Re: Problem when disabled interrupt in system call (ppc8270)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "wilbur.chan" <wilbur512@gmail.com>
In-Reply-To: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
References: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Oct 2009 15:43:39 +1100
Message-Id: <1255668219.19032.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-16 at 09:12 +0800, wilbur.chan wrote:

> static inline unsigned long local_irq_disable(void)
> {
> 	unsigned long flags, zero;
> 
> 	__asm__ __volatile__("li %1,0; lbz %0,%2(13); stb %1,%2(13)"
> 	: "=r" (flags), "=&r" (zero)
> 	: "i" (offsetof(struct paca_struct, soft_enabled))
> 	: "memory");
> 
> 	return flags;
> }

This is not the variant of local_irq_disable() used on that machine :-)

The above is the 64-bit version.

Ben.
