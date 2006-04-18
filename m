Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id A9A3A67A04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 00:03:26 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Date: Tue, 18 Apr 2006 16:05:40 +0200
References: <200604181446.08673.david.jander@protonic.nl>
	<20060418172244.25eefcd3@vitb.ru.mvista.com>
In-Reply-To: <20060418172244.25eefcd3@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604181605.40642.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 18 April 2006 15:22, Vitaly Bordug wrote:
>[..]
> Well, existing code works just fine on 885ads and 866ads, that use SMC1 and
> SMC2 as UARTs.

Interesting.

> > I'm pretty sure the following is wrong, but I can't seem to fix it
> > either. This seems to apply for both PQ and PQ2 type uarts:
> > from drivers/serial/cpm_uart/cpm_uart_cpm1.c (line 190):
>
> That's wrong - cpm_uart_cpm1.c applies to PQ only...

I know. cpm_uart_cpm2.c contains the same code, so it should be as broken as 
the cpm_uart_cpm1.c.

>[...]
> Well, since it works on other boards, and kmalloc stuff seems to sorta work
> as well, then I guess reason is screwed DMA thing for your board.
> Check/alter CONFIG_CONSISTENT_* things and see if it will help.

I did not touch de defaults. What are the rules to change them? What do I have 
to look out for?
CONFIG_CONSISTENT_START = 0xff100000 and I suspect a problem here if I was 
using MTD (currently disabled) since flash is at physical adress 
0xfe000000-0xffffffff on my board. Isn't MTD going to io_remap that area to 
that same virtual adress? How's that supposed to work then?
I changed CONFIG_CONSISTENT_START to 0xfd100000 and now the system freezes 
when I write to the serial port :-(

> And, try to just replace dma_alloc_.. with kmalloc (not changing rx_buf
> etc.) and reproduce the same behavior you had. BTW, rx_buf and tx_buf are
> never used actually in the code, hereby there is no difference what values
> they contain...

Argh. Code looks obviously broken, but since it isn't used, it just works. 
That is not good! We should fix that either way then.

Thanks,

-- 
David Jander
