Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D7922C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 03:14:26 +1000 (EST)
Message-ID: <1377537249.3033.26.camel@snotra.buserror.net>
Subject: Re: Loading kernel on MPC86x
From: Scott Wood <scottwood@freescale.com>
To: Martin Hinner <martin@hinner.info>
Date: Mon, 26 Aug 2013 12:14:09 -0500
In-Reply-To: <CAPVwjkyPKo0SmoEkJttzz0fXrTcyuv7K1nuhOzW9CdGXD+t7_A@mail.gmail.com>
References: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
 <CAPVwjkyPKo0SmoEkJttzz0fXrTcyuv7K1nuhOzW9CdGXD+t7_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-24 at 19:15 +0200, Martin Hinner wrote:
> Hello again,
> 
>   just a quick update: I have spent some more time on this and now I
> can boot into kernel (it works even with initramfs and simple assembly
> HelloWorld, so it's time to compile userland now). The problem was
> that kernel must be at location 0. Another problem was that interrupts
> got re-enabled during execution of my bootloader (I am doing some
> syscalls -> goes  to Cisco rom),

Do you mean you're calling into the rom after Linux has already started
executing?  That's not normal for 8xx.

>  otherwise it crashed randomly. And
> finally it seems that stack must be < 8M. After this kernel boots.
> 
> Anyway, I would still appreciate clarification on vmlinux:__start
> entry conditions:
> 
> - must be loaded at 0 (but why arch/powerpc/boot/main.c has option to
> allocate space for kernel at nonzero addr ?)

arch/powerpc/boot/main.c is not just for 8xx.

> - stack? Does it really have to be < 8M ?

The stack is allocated by the kernel.  It shouldn't matter what is in r1
when you initially enter the kernel.

> - interrupts disabled (really ;-) )
> - MSR.PR=0/LE=0/EE=0, but what other bits (RI? IP=0? ME?)
> - IMMR 0xff000000
> - and of course correct entry arguments in registers
> 
> anything else?
> 
> I am also curious why CONFIG_PPC_EARLY_DEBUG_CPM uses
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR as pointer to transmit SMC buffer and
> not address of CPM/SCM parameter RAM ? TX buffer address can be read
> from SMC parameter RAM. Wouldn't this solution be more portable? At
> least this way I do it when I take over console from Cisco
> startup/rommon.

The point was to keep things as simple as possible (e.g. for use in
temporary handcoded asm as needed).  This is a hacky debugging feature
that assumes you know what you're doing and can set the address to match
what the loader does (and that the loader's choice of address is
static).  If you have an improvement that keeps it simple, feel free to
send a patch.

-Scott
