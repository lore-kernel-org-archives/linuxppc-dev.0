Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [62.233.211.107])
	by ozlabs.org (Postfix) with ESMTP id 73D47DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 07:53:36 +1000 (EST)
Message-ID: <461FF442.8090807@semihalf.com>
Date: Fri, 13 Apr 2007 23:21:06 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: RFC: MPC52xx serial port configuration from DT blob
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

We have a MPC5200B-based board running an arch/powerpc kernel and we
need the ability to configure a non-console serial port for a particular
baud rate during system start-up. It seems that the UART driver in
drivers/serial/mpc52xx_uart.c does not support this. It only allows to
set parameters for a port that is used as a console, and for which those
parameters are passed in the kernel command line. We would like to
extend the mpc52xx_uart.c driver to be able to retrieve port options
from the DT blob and configure a given port accordingly. A new
port-specific property called "options" would be used for this. It would
have syntax following its namesake in "console" kernel parameter, as
described in Documentation/kernel-parameters.txt.

For example, the following settings in the .dts file would make UART5 to 
be configured at 115200 baud, no parity, 8 bits.

serial@2800 {           // PSC5
         device_type = "serial";
         compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
         port-number = <4>;  // Logical port assignment
         options = "115200n8"
         cell-index = <4>;
         reg = <2800 100>;
         interrupts = <2 c 0>;
         interrupt-parent = <500>;
};


In case a console port has conflicting options given in the kernel 
command line and in the DT blob, the command line values would be used.

Any comments on the above will be appreciated.


Thanks in advance,
Bartlomiej
