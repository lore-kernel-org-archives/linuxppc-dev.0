Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id D5184DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 01:58:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How to set external interrupts falling edge sensitive
Date: Thu, 26 Feb 2009 15:46:39 +0100
Message-ID: <29DC34A6B43468409F5A371CFE34E849B36259@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using the mpc8313erdb. I got two external interrupt sources which
are
handled by two UIO drivers.=20
These interrupts shall be triggered on falling edge.=20

Therefore I just added (Kernel version 2.6.24) in
arch/powerpc/sysdev/ipic.c in function ipic_set_irq_type
at line ~484 "flow_type =3D IRQ_TYPE_EDGE_FALLING;"

	/* only EXT IRQ senses are programmable on ipic
	 * internal IRQ senses are LEVEL_LOW
	 */
	flow_type =3D IRQ_TYPE_EDGE_FALLING;   // <---- added this line
	if (src =3D=3D IPIC_IRQ_EXT0)
		edibit =3D 15;
	else
		if (src >=3D IPIC_IRQ_EXT1 && src <=3D IPIC_IRQ_EXT7)
			edibit =3D (14 - (src - IPIC_IRQ_EXT1));
		else
			return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 :
-EINVAL;


and it seemed to work for me.

But when I'm adding this line in Kernel version 2.6.28.7
I'll get these messages on startup:

setting trigger mode 8 for irq 38 failed (0xc0017160)
setting trigger mode 8 for irq 37 failed (0xc0017160)
setting trigger mode 8 for irq 36 failed (0xc0017160)
setting trigger mode 8 for irq 35 failed (0xc0017160)
setting trigger mode 8 for irq 34 failed (0xc0017160)
setting trigger mode 8 for irq 33 failed (0xc0017160)
setting trigger mode 8 for irq 32 failed (0xc0017160)
...


It seems to me, that this is not the right place to configure the
external interrupts as "falling edge"


I guess that the dtb file might be the right place, please correct me if
I'm wrong. But I have no idea
how to add those both external interrupt sources into the dts file.

Any hints are appreciated! Thanks

regards
Frank
