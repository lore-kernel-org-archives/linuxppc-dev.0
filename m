Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6B2FDE08F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:38:08 +1000 (EST)
In-Reply-To: <4868FCE9.1060103@matrix-vision.de>
References: <4868FCE9.1060103@matrix-vision.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7dd3673e01cb808007902b12a63d0399@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: MPC83xx ipic problem
Date: Mon, 30 Jun 2008 18:36:34 +0200
To: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> interrupt-map = <0x5800 0 0 1 &ipic 0x30 0x8      -> FPGA @ IRQ0
>                  0x6000 0 0 1 &ipic 0x11 0x8      -> miniPCI INTA @ 
> IRQ1
>                  0x6000 0 0 2 &ipic 0x11 0x8>;    -> miniPCI INTB @ 
> IRQ1
>
> Is it legal to use a single irq pin twice ?

The device tree simply describes the hardware; if the hardware
connects both INTXs to the same IPIC interrupt pin, then it is
correct.  You'll have to ask a hardware designer whether it is
okay to just tie the two lines together; I believe it is, for
PCI, but you better ask someone who really knows :-)


Segher
