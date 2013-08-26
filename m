Return-Path: <martin@hinner.info>
Received: from mail-qe0-f41.google.com (mail-qe0-f41.google.com
 [209.85.128.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17A822C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 04:29:10 +1000 (EST)
Received: by mail-qe0-f41.google.com with SMTP id x7so1990928qeu.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 11:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377537249.3033.26.camel@snotra.buserror.net>
References: <CAPVwjkzkuw4cbo9YxnsskdoAda-k+Gb5sdVEJiZTVAD1nR5OOg@mail.gmail.com>
 <CAPVwjkyPKo0SmoEkJttzz0fXrTcyuv7K1nuhOzW9CdGXD+t7_A@mail.gmail.com>
 <1377537249.3033.26.camel@snotra.buserror.net>
Date: Mon, 26 Aug 2013 20:29:06 +0200
Message-ID: <CAPVwjkzT6dyv-T_8fF-zm8VLKvGFgLkrEeBC4ib-p0mkFJ7=fA@mail.gmail.com>
Subject: Re: Loading kernel on MPC86x
From: Martin Hinner <martin@hinner.info>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 26, 2013 at 7:14 PM, Scott Wood <scottwood@freescale.com> wrote:
>> that kernel must be at location 0. Another problem was that interrupts
>> got re-enabled during execution of my bootloader (I am doing some
>> syscalls -> goes  to Cisco rom),
> Do you mean you're calling into the rom after Linux has already started
> executing?  That's not normal for 8xx.

No, in bootloader. I have disabled interrupts and then later did a
syscall which probably enabled them again. As I have overwritten some
of Cisco ROM data it crashed (at random place).

>> I am also curious why CONFIG_PPC_EARLY_DEBUG_CPM uses
>> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR as pointer to transmit SMC buffer and
>> not address of CPM/SCM parameter RAM ? TX buffer address can be read
>> from SMC parameter RAM. Wouldn't this solution be more portable? At
>> least this way I do it when I take over console from Cisco
>> startup/rommon.
>
> The point was to keep things as simple as possible (e.g. for use in
> temporary handcoded asm as needed).  This is a hacky debugging feature
> that assumes you know what you're doing and can set the address to match
> what the loader does (and that the loader's choice of address is
> static).  If you have an improvement that keeps it simple, feel free to
> send a patch.

How about making CONFIG_PPC_EARLY_DEBUG_CPM_PARRAM that woud carry
address of SMCx parameter RAM (IMMR+0x04180 on MPC866) and this value
would be used in case CONFIG_PPC_EARLY_DEBUG_CPM_ADDR is zero ? This
would allow kernel hackers to still use
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR for assembly debugging (+legacy use)
and everyone else can use it as a more reliable option that does not
rely on particular bootloader behavior. Early debug is good even for
end-users so as they can send debug output if anything goes wrong at
early stage.

Anyway, difference between _PARRAM and _ADDR is only one lwz
instruction, so I guess it is possible to completely discard _ADDR if
there is no legacy use for it. I am also not sure if this works with
SCC UART ports or only CPM SMC UART.

Martin
