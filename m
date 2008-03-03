Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 44691DDF3F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 01:54:34 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so9608anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Mar 2008 06:54:33 -0800 (PST)
Message-ID: <fa686aa40803030654k6e8155b9u9d36a46d1ecff3a3@mail.gmail.com>
Date: Mon, 3 Mar 2008 07:54:33 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Philippe De Muyter" <phdm@macqel.be>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
In-Reply-To: <20080303144727.GA27949@ingate.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080303144727.GA27949@ingate.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 3, 2008 at 7:47 AM, Philippe De Muyter <phdm@macqel.be> wrote:
>  My root device is on a compact-flash connected to a PCI yenta chip from TI,
>  and this one is not working, altough it seems to be discovered :
>
>         Yenta: CardBus bridge found at 0000:00:12.0 [0000:0000]
>         Yenta: Using CSCINT to route CSC interrupts to PCI
>         Yenta: Routing CardBus interrupts to PCI
>         Yenta TI: socket 0000:00:12.0, mfunc 0x00001b22, devctl 0x64
>         irq 18: nobody cared (try booting with the "irqpoll" option)
>         Call Trace:
>         [cf813af0] [c00066c8] show_stack+0x3c/0x1bc (unreliable)
>         [cf813b30] [c003c1ac] __report_bad_irq+0x38/0xcc
>         [cf813b50] [c003c4c8] note_interrupt+0x288/0x2cc
>         [cf813b80] [c003cc34] handle_fasteoi_irq+0x94/0xf8
>
>  but my boot finally fails with :
>
>         VFS: Cannot open root device "hda1" or unknown-block(0,0)
>         Please append a correct "root=" boot option; here are the
>         available partitions:
>         1f00       8192 mtdblock0 (driver?)
>         Kernel panic - not syncing: VFS: Unable to mount root fs
>         on unknown-block(0,0)
>
>  Is there an easy way to use values found in /proc or even in the sources
>  in my working ppc setup to put them in the dts file to make my new powerpc
>  configuration work ?

It does not look like you are having dts problems.  Once your in the
PCI domain, Linux will probe the devices (as your boot log shows).
Rather, your boot failure is due to the yenta device failure.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
