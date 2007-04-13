Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id F41C8DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 09:31:05 +1000 (EST)
Date: 13 Apr 2007 16:24:22 -0700
Message-ID: <20070413232422.11827.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: tur@semihalf.com, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: MPC52xx serial port configuration from DT blob
In-Reply-To: <461FF442.8090807@semihalf.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bartlomiej wrote:
> We have a MPC5200B-based board running an arch/powerpc kernel and we
> need the ability to configure a non-console serial port for a particular
> baud rate during system start-up. It seems that the UART driver in
> drivers/serial/mpc52xx_uart.c does not support this. It only allows to
> set parameters for a port that is used as a console, and for which those
> parameters are passed in the kernel command line. We would like to
> extend the mpc52xx_uart.c driver to be able to retrieve port options
> from the DT blob and configure a given port accordingly. A new
> port-specific property called "options" would be used for this. It would
> have syntax following its namesake in "console" kernel parameter, as
> described in Documentation/kernel-parameters.txt.
> 
> For example, the following settings in the .dts file would make UART5 to 
> be configured at 115200 baud, no parity, 8 bits.
> 
> serial@2800 {           // PSC5
>          device_type = "serial";
>          compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
>          port-number = <4>;  // Logical port assignment
>          options = "115200n8"
>          cell-index = <4>;
>          reg = <2800 100>;
>          interrupts = <2 c 0>;
>          interrupt-parent = <500>;
> };
> 
> 
> In case a console port has conflicting options given in the kernel 
> command line and in the DT blob, the command line values would be used.
> 
> Any comments on the above will be appreciated.

The device tree is intended to be an OS-independent description of the
state of the platform hardware as left by firmware (or bootwrapper).
It is not intended to contain kernel configuration parameters or options,
though there are a few exceptions.

So, this kind of change is unlikely to be accepted.

-Dale
