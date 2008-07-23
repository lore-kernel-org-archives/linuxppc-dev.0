Return-Path: <richard.whitlo@btconnect.com>
Received: from c2bthomr10.btconnect.com (c2bthomr10.btconnect.com
	[213.123.20.128]) by ozlabs.org (Postfix) with ESMTP id EC954DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 00:59:46 +1000 (EST)
Message-ID: <4887471E.6070306@btconnect.com>
Date: Wed, 23 Jul 2008 15:58:38 +0100
From: Richard Whitlock <richard.whitlo@btconnect.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: DTS configuration of external interrupts on 8347
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: richw@netcomuk.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a small problem with a port of linux 2.6.26 to a custom board.
Our board is almost identical to the Analogue & Micro asp 8347 board, so 
I'm using Kumar Gala's excellent fsl tree (thank you Kumar) as it 
already has a defconfig for the asp.
Thanks also to Bryan O'Donoghue for pointing us in the direction of the 
asp port in the first place.

The problem we have is I am unable to request an external interrupt. We 
have an FPGA which has an interrupt line - HW IRQ_0, so thats linux IRQ 48.
I have added the following to the dts file:

fpgaKFAF@0xF8000000 {
                interrupts = <48 8>;
                interrupt-parent = <&ipic>;
}

but whenever I call request_irq() it returns -ENOSYS.

The driver loads fine, and the open function does very little - a call 
to ioremap() - which works, and a call to request_irq() which does not.
Is there anything else I have to do to configure this interrupt?

Regards,

Richard.
