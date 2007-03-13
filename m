Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EADD8DDDE5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 00:52:23 +1100 (EST)
Subject: RE: [PATCH] Add irq host and hwirq pair fields to output
	whenshowing interrupts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C131E7F@zch01exm26.fsl.freescale.net>
References: <1173755968459-git-send-email-wei.zhang@freescale.com>
	<1173770092.24454.69.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C131E7F@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 14:52:06 +0100
Message-Id: <1173793926.24454.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Now, regarding the patch itself, printing the hw irq is not 
> > that useful
> > without some indication of which host it belongs to. Best is to add a
> > name() or something like that to the host ops.
> > 
> 
> Sure, can I use the PIC controller node full name from of_tree as the
> host name?

There is no 1:1 relationship between an OF node and an irq host. (There
is -most- of the time but I left the irq core on purpose more flexible,
hence the match() method. On some setups it makes sense to have multiple
HW PICs share a single domain number (for example on cell).

Thus I'd rather have a way for the host to give you that name, which in
turn can be the OF path if there is such a thing, or something else...

Best might be 4 columns:

<virq> <hwirq> <pic name> <host name>

(PIC name is the same as in /proc/interrupts).
 
> Do you prefer debugfs instead of /proc/interrupts?

Yes, at least for now. Maybe if we can convince ourselves that nothing
significant would break of changing /proc/interrupts, then we can add
stuffs to it, but I'd rather avoid.

Ben.
