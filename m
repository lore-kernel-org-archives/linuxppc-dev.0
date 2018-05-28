Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vgGK44nfzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 01:08:09 +1000 (AEST)
Date: Mon, 28 May 2018 10:07:26 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
Message-ID: <20180528150726.GC17342@gate.crashing.org>
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
 <e81f81b7-2bf5-7f9a-919f-87972bf1a9db@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e81f81b7-2bf5-7f9a-919f-87972bf1a9db@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 28, 2018 at 02:39:37PM +0000, Christophe Leroy wrote:
> In file included from arch/powerpc/kernel/syscalls.c:24:
> ./include/linux/syscalls.h:233:18: warning: 'sys_mmap2' alias between 
> functions of incompatible types 'long int(long unsigned int,  size_t, 
> long unsigned int,  long unsigned int,  long unsigned int,  long 
> unsigned int)' {aka 'long int(long unsigned int,  unsigned int,  long 
> unsigned int,  long unsigned int,  long unsigned int,  long unsigned 
> int)'} and 'long int(long int,  long int,  long int,  long int,  long 
> int,  long int)' [-Wattribute-alias]

So yes, these are actually different (int vs. long).

> In file included from arch/powerpc/kernel/signal_32.c:29:
> ./include/linux/syscalls.h:233:18: warning: 'sys_swapcontext' alias 
> between functions of incompatible types 'long int(struct ucontext *, 
> struct ucontext *, long int)' and 'long int(long int,  long int,  long 
> int)' [-Wattribute-alias]

And this one is quite spectacularly different.


Try putting this before the wacko aliases:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wattribute-alias"

and this after:

#pragma GCC diagnostic pop

so that you will get this quite useful warning for all other code.


Segher
