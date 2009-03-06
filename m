Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f175.google.com (mail-gx0-f175.google.com
	[209.85.217.175]) by ozlabs.org (Postfix) with ESMTP id 4ADD8DDE41
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 02:18:23 +1100 (EST)
Received: by gxk23 with SMTP id 23so482196gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 07:18:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <538696.45538.qm@web24106.mail.ird.yahoo.com>
References: <538696.45538.qm@web24106.mail.ird.yahoo.com>
Date: Fri, 6 Mar 2009 08:18:21 -0700
Message-ID: <fa686aa40903060718q1197cdbfja1bb639af761daf4@mail.gmail.com>
Subject: Re: Interrupt GPIOs with MPC5200b
From: Grant Likely <grant.likely@secretlab.ca>
To: arieswar24b@yahoo.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 6:27 AM, Dave Best <arieswar24b@yahoo.de> wrote:
>
> Hi, I am working on a MPC5200B-tiny with 2.6.23.1 Linux (pcm030).
>
> I want to use an interrupt GPIO to act as the source for my ISR, but i can't find the IRQ numbers for the GPIOs so i can't call request_irq() to set my ISR up.
>
> For other platforms there seems to be the function gpio_to_irq() where enumerated GPIOs get an IRQ number for their request_irq calls.

Which GPIO line are you using?  Is it on the gpio_simple block?
gpio_wkup?  or one of the GPT lines?

There is support in Ben Herrenschmidt's -next tree to use the GPT as
an interrupt controller.  A similar patch for the mpc52xx_gpio driver
would be fairly easy to do.  That would allow you to simply specify
the GPIO controller as the interrupt controller in the device tree and
get your IRQ number with a single call to of_irq_parse_and_map().  It
also allows each GPIO line to be assigned an independent IRQ number
and be enabled/acked independently from the others and for the
enable/ack code to live with the mpc52xx-gpio driver where it belongs.

See here for the GPT patch.  You can use it as an example to do the
same for the gpio driver.

http://patchwork.ozlabs.org/patch/21914/

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
