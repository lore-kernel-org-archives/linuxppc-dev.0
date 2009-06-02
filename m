Return-Path: <xcarandiru@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id A0888DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 23:24:17 +1000 (EST)
Received: by qyk29 with SMTP id 29so6600788qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jun 2009 06:24:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243817268.4375.28.camel@concordia>
References: <d970ff420905291307p62e9c6eck772e7ee3757ee44a@mail.gmail.com>
	<1243817268.4375.28.camel@concordia>
Date: Tue, 2 Jun 2009 10:24:15 -0300
Message-ID: <d970ff420906020624r6988e99aq2d3ddae26e0d6585@mail.gmail.com>
Subject: Re: MPC8343 - serial8250: too much work
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

In a normal situation, I have something like this:

serial8250_interrupt()
serial8250_handle_port()
transmit_chars()
pass_counter: 0
serial8250_handle_port()
pass_counter: 1
serial8250_handle_port()
pass_counter: 2
pass_counter: 3


But when the problem happends:

serial8250_interrupt(16)
serial8250_handle_port()
transmit_chars()
uart_circ_empty()
pass_counter: 0
.
.
.
serial8250_handle_port()
transmit_chars()
uart_circ_empty()
pass_counter: 257
serial8250: too much work for irq16

If the circ buffer is empty, why iterate 256 times?

How can I trace the application that is calling serial routines?

Its difficult to debug cause I use serial console to communicate with the board.

Thanks in advance,

--
Alemao
