Return-Path: <Tiejun.Chen@windriver.com>
Message-ID: <4CD36B01.3060602@windriver.com>
Date: Fri, 05 Nov 2010 10:25:05 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Cajus Pollmeier <cajus@naasa.net>
Subject: Re: Debugging kernel on mpc7448
References: <1288796616.3609.50.camel@frost>
In-Reply-To: <1288796616.3609.50.camel@frost>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cajus Pollmeier wrote:
> Hello there,
> 
> I'm currently trying to get a kernel upgrade from 2.6.11 to 2.6.31
> working with u-boot/cuImage.c2k on a custom marvell discovery 3 board.

Are you sure if all device nodes information of c2k.dts are matched your actual
board hardware? If no I think you have to add some fixup() to correct those
'incorrect' device on the file, cuboot-c2k.c.

> In the moment, the following steps work:
> 
> * u-boot (1.1.4, not changeable in the moment) runs from flash and
> offers a prompt
> * loading cuImage.c2k
> * running the code of wrapper.c until calling vmlinux.addr

Did you see those message with uncompressing zImage? Maybe its convenient to
help you for other guys if you can attach all boot log.

> * entering __start in head_32.S and running until early_init gets called
> 
> The systems then hangs until the watchdog resets the board. In this

Often the watchdog should be invoked when its associated driver initialization.
So I wonder when the watchdog live.

> early stage, I've no output to the serial console - which is the only
> way to see what's going on there without having a development board with
> single step capabilities.
> 
> To track it until early_init, I tried to place a stupid "blr" in
> head_32.S, in order to get back to wrapper.c - which writes out a
> message to the serial console in case the kernel "accidently" gets back
> to it.

Firstly I think you can lighten one LED to mask a flag for single step if there
is one LED existed on your target :) That's a ugly way but also make the life
easy sometimes.

And actually bootloader already initial UART so you can write some simple thing
directly into that corresponding UART data register to hint where the kernel
run. Note you can get this UART base address from bootloader, or the cuboot
early stage.

Tiejun

> 
>>From now on, I'm not sure if early_init is properly called. The blr
> after the call is either not reached or there's something going on which
> is beyond my limited knowledge of ppc assembler. Maybe u-boot gets
> overwritten, but the blr isn't even reached if I change early_init by
> just returning 0U immediately. Hmm.
> 
> Any pointers to help debugging would be really appreciated ;-)
> 
> Cheers,
> Cajus 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
