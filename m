Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C42767C10
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 21:21:21 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k9VAL81P022571
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Oct 2006 11:21:09 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
Date: Tue, 31 Oct 2006 11:24:46 +0100
References: <4537A263.3010104@fabiotec.com>
	<a425f86c0610191207i3a9977c9ree3f66cbfb52950e@mail.gmail.com>
In-Reply-To: <a425f86c0610191207i3a9977c9ree3f66cbfb52950e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610311124.46698.laurent.pinchart@tbox.biz>
Cc: Boris Shteinbock <boris@fabiotec.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > After applying your patch,
> > the transmission doesn't take place at all..
> > just hanging in write...
> > at least it is possible to exit the program.
>
> That's strange. No matter how I test the driver it now works
> perfectly for me with my patches.

Ditto. Your patch fixed my problems. I'd like to see a fix (either this one or 
another one, there are different solutions) pushed upstream soon, as the 
problem is quite serious. I'm quite amazed nobody had ever reported it 
before.

> Did you apply them both?

I only applied [PATCH] CPM_UART: Fix non-console transmit

> However, I cannot see why the length of the transmission would cause any
> difference.
>
> What is you baud rate on SMC2? How about the TX buffer count and TX
> FIFO size - have you changed them? I suspect that cpm_uart_tx_pump()
> could disable your TX interrupt when you have all characters queued in
> separate TX buffers. I'll test this theory tomorrow.
>
> You might want to strace your program and post the results here. Also put
>
>   #define DEBUG
>
> in front of cpm_uart_core.c and cpm_uart_cpm2.c and recompile. You'll
> get a lot of debugging messages after
>
>   echo 8 > /proc/sys/kernel/printk
>
> That should give us clues what goes wrong. The output of
>
>   stty -F /dev/ttyCPM1 -a
>
> would also help.

Cheers,

Laurent Pinchart
