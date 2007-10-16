Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 917FADDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 06:06:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1342887nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 13:06:12 -0700 (PDT)
Message-ID: <fa686aa40710161306s780ebe64g680d6106ecb77d0e@mail.gmail.com>
Date: Tue, 16 Oct 2007 14:06:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Alan Bennett" <embedded@akb.net>
Subject: Re: Describing devices in the device tree
In-Reply-To: <bfa0697f0710161136y7d28ccd6w828f16d30f85ce19@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0710161136y7d28ccd6w828f16d30f85ce19@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, Alan Bennett <embedded@akb.net> wrote:
> I'm using a modified ep8248e.dts to describe my hardware and I want to
> enable the use of 3 standard interrupts.
>
>   1. irq5
>   2. timer1
>   3. timer2
>
> How bad does this look?
> soc --> cpm -->
>                        timer {
>                                device_type = "timer";
>                                compatible = "fsl,mpc8248-timer";
>                                interrupts = <c 8 d 8>;
>                                interrupt-parent = <&PIC>;
>                        };
>                        irq5 {
>                                device_type = "irq5";
>                                compatible = "fsl,mpc8248-irq5";
>                                interrupts = <17 8>;
>                                interrupt-parent = <&PIC>;
>                        };

Don't do this.  Instead, describe the device that generates the
interrupt.  You don't need the device_type property either unless it
is a common device.  The compatible property should also describe your
device; not the irq line.

Just creating a device node to describe an irq line doesn't buy you
anything because your device driver still needs to have the knowledge
built into it to use IRQ5.  You may as well have just hard coded the
value into your driver instead of traversing through the device tree
to get it.

You get an advantage when you create a node for you *device* that your
device driver can bind, and embed into that node the IRQ line that it
uses.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
