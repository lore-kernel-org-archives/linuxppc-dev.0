Return-Path: <John.Linn@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 33BFDDDF0C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:49:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
Date: Tue, 25 Mar 2008 16:48:54 -0600
In-Reply-To: <47E7DEF1.9050501@ru.mvista.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>		<20080320144402.3063517C005D@mail148-sin.bigfish.com>		<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>		<18403.32257.725539.470771@cargo.ozlabs.ibm.com>		<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>		<47E7B61B.70708@ru.mvista.com>	<fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
	<47E7D3BB.1050403@ru.mvista.com> <47E7DEF1.9050501@ru.mvista.com>
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080325224856.E59F310C805E@mail39-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for all the input. I'd like to propose a solution hoping to
arrive at consensus.

We can define a "sparse16550" binding that uses reg-shift and reg-offset
properties in the device tree.=20

It seems like this is a common variable on the 16550 so that others
could also use it.  I like it because it specifies the differences
clearly from a normal 16550 yet is flexible enough to handle some other
variations also.

Thanks,
John

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]=20
Sent: Monday, March 24, 2008 11:04 AM
To: Sergei Shtylyov
Cc: Grant Likely; linuxppc-dev@ozlabs.org; Paul Mackerras; John Linn
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx
uart 16550.

Hi, I wrote:

>    Oh, well... unfortunately, we can't use UPIO_MEM32 "register model"

> in 8250.c anyway since that makes use of readl()/writel() -- which
treat=20
> the bus as bigendian on PPC... anyway, we would need at least a=20

    I was going to write "as little-endian"... :-<

> "reg-size" property, if not new "compatible"...

WBR, Sergei
