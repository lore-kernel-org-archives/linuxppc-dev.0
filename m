Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDFFADDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 19:51:22 +1000 (EST)
Message-ID: <052501c8c0a8$5e3cc9e0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: "John Bonesio" <john.bonesio@xilinx.com>
References: <0b5701c8bf47$49219520$ad289e86@LPSC0173W>
	<20080527164222.E226818D0062@mail151-sin.bigfish.com>
Subject: Re: Still struggling with Xilinx GPIO...
Date: Wed, 28 May 2008 11:51:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John,

> Try using channel 1. It may be set up where the first channel is 1 and not 
> 0.

Not sure what you mean...

I'm actually not clear how many devices I should have:

$ grep "GPIO.*BASEADDR" 
arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
#define XPAR_GPIO_1_BASEADDR XPAR_LEDS_POSITIONS_BASEADDR
#define XPAR_GPIO_2_BASEADDR XPAR_PUSH_BUTTONS_POSITION_BASEADDR

But depending on the examples I look at, they define either:

crw-rw-rw-    1 root     root      10, 185 May 26 13:49 xgpio
or:
crw-rw-rw-    1 root     root      10, 185 May 26 13:18 xgpio0
crw-rw-rw-    1 root     root      10, 186 May 26 13:18 xgpio1
crw-rw-rw-    1 root     root      10, 187 May 26 13:18 xgpio2

If that is the former, I see the code uses:
 gpio_ioctl.chan=0;
And I guess that's what you are refering to, right ?

Putting 1 gives me a working program, but no LED lights up and the buttons 
are always shown at 0.
Putting 0 gives a nice core dump as in my previous msg.
Putting 2 locks up the system.

And... I don't see how the code manages to read/wite all 3 GPIOs with only 
two IOCTL calls. Shouldn't they be 3 different calls using different 
addresses ?!? Argh, this complete lack of documentation in maddening. Not 
everything can be understood from reading the source.

Thanks.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
