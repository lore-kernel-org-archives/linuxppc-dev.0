Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 186BBDDF08
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 01:34:05 +1000 (EST)
Message-ID: <4868FCE9.1060103@matrix-vision.de>
Date: Mon, 30 Jun 2008 17:34:01 +0200
From: =?ISO-8859-15?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: MPC83xx ipic problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott,

actually I'm having trouble with my PCI interrupts.
We are running 2.6.26-rc6 on a MPC8343 based board.

There are two external PCI devices connected (FPGA + miniPCI socket).
The FPGA is working fine and uses IRQ0 for its PCI_INTA line.

As soon there's a miniPCI module present and the driver loaded (actually=20
an ath5k WiFi module) the system complains after a while :

irq 48: nobody cared
handlers: .... location of the FPGA irq handler
Disabling IRQ #48

-> This is weird since the FPGA isn't working at all and IRQ0 is *not*=20
asserted !

Of course the miniPCI irq is routed to a different pin on the CPU=20
(IRQ1). Having a look at the irq count it's obvious that the WiFi irqs=20
are handled (ath module). The FPGA irq handler is located in the=20
"mvbcdma0" module which is running rock solid without miniPCI present !

mvBL-M7> cat /proc/interrupts
CPU0
16:       1826   IPIC   Level     i2c-mpc
17:          9   IPIC   Level     i2c-mpc
18:        201   IPIC   Level     ath
19:       2896   IPIC   Level     serial
21:          0   IPIC   Level     mpc83xx_spi
32:          2   IPIC   Level     enet_tx
33:        257   IPIC   Level     enet_rx
34:          0   IPIC   Level     enet_error
48:     100000   IPIC   Level     mvbcdma0
BAD:          0


The irq mapping insides the dts :

interrupt-map =3D <0x5800 0 0 1 &ipic 0x30 0x8      -> FPGA @ IRQ0
                  0x6000 0 0 1 &ipic 0x11 0x8      -> miniPCI INTA @ IRQ1
                  0x6000 0 0 2 &ipic 0x11 0x8>;    -> miniPCI INTB @ IRQ1

Is it legal to use a single irq pin twice ?
After all the ath5k doesn't use/assert the INTB line at all ...


If I do all the above after removing the FPGA module and releasing irq48=20
the system doesn't complain anymore ... but hangs after a while with the=20
IRQ1 line being unserviced.


What do you think ?
Any hints ?

Am I doing anything obviously wrong ?



regards,
Andr=E9

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
