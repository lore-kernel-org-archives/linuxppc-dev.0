Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsjP50dhzDqmQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:08:09 +1000 (AEST)
Message-ID: <1467086888.32607.9.camel@ellerman.id.au>
Subject: Re: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Binderman <linuxdev.baldrick@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Date: Tue, 28 Jun 2016 14:08:08 +1000
In-Reply-To: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
References: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
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

On Mon, 2016-06-27 at 09:04 +0100, David Binderman wrote:

> Hello there,
> 
> linux-4.7-rc5/arch/powerpc/xmon/dis-asm.h:20]: (warning) %x in format
> string (no. 1) requires 'unsigned int' but the argument type is
> 'unsigned long'.
> [linux-4.7-rc5/arch/powerpc/xmon/dis-asm.h:26]: (warning) %x in format
> string (no. 1) requires 'unsigned int' but the argument type is
> 'unsigned long'.

What config / toolchain are you using? I've never seen these.

Oh, I see, with CONFIG_XMON_DISASSEMBLY=n.

> static inline int print_insn_powerpc(unsigned long insn, unsigned long memaddr)
> {
>     printf("%.8x", insn);
>     return 0;
> }

Send me a patch to cast insn to unsigned int?

cheers
