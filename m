Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8665BDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 06:59:14 +1000 (EST)
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net
	[151.189.8.27])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 896574C308
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 22:59:07 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 7149C23D2CD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 22:59:07 +0200 (CEST)
Received: from bunny.home (dslb-088-070-073-178.pools.arcor-ip.net
	[88.70.73.178])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 30FD125D2E8
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 22:59:07 +0200 (CEST)
Received: from fox.home (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id C8C69251058E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 22:59:06 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: device tree interrupt-map/interrupt-map-mask properties for a 405EP
	board
Date: Wed, 17 Sep 2008 22:59:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809172259.05743.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to setup a device tree for a 405EP based board.
I did not fully understand how to setup the interrupt-map-mask and 
interrupt-map properties for the PCI node:

		...
		PCI0: pci@ec000000 {
			...
			interrupt-map-mask = <0x???? 0x0 0x0 0x0>;
			interrupt-map = <
				/* slot1: IDSEL AD12 - ext. Irq 4 */
				0x???? 0x0 0x0 0x0 &UIC0 29 0x8

				/* slot2: IDSEL AD13 - ext. Irq 5  */
				0x???? 0x0 0x0 0x0 &UIC0 30 0x8

				/* slot3: IDSEL AD14 - ext. Irq 6  */
				0x???? 0x0 0x0 0x0 &UIC0 31 0x8
			>;
		};

I have three PCI slots on the board. How do I have to fill out the ???? fields 
above? ADxx <-> IDSEL connection can be taken from the comments. Each slot 
has its  interrupt lines INTA..D connected to a single 405 external interrupt 
input.

Where can I find any docs about this?

Matthias
