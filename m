Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5flG0P5NzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 16:16:58 +1000 (AEST)
In-Reply-To: <20160512153222.6109E1A239A@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Discard ffs() function and use builtin_ffs instead
Message-Id: <3r5flF6kL6z9t5R@ozlabs.org>
Date: Fri, 13 May 2016 16:16:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 15:32:22 UTC, Christophe Leroy wrote:
> With the ffs() function as defined in arch/powerpc/include/asm/bitops.h
> GCC will not optimise the code in case of constant parameter, as shown
> by the small exemple below.
> 
> int ffs_test(void)
> {
> 	return 4 << ffs(31);
> }
> 
> c0012334 <ffs_test>:
> c0012334:       39 20 00 01     li      r9,1
> c0012338:       38 60 00 04     li      r3,4
> c001233c:       7d 29 00 34     cntlzw  r9,r9
> c0012340:       21 29 00 20     subfic  r9,r9,32
> c0012344:       7c 63 48 30     slw     r3,r3,r9
> c0012348:       4e 80 00 20     blr
> 
> With this patch, the same function will compile as follows:
> 
> c0012334 <ffs_test>:
> c0012334:       38 60 00 08     li      r3,8
> c0012338:       4e 80 00 20     blr


But what code does it generate when it's not a constant?

And which gcc version first added the builtin version?

cheers
