Return-Path: <tnt@246tNt.com>
Received: from outmx037.isp.belgacom.be (outmx037.isp.belgacom.be
	[195.238.6.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEBC0DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 16:08:07 +1000 (EST)
Received: from outmx037.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx037.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l3H681n0002404
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 Apr 2007 08:08:02 +0200
Message-ID: <46246420.8050800@246tNt.com>
Date: Tue, 17 Apr 2007 08:07:28 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: RFC: MPC52xx serial port configuration from DT blob
References: <461FF442.8090807@semihalf.com>
In-Reply-To: <461FF442.8090807@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka wrote:
> Hi All,
>
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
>   
The kernel only "use" the serial for console. If it's not a console,
then it's used
by userspace and it's userspace job to configure it as it sees fit imho ...


Sylvain
