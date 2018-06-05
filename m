Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410b7p4XwfzF1my
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 01:19:34 +1000 (AEST)
In-Reply-To: <fa51770430e00ac2db1c621365473a0c893d105e.1528179842.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: fix build failure by disabling attribute-alias warning
 in pci_32
Message-Id: <410b7p2cVbz9s08@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-05 at 06:57:43 UTC, Christophe Leroy wrote:
> Commit 2479bfc9bc600 ("powerpc: Fix build by disabling attribute-alias
> warning for SYSCALL_DEFINEx") forgot arch/powerpc/kernel/pci_32.c
> 
> Latest GCC version emit the following warnings
> 
> As arch/powerpc code is built with -Werror, this breaks build with
> GCC 8.1
> 
> This patch inhibits this warning
> 
> In file included from arch/powerpc/kernel/pci_32.c:14:
> ./include/linux/syscalls.h:233:18: error: 'sys_pciconfig_iobase' alias between functions of incompatible types 'long int(long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/415520373975d2eba565c256d2cad8

cheers
