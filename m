Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 5E956DE03D
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 06:33:40 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so375128anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 11:33:39 -0800 (PST)
Message-ID: <fa686aa40802151133l2a76d101pcd827b3d41af6609@mail.gmail.com>
Date: Fri, 15 Feb 2008 12:33:38 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
In-Reply-To: <47B5E4B2.4050705@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B59631.10908@ru.mvista.com>
	<fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
	<47B5E042.9050805@ru.mvista.com>
	<fa686aa40802151102p7f540094j4fafcd5839381052@mail.gmail.com>
	<47B5E4B2.4050705@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 12:14 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Grant Likely wrote:
>  > The registers are not at the same location, therefore it is not compatible.
>
>  > However, the *driver* can be easily made compatible with the devices.
>  > We just teach the driver to bind against both "ns16550" and whatever
>  > value is chosen for these reg-shifted devices.  Not a big deal.
>
>     You're going to "teach" 8250.c? Good luck. :-)

:-P

As you already know, 8250.c already knows how to handle reg shifts.
But that is not what this conversation is about.

>     IMO we can only teach a glue layer which "passes" UARTs to 8250.c via
>  platform devices.

That's right.  This discussion is only about the device tree binding.
It is not about the core driver.

>  > compatible also covers bus binding when it is a memory mapped device.
>  > Otherwise you need another node between the bus and the ns16550 type
>  > device that does translation from the wide stride (regshift=2) to the
>  > ns16550 register definitions (regshift=0).
>
>     The chip can be connected to the bus (via chip select circuitry) in
>  different ways, therefore we need a "glue" node for that circuitry?

I'm not arguing that we want a glue node.  What I'm arguing is that
"compatible=ns16550" has a very specific meaning that has become a
defacto standard over the years.  To add a new interpretation of that
meaning is problematic.  Instead, if reg shift is needed then use a
different value for compatible.

It's not like we're talking about something that is hard to do.  It is
simply being explicit in the device tree layout.  Historically
"ns16550" means no reg shift, so don't use it for devices that have a
reg shift.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
