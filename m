Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8461DDF29
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 22:33:19 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HjE1E-00050j-Pf
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 05:33:16 -0700
Message-ID: <10285090.post@talk.nabble.com>
Date: Wed, 2 May 2007 05:33:16 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: xilinx gpio in kernel 2.6
In-Reply-To: <10254948.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10254948.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Finally I was able to incorporate the xilinx_gpio driver to the kernel 2.6
tree.
To do so I have created the file xgpio_ioctl.h which is basically identical
to  
the file include/linux/ibm_ocp_gpio.h in the kernel linuxppc_2_4. The
differences are 
the macro names (I have replaced IBM with X and ibm_ with x).

I have modified also arch/ppc/syslib/virtex_devices.c. I have added into
this file the entries which refer to GPIO definitions.

At the end I have modified the drivers/char/Kconfig and the
drivers/char/xilinx_gpio/Makefile.

After all I was able to compile the kernel.

I did not find however how to deal with the GPIO driver on the user's level.
I am sure that I have to use: open and ioctl function calls but I do not
know how to distinguish between 
two differenet GPIO interfaces to control respectively (LEDs and DIP
switches).

I would appreciate very much any hint on that

Best Regards

Mierk


Mirek23 wrote:
> 
> Hi All,
> 
>            I am trying to build the kernel 2.6 for my ml403 board. I use
> the kernel 2.6 by Grant.
> The ethernet (Temac) and serial drivers work fine. It is however no
> support for xilinx gpio in the kernel tree.
> 
> To satisfy that I have generated the xilinx_gpio driver by means of the
> EDK 8.2 .
> 
> I have tried to place the xilinx_gpio to the kernel 2.6 tree under
> drivers/char/xilinx_gpio.
> 
> I have done the suitable configuration on the Makefile and Kconfig level.
> When I build the kernel, the crosscompiler complaines about the
> xgpio_ioctl.h which comes
> from the adapter.c file.
> 
> It seems to be that xgpio_ioctl.h conatins the missing macros:
> XGPIO_IN
> XGPIO_OUT
> XGPIO_TRISTATE
> XGPIO_OPEN_DRAIN
> .
> .
> .
> 
> Does sombody of you faced the same problem? 
> The second thing is that I did not find any documentation how to use GPIO
> on the user level to access things like LEDS and Swiches on my xilinx
> board. Do you have an idea how to do that (ie. which function calls to
> use).
> 
> Many thanks in advance for any hint.
> 
> Best Regards
> 
> Mirek
> 
> 
> 
> 
> 
>  
> 
> 

-- 
View this message in context: http://www.nabble.com/xilinx-gpio-in-kernel-2.6-tf3670122.html#a10285090
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
