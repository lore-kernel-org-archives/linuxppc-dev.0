Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fP0fjzzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:09 +1000 (AEST)
In-Reply-To: <1459116497-19991-3-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/3] powerpc: make kernel/nvram_64.c explicitly non-modular
Message-Id: <3qk8fN6mWpz9t57@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-27-03 at 22:08:16 UTC, Paul Gortmaker wrote:
> The Makefile/Kconfig currently controlling compilation of this code is:
> 
> obj-$(CONFIG_PPC64)             += setup_64.o sys_ppc32.o \
>                                    signal_64.o ptrace32.o \
>                                    paca.o nvram_64.o firmware.o
> 
> arch/powerpc/platforms/Kconfig.cputype:config PPC64
> arch/powerpc/platforms/Kconfig.cputype: bool "64-bit kernel"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
...
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c0c523897d1f83bc8484cb58d1

cheers
