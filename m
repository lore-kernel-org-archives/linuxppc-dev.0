Return-Path: <nvbolhuis@aimvalley.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 01B3AB71E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 18:35:48 +1000 (EST)
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by ozlabs.org (Postfix) with ESMTP id 35F4EDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 18:35:45 +1000 (EST)
Message-ID: <4A38AADD.3070801@aimvalley.nl>
Date: Wed, 17 Jun 2009 10:35:41 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
In-Reply-To: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

I doubt if there are working designs for this.

In u-boot the watchdog (if enabled with CONFIG_WATCHDOG) is normally
strobed in the decrementer interrupt routine (timer_interrupt). So
I guess there's not a big chance it triggers a reset.

It is possible to configure the WD to issue a machine check interrupt
(i.s.o. HRESET). Maybe it's possible (or even done already) to put the
flash into READ-mode from the isr ?

---
N. van Bolhuis.



Leon Woestenberg wrote:
> Hello,
> 
> this is a hardware, even board issue, but I hope to find the right
> target audience here.
> 
> 
> In our MPC83xx design I would like to prevent dead lock in case where
> a field upgrade is performed, i.e. NOR Flash is erased or written, and
> the MPC83xx built-in hardware watchdog triggers.
> 
> In u-boot the scenario can be easily reproduced by running this
> command (WARNING, erases some sectors!) on an MPC8313E-RDB:
> 
> erase_wdg=mw.l 0xe0000204 0x10000007 1;mw.w 0xe000020e 0x556c 1;mw.w
> 0xe000020e 0xaa39 1;erase 1:10-30
> 
> This sets up the watchdog to reset soonish, then starts erasing NOR
> sectors. Watchdog triggers and resets -> Dead lock.
> 
> 
> Most MPC8xxx board designs I have seen suffer from this possible dead lock:
> - NOR Flash is put in erase mode or write mode
> - Hardware watchdog triggers
> - HRESET# is asserted by the processor, during which the configuration
> words are read from NOR Flash.
> 
> Either
> HRESET# is not attached to NOR, NOR stays in erase/write mode and
> invalid words will be read -> dead lock
> 
> or either:
> HRESET# is attached to NOR reset, NOR is reset, but stays in reset as
> HRESET# stays asserted.
> 
> 
> 
> We have been looking at several solutions hardware wise that reset the
> NOR flash on HRESET# going low, but the processors are stubborn,
> read the config words only once, than dead lock.
> 
> I wonder if there are known-working designs for this.
> 
> Regards,
