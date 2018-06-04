Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgP0NwlzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:13 +1000 (AEST)
In-Reply-To: <20180528060834.72DE86F377@po14934vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/Makefile: set -mcpu=860 flag for the 8xx
Message-Id: <40zxgL3MdHz9s7X@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-28 at 06:08:34 UTC, Christophe Leroy wrote:
> When compiled with GCC 8.1, vmlinux is significantly bigger than
> with GCC 4.8.
> 
> When looking at the generated code with objdump, we notice that
> all functions and loops when a 16 bytes alignment. This significantly
> increases the size of the kernel. It is pointless and even
> counterproductive as on the 8xx 'nop' also consumes one clock cycle.
> 
> Size of vmlinux with GCC 4.8:
>    text	   data	    bss	    dec	    hex	filename
> 5801948	1626076	 457796	7885820	 7853fc	vmlinux
> 
> Size of vmlinux with GCC 8.1:
>    text	   data	    bss	    dec	    hex	filename
> 6764592	1630652	 456476	8851720	 871108	vmlinux
> 
> Size of vmlinux with GCC 8.1 and this patch:
>    text	   data	    bss	    dec	    hex	filename
> 6331544	1631756	 456476	8419776	 8079c0	vmlinux
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c38976334c0efce1b285369a6037f

cheers
