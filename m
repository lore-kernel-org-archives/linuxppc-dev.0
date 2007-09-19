Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id C99ACDDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:09:04 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so187870rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 08:09:03 -0700 (PDT)
Message-ID: <fa686aa40709190809v284618d4r65674a1409ab0b57@mail.gmail.com>
Date: Wed, 19 Sep 2007 09:09:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: Configuration-Problem ext-interrupt on mpc52xx
In-Reply-To: <20070919115952.GF5682@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070919115952.GF5682@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/19/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> Hi,
>
> how can i configure an "ext interrupt" to high-level? I want a interruption on
> IRQ2, but I checked with an oscilloscope that the pin has a low state and I
> needs a high state.
>
> I have tried, after I got the irq (with irq_of_parse_and_map), set it with
>
>     set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
>
> But I think it is a system-configuration (irq_desc) and no
> device-configuration.

You shouldn't need to do this.  You set your sense level in the device tree.

>From your previous email, your device node looks like this:
>             intpin@0 {
>                 interrupt-parent = <500>;
>                 interrupts = <1 2 2>;
>             };

Which is IRQ2, EDGE_FALLING.

If you change your interrupts property to <1 2 0>, then your sense is
set to LEVEL_HIGH.  (Seriously, you need to read the interrupts
section of Documentation/powerpc/mpc52xx-device-tree-bindings.txt.)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
