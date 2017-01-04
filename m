Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttzvp4BFkzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:33:10 +1100 (AEDT)
Date: Wed, 4 Jan 2017 10:33:05 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
In-Reply-To: <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
Message-ID: <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Jan 2017, Christophe LEROY wrote:
> Using GCC 5.4.0, I don't have that issue. bootx_init.o only contains reference
> to __stack_chk_fail

FWIW, building with a GCC 5.2 crosscompiler succeeds (with 
CONFIG_CC_STACKPROTECTOR_STRONG=y), but I don't know if it will boot 
though, see my other mail in this thread:

  https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-January/152623.html

So, would the following be sufficient? It compiles, but I haven't had a 
chance to boot yet.


diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 1eb7b45..c7dcab9 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -1,4 +1,4 @@
-CFLAGS_bootx_init.o  		+= -fPIC
+CFLAGS_bootx_init.o  		+= -fPIC -fno-stack-protector
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code


Thanks,
Christian.
-- 
BOFH excuse #156:

Zombie processes haunting the computer
