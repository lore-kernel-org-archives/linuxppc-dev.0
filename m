Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfgjC2NQBzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 19:41:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
In-Reply-To: <20170309094206.A832167992@localhost.localdomain>
References: <20170309094206.A832167992@localhost.localdomain>
Date: Fri, 10 Mar 2017 19:41:33 +1100
Message-ID: <87a88tle0y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Help a bit the compiler to provide better code:
>
> unsigned int f(int i)
> {
> 	return 1 << (31 - i);
> }
>
> unsigned int g(int i)
> {
> 	return 0x80000000 >> i;
> }
>
> Disassembly of section .text:
>
> 00000000 <f>:
>    0:	20 63 00 1f 	subfic  r3,r3,31
>    4:	39 20 00 01 	li      r9,1
>    8:	7d 23 18 30 	slw     r3,r9,r3
>    c:	4e 80 00 20 	blr
>
> 00000010 <g>:
>   10:	3d 20 80 00 	lis     r9,-32768
>   14:	7d 23 1c 30 	srw     r3,r9,r3
>   18:	4e 80 00 20 	blr

Well yeah, it saves one instruction, but is it worth it? Are these gpio
routines in some hot path I don't know about?

cheers
