Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KsBZ3N7vzF29m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 12:51:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, jeyu@kernel.org
Cc: jeyu@redhat.com, akpm@linux-foundation.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/64: Fix section mismatch warnings for early
 boot symbols
In-Reply-To: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 12:51:31 +1000
Message-ID: <87lgdvbwp8.fsf@concordia.ellerman.id.au>
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

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> writes:
> Some of the boot code located at the start of kernel text is "init"
> class, in that it only runs at boot time, however marking it as normal
> init code is problematic because that puts it into a different section
> located at the very end of kernel text.
>
> e.g., in case the TOC is not set up, we may not be able to tolerate a
> branch trampoline to reach the init function.
>
> Credits: code and message are based on 2016 patch by Nicholas Piggin,
> and slightly modified so not to rename the powerpc code/symbol names.
>
>     Subject: [PATCH] powerpc/64: quieten section mismatch warnings
>     From: Nicholas Piggin <npiggin at gmail.com>
>     Date: Fri Dec 23 00:14:19 AEDT 2016
>
> This resolves the following section mismatch warnings:
>
>     WARNING: vmlinux.o(.text+0x2fa8): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init()
>     The function __boot_from_prom() references
>     the function __init prom_init().
>     This is often because __boot_from_prom lacks a __init
>     annotation or the annotation of prom_init is wrong.
>
>     WARNING: vmlinux.o(.text+0x3238): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup()
>     The function start_here_multiplatform() references
>     the function __init early_setup().
>     This is often because start_here_multiplatform lacks a __init
>     annotation or the annotation of early_setup is wrong.
>
>     WARNING: vmlinux.o(.text+0x326c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel()
>     The function start_here_common() references
>     the function __init start_kernel().
>     This is often because start_here_common lacks a __init
>     annotation or the annotation of start_kernel is wrong.

Thanks for picking this one up.

I hate to be a pain ... but before we merge this and proliferate these
names, I'd like to change the names of some of these early asm
functions. They're terribly named due to historical reasons.

I haven't actually thought of good names yet though :)

I'll try and come up with some and post a patch doing the renames.

cheers
