Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3AC7B6FB6
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 05:25:56 +1000 (EST)
Message-ID: <4FD25146.5090108@freescale.com>
Date: Fri, 8 Jun 2012 14:23:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: P2010 External HW IRQ number?
References: <OF71CEA252.1CE143D5-ONC1257A17.00329573-C1257A17.003D00D0@transmode.se>
In-Reply-To: <OF71CEA252.1CE143D5-ONC1257A17.00329573-C1257A17.003D00D0@transmode.se>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2012 06:06 AM, Joakim Tjernlund wrote:
> 
> I have been trying to figure out what irq number to use for external IRQs for
> the P2010. There are no HW IRQ numbers in the ref manual and I cannot find
> any examples in the kernel either.
> How do specify irq numbers in my dts for external IRQs?

See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt

For external interrupts, the first cell is equal to the IRQ number.

For an example of specifying an external IRQ, see the RTC and PHY nodes
in various mpc85xx device trees (e.g. mpc8536ds.dtsi).

> What do I use with request_irq(?,....)?

You need a virtual IRQ number.  Typically this comes from
irq_of_parse_and_map().

-Scott
