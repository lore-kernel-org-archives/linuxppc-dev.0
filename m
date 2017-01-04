Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttklp52hVzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 19:40:22 +1100 (AEDT)
Date: Wed, 4 Jan 2017 02:40:03 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: benh@au1.ibm.com, Christian Kujau <lists@nerdbynature.de>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
Message-ID: <20170104084003.GD28613@gate.crashing.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <1483483841.15843.4.camel@au1.ibm.com>
 <ca802791-9a7d-90b4-2025-852517225f14@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca802791-9a7d-90b4-2025-852517225f14@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 09:23:47AM +0100, Christophe LEROY wrote:
> >The way gcc implements the stack protector has some serious
> >incompatibilities with the way the Linux kernel uses r13, I wouldn't
> >even try until we sort that out...
> 
> Yes indeed, it looks like recent versions of GCC don't use anymore the 
> global __stack_chk_guard variable but a hard coded offset relative to r2 
> or r13:
> 
> On 32 bits, it uses -7008(r2)
> On 64 bits, it uses -7010(r13)

This is https://gcc.gnu.org/PR78875 .  It should have been this way since
forever; if it really wasn't, it is unclear why not.

Either way, we (i.e. GCC) will add some compiler option to make this work
for the kernel.  It will be part of 7 and we'll probably backport it to
6.4 and 5.5 .

For bootx_init.c, this probably should be compiled with -fno-stack-protector
just like all the other boot time stuff.


Segher
