Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFA3A67BAC
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 06:46:23 +1100 (EST)
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jey7pfvfw8.fsf@sykes.suse.de>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
	<1165737970.1103.171.camel@localhost.localdomain>
	<jey7pfvfw8.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 06:46:14 +1100
Message-Id: <1165779974.1103.181.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Bisection has identified this patch:
> 
> commit f90bb153b1493719d18b4529a46ebfe43220ea6c
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Sat Nov 11 17:24:51 2006 +1100
> 
>     [POWERPC] Make pci_read_irq_line the default

Thanks Andreas ! I was expecting something around that patch indeed, I
suspect something in Apple device-tree is dodgy and breaking the
new generic PCI irq parsing (for example, at first sight, it's a PCI
device with 2 interrupts, which isn't allowed by the PCI spec).

I'll dig a bit more when I get to the office where my crash box is, and
will do a fix.

Ben.
