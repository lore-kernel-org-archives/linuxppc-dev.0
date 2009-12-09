Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7428AB7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 03:28:18 +1100 (EST)
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net
	[151.189.8.13]) by mx.arcor.de (Postfix) with ESMTP id 4CAEB1B375F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:28:13 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net
	[151.189.21.54])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 4044F2BFB6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:28:13 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net
	[151.189.8.76])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 2BAE528AD71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 17:28:13 +0100 (CET)
Message-ID: <10228901.1260376093135.JavaMail.ngmail@webmail18.arcor-online.net>
Date: Wed, 9 Dec 2009 17:28:13 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Q: how to access the MPC5200B's timer gipo's?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I have a (probably dumb) question regarding the access to the MPC5200B's timer gpio's.  I added e.g.

timer@640 {	// General Purpose Timer 4
	compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
	reg = <0x640 0x10>;
	interrupts = <1 13 0>;
	interrupt-parent = <&mpc5200_pic>;
	gpio-controller;
	#gpio-cells = <2>;
};

in the DTS file to several timers.  Several gpiochipxxx folders are now present in /sys/class/gpio/.

In my code, I grab the node by calling of_find_node_by_path("/soc5200@f0000000/timer@640"), which returns the proper node.  Then I try to get the gpio number (for a call to gpio_set_value()) by calling of_get_gpio(node, 0) with the node found above.  However, this call always dumps

of_get_gpio_flags: can't parse gpios property
of_get_gpio_flags exited with status -2

What would be the proper way to determine the gpio number for a timer's gpio pin from the node name or path?

Thanks for any help,
Albrecht.

Es weihnachtet sehr! Vom leckerem Backrezept bis zum leckeren Schneehasen finden Sie alles im Weihnachtsspecial von Arcor.de:
http://www.arcor.de/rd/footer.weihnachten
Feliz Navidad, God Yul, Merry X-Mas und ein frohes Fest!
