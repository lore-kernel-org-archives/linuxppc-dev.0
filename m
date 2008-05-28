Return-Path: <john.bonesio@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0C3DEDDF57
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 02:09:41 +1000 (EST)
Subject: Re: Still struggling with Xilinx GPIO...
From: John Bonesio <john.bonesio@xilinx.com>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <052501c8c0a8$5e3cc9e0$ad289e86@LPSC0173W>
References: <0b5701c8bf47$49219520$ad289e86@LPSC0173W>
	<20080527164222.E226818D0062@mail151-sin.bigfish.com>
	<052501c8c0a8$5e3cc9e0$ad289e86@LPSC0173W>
Content-Type: text/plain
Date: Wed, 28 May 2008 09:09:34 -0700
Mime-Version: 1.0
Message-Id: <20080528160936.B0BCE1A48079@mail63-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Guillaume,

gpio_ioctl.chan = x;

That's what determines which gpio device gets used. Since using 1 at
least doesn't give you a core dump, I would guess that 1 is the correct
value to use there.

So the next thing to check is to make sure that the ioctl command codes
being used are right.

The only way I know how to do this is to look in the linux kernel source
for the gpio device. Try looking here:
    linux/drivers/char/xilinx_gpio

Then you find the routine that is handling the ioctl commands. It'll
probably be called xgpio_ioctl. In this routine you'll see something
like:
    switch(cmd) {
    case XGPIO_IN:
        ...

The value for XGPIO_IN is defined in a header file (probably). The
header file might be called xgpio_ioctl.h.

So here's the key:
    Make sure the value for XGPIO_IN used in the user application is the
same as the one used in the kernel.

At one point I had see a case where the values in the kernel had
changed, but the user application was still trying to use the old
values.

Hope this helps,

- John



On Wed, 2008-05-28 at 11:51 +0200, Guillaume Dargaud wrote:
> Hi John,
> 
> > Try using channel 1. It may be set up where the first channel is 1 and not 
> > 0.
> 
> Not sure what you mean...
> 
> I'm actually not clear how many devices I should have:
> 
> $ grep "GPIO.*BASEADDR" 
> arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
> #define XPAR_GPIO_0_BASEADDR XPAR_LEDS_4BIT_BASEADDR
> #define XPAR_GPIO_1_BASEADDR XPAR_LEDS_POSITIONS_BASEADDR
> #define XPAR_GPIO_2_BASEADDR XPAR_PUSH_BUTTONS_POSITION_BASEADDR
> 
> But depending on the examples I look at, they define either:
> 
> crw-rw-rw-    1 root     root      10, 185 May 26 13:49 xgpio
> or:
> crw-rw-rw-    1 root     root      10, 185 May 26 13:18 xgpio0
> crw-rw-rw-    1 root     root      10, 186 May 26 13:18 xgpio1
> crw-rw-rw-    1 root     root      10, 187 May 26 13:18 xgpio2
> 
> If that is the former, I see the code uses:
>  gpio_ioctl.chan=0;
> And I guess that's what you are refering to, right ?
> 
> Putting 1 gives me a working program, but no LED lights up and the buttons 
> are always shown at 0.
> Putting 0 gives a nice core dump as in my previous msg.
> Putting 2 locks up the system.
> 
> And... I don't see how the code manages to read/wite all 3 GPIOs with only 
> two IOCTL calls. Shouldn't they be 3 different calls using different 
> addresses ?!? Argh, this complete lack of documentation in maddening. Not 
> everything can be understood from reading the source.
> 
> Thanks.

________________________________________________________________________

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
