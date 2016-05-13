Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (unknown [IPv6:2001:720:418:ca01::139])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5kM738xdzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 18:59:47 +1000 (AEST)
Date: Fri, 13 May 2016 10:29:35 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Discard ffs() function and use builtin_ffs instead
Message-ID: <20160513082935.GC23474@visitor2.iram.es>
References: <20160512153222.6109E1A239A@localhost.localdomain>
 <3r5flF6kL6z9t5R@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3r5flF6kL6z9t5R@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 13, 2016 at 04:16:57PM +1000, Michael Ellerman wrote:
> On Thu, 2016-12-05 at 15:32:22 UTC, Christophe Leroy wrote:
> > With the ffs() function as defined in arch/powerpc/include/asm/bitops.h
> > GCC will not optimise the code in case of constant parameter, as shown
> > by the small exemple below.
> > 
> > int ffs_test(void)
> > {
> > 	return 4 << ffs(31);
> > }
> > 
> > c0012334 <ffs_test>:
> > c0012334:       39 20 00 01     li      r9,1
> > c0012338:       38 60 00 04     li      r3,4
> > c001233c:       7d 29 00 34     cntlzw  r9,r9
> > c0012340:       21 29 00 20     subfic  r9,r9,32
> > c0012344:       7c 63 48 30     slw     r3,r3,r9
> > c0012348:       4e 80 00 20     blr
> > 
> > With this patch, the same function will compile as follows:
> > 
> > c0012334 <ffs_test>:
> > c0012334:       38 60 00 08     li      r3,8
> > c0012338:       4e 80 00 20     blr
> 
> 
> But what code does it generate when it's not a constant?
> 
> And which gcc version first added the builtin version?

It already existed in gcc-2.95, which you do not want to use to compile
anything today but I have in a corner of a chroot environment to maintain
~1997 vintage embedded stuff, running a 2.2.12 kernel!

Hopefully this clears up your concerns :-)

    Cheers,
    Gabriel
