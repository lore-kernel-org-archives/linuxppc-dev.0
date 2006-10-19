Return-Path: <kallepokki@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 1313F67B77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 13:24:06 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so32124pyc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 20:24:05 -0700 (PDT)
Message-ID: <a425f86c0610191207i3a9977c9ree3f66cbfb52950e@mail.gmail.com>
Date: Thu, 19 Oct 2006 22:07:19 +0300
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Boris Shteinbock" <boris@fabiotec.com>
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
In-Reply-To: <4537A263.3010104@fabiotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4537A263.3010104@fabiotec.com>
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

On 10/19/06, Boris Shteinbock <boris@fabiotec.com> wrote:
>
> After applying your patch,
> the transmission doesn't take place at all..
> just hanging in write...
> at least it is possible to exit the program.

That's strange. No matter how I test the driver it now works
perfectly for me with my patches. Did you apply them both? However, I
cannot see why the length of the transmission would cause any
difference.

What is you baud rate on SMC2? How about the TX buffer count and TX
FIFO size - have you changed them? I suspect that cpm_uart_tx_pump()
could disable your TX interrupt when you have all characters queued in
separate TX buffers. I'll test this theory tomorrow.

You might want to strace your program and post the results here. Also put

  #define DEBUG

in front of cpm_uart_core.c and cpm_uart_cpm2.c and recompile. You'll
get a lot of debugging messages after

  echo 8 > /proc/sys/kernel/printk

That should give us clues what goes wrong. The output of

  stty -F /dev/ttyCPM1 -a

would also help.
