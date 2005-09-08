Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4B0D681CA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 11:15:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050908005135.GA8882@dmt.cnet>
References: <20050907230324.GC7513@dmt.cnet>
	<1126139332.29803.0.camel@gaston>  <20050908005135.GA8882@dmt.cnet>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 11:14:57 +1000
Message-Id: <1126142097.29803.4.camel@gaston>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> e is shared by all architectures. Doing something like
> 
> /*
>  * 8, 16 and 32 bit, big and little endian I/O operations, with barrier.
>  */
> extern inline int in_8(volatile unsigned char __iomem *addr)
> {
>         int ret;
> 
>         __asm__ __volatile__(
>                 "lbz%U1%X1 %0,%1;\n"
> #ifndef CONFIG_8xx
>                 "twi 0,%0,0;\n"
>                 "isync" : "=r" (ret) : "m" (*addr));
> #else
>                 : "=r" (ret) : "m" (*addr));
> #endif
>         return ret;
> }
> 
> Seems somewhat ugly?

Yes. You can work around that by macro-generating the functions with
different rules for different CPUs, or having the twi/isync be a
separate asm block that is itself in a macro or inline that gets defined
differently on 8xx

Ben.
