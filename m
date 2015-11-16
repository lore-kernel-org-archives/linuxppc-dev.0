Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F3EA1A0611
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 11:50:47 +1100 (AEDT)
Message-ID: <1447635046.12577.3.camel@ellerman.id.au>
Subject: Re: Section mismatches in arch/powerpc/kernel/head_64.S
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Tiejun Chen
 <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 16 Nov 2015 11:50:46 +1100
In-Reply-To: <5645072A.9000103@redhat.com>
References: <5645072A.9000103@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laura,

On Thu, 2015-11-12 at 13:39 -0800, Laura Abbott wrote:
> Hi,
 
> There seem to be section mismatches coming from head_64.S
> 
> WARNING: vmlinux.o(.text+0x8994): Section mismatch in reference from the
> variable __boot_from_prom to the function .init.text:prom_init()
> The function __boot_from_prom() references
> the function __init prom_init().
> This is often because __boot_from_prom lacks a __init
> annotation or the annotation of prom_init is wrong.
> 
> WARNING: vmlinux.o(.text+0x8c30): Section mismatch in reference from the
> variable start_here_multiplatform to the function .init.text:early_setup()
> The function start_here_multiplatform() references
> the function __init early_setup().
> This is often because start_here_multiplatform lacks a __init
> annotation or the annotation of early_setup is wrong.
> 
> WARNING: vmlinux.o(.text+0x8c54): Section mismatch in reference from the
> variable start_here_common to the function .init.text:setup_system()
> The function start_here_common() references
> the function __init setup_system().
> This is often because start_here_common lacks a __init
> annotation or the annotation of setup_system is wrong.
> 
> WARNING: vmlinux.o(.text+0x8c68): Section mismatch in reference from the
> variable start_here_common to the function .init.text:start_kernel()
> The function start_here_common() references
> the function __init start_kernel().
> This is often because start_here_common lacks a __init
> annotation or the annotation of start_kernel is wrong.

These all look correct, ie. they are references from non-init code to init
code. I don't think any of them are real bugs, because that is all early boot
code anyway which should never run after boot, or if it did that would be a big
anyway.

I'm not sure how we fix them. Some of that code might be able to be moved out
of head_64.S and made __init, but then you just have the same problem again.

It looks like x86 calls through a pointer and marks that as __REFDATA, but
that's kind of gross just to avoid a section mismatch warning.

So I'm not sure what the solution is here.

cheers
