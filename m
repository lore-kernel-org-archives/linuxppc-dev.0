Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67549B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 15:54:09 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id EE851DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 15:54:07 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	979B931BB3E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 07:43:37 +0200 (CEST)
Received: from [192.168.1.6] ([62.77.250.200])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KOA00EK3VWPD9D0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 13 Aug 2009 07:43:37 +0200 (CEST)
Date: Thu, 13 Aug 2009 07:49:42 +0200
From: Heiko Schocher <hs@denx.de>
Subject: simple gpio driver
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Message-id: <4A83A976.60608@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton,

i am trying to use the arch/powerpc/sysdev/simple_gpio.c driver,
for accessing some gpios, and found, that u8_gpio_get()
returns not only a 1 or a 0, instead it returns the real bit
position from the gpio:

gpio    return
base	value
0	0/0x01
1	0/0x02
2	0/0x04
3	0/0x08
4	0/0x10
5	0/0x20
6	0/0x40
7	0/0x80

I also use the arch/powerpc/platforms/52xx/mpc52xx_gpio.c and
mpc52xx_gpt.c drivers, they all return for a gpio just a 1 or 0,
which seems correct to me, because a gpio can have only 1 or 0
as state ... what do you think?

I solved this issue (if it is) with the following patch:

diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simple_gpio.c
index 43c4569..bb0d79c 100644
--- a/arch/powerpc/sysdev/simple_gpio.c
+++ b/arch/powerpc/sysdev/simple_gpio.c
@@ -46,7 +46,7 @@ static int u8_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);

-	return in_8(mm_gc->regs) & u8_pin2mask(gpio);
+	return (in_8(mm_gc->regs) & u8_pin2mask(gpio) ? 1 : 0);
 }

 static void u8_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
