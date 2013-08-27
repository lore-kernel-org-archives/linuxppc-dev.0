Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC0982C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 10:39:34 +1000 (EST)
Message-ID: <1377563961.3033.84.camel@snotra.buserror.net>
Subject: Re: Loading kernel on MPC86x
From: Scott Wood <scottwood@freescale.com>
To: Martin Hinner <martin@hinner.info>
Date: Mon, 26 Aug 2013 19:39:21 -0500
In-Reply-To: <CAPVwjkzT6dyv-T_8fF-zm8VLKvGFgLkrEeBC4ib-p0mkFJ7=fA@mail.gmail.com>
References: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
 <CAPVwjkyPKo0SmoEkJttzz0fXrTcyuv7K1nuhOzW9CdGXD+t7_A@mail.gmail.com>
 <1377537249.3033.26.camel@snotra.buserror.net>
 <CAPVwjkzT6dyv-T_8fF-zm8VLKvGFgLkrEeBC4ib-p0mkFJ7=fA@mail.gmail.com>
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

On Mon, 2013-08-26 at 20:29 +0200, Martin Hinner wrote:
> On Mon, Aug 26, 2013 at 7:14 PM, Scott Wood <scottwood@freescale.com> wrote:
> >> that kernel must be at location 0. Another problem was that interrupts
> >> got re-enabled during execution of my bootloader (I am doing some
> >> syscalls -> goes  to Cisco rom),
> > Do you mean you're calling into the rom after Linux has already started
> > executing?  That's not normal for 8xx.
> 
> No, in bootloader. I have disabled interrupts and then later did a
> syscall which probably enabled them again. As I have overwritten some
> of Cisco ROM data it crashed (at random place).
> 
> >> I am also curious why CONFIG_PPC_EARLY_DEBUG_CPM uses
> >> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR as pointer to transmit SMC buffer and
> >> not address of CPM/SCM parameter RAM ? TX buffer address can be read
> >> from SMC parameter RAM. Wouldn't this solution be more portable? At
> >> least this way I do it when I take over console from Cisco
> >> startup/rommon.
> >
> > The point was to keep things as simple as possible (e.g. for use in
> > temporary handcoded asm as needed).  This is a hacky debugging feature
> > that assumes you know what you're doing and can set the address to match
> > what the loader does (and that the loader's choice of address is
> > static).  If you have an improvement that keeps it simple, feel free to
> > send a patch.
> 
> How about making CONFIG_PPC_EARLY_DEBUG_CPM_PARRAM

PARAM

> that woud carry address of SMCx parameter RAM (IMMR+0x04180 on MPC866) and this value
> would be used in case CONFIG_PPC_EARLY_DEBUG_CPM_ADDR is zero ? This
> would allow kernel hackers to still use
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR for assembly debugging (+legacy use)
> and everyone else can use it as a more reliable option that does not
> rely on particular bootloader behavior. Early debug is good even for
> end-users so as they can send debug output if anything goes wrong at
> early stage.

If it only works with CPM1 SMC, then that should be in the name of the
symbol.

> Anyway, difference between _PARRAM and _ADDR is only one lwz
> instruction, so I guess it is possible to completely discard _ADDR if
> there is no legacy use for it. I am also not sure if this works with
> SCC UART ports or only CPM SMC UART.

Given that testing can be a challenge on this old hardware (I don't have
easy access anymore, except maybe one 8xx board), I'd rather leave the
existing mechanism in place if you don't have the ability to test all
these cases.  The ability to not care about what type of CPM serial port
it is, is an important simplification.

-Scott
