Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 513B167DB8
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 19:47:35 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so842904ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 00:47:29 -0800 (PST)
Message-ID: <528646bc0611130047v107e7171h804c674534ef8058@mail.gmail.com>
Date: Mon, 13 Nov 2006 01:47:29 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Sylvain Munaut" <tnt@246tnt.com>, "Nicolas DET" <nd@bplan-gmbh.de>,
	"John Rigby" <jrigby@gmail.com>,
	"linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: [RFC] Draft mpc52xx device tree specification
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a rough attempt as laying out a device tree specification for
mpc52xx based boards.  I'd like to try and define what a 'sane'
mpc52xx device tree looks like before too many 52xx platforms start
showing up in arch/powerpc.

Cheers,
g.

----

MPC52xx Device Tree Bindings
----------------------------

(c) 2006 Secret Lab Technologies Ltd
Grant Likely <grant.likely at secretlab.ca>

I - Introduction
================
Boards supported by the arch/powerpc architecture require device tree be
passed by the boot loader to the kernel at boot time.  The device tree
describes what devices are present on the board and how they are
connected.  (See Documentation/powerpc/booting-without-of.txt for
details)

This document specifies the requirements on the device-tree for mpc52xx
based boards.  These requirements are above and beyond the details
specified in the booting-without-of.txt document.

All new mpc52xx-based boards are expected to match this document.  In
cases where this document is not sufficient to support a new board port,
this document should be updated as part of adding the new board support.

II - Philosophy
===============
The core of this document is naming convention.  The whole point of
defining this convention is to reduce or eliminate the number of
special cases required to support a 52xx board.  If all 52xx boards
follow the same convention, then generic 52xx support code will work
rather than coding special cases for each new board.

This section tries to capture the thought process behind why the naming
convention is what it is.

1. Node names
-------------
There is strong convention/requirements already established for children
of the root node.  'cpus' describes the processor cores, 'memory'
describes memory, and 'chosen' provides boot configuration.  Other nodes
are added to describe devices attached to the processor local bus.
Following convention already established with other system-on-chip
processors, MPC52xx boards must have an 'soc5200' node as a child of the
root node.

The soc5200 node holds child nodes for all on chip devices.  Child nodes
are typically named after the configured function.  ie. the FEC node is
named 'ethernet', and a PSC in uart mode is named 'serial'.

2. device_type property
-----------------------
similar to the node name convention above; the device_type reflects the
configured function of a device.  ie. 'serial' for a uart and 'spi' for
an spi controller.  However, while node names *should* reflect the
configured function, device_type *must* match the configured function
exactly.

3. compatible property
----------------------
Since device_type isn't enough to match devices to drivers, there also
needs to be a naming convention for the compatible property.  Compatible
is an list of device descriptions sorted from specific to generic.  For
the mpc52xx, the required format for each compatible value is
<chip>-<device>[-<mode>].  At the minimum, the list shall contain two
items; the first specifying the exact chip, and the second specifying
mpc52xx for the chip.

ie. ethernet on mpc5200b: compatible = "mpc5200b-ethernet\0mpc52xx-ethernet"

The idea here is that most drivers will match to the most generic field
in the compatible list (mpc52xx-*), but can also test the more specific
field for enabling bug fixes or extra features.

Modal devices, like PSCs, also append the configured function to the
end of the compatible field.  ie. A PSC in i2s mode would specify
"mpc52xx-psc-i2s", not "mpc52xx-i2s".  This convention is chosen to
avoid naming conflicts with non-psc devices providing the same
function.  For example, "mpc52xx-spi" and "mpc52xx-psc-spi" describe
the mpc5200 simple spi device and a PSC spi mode respectively.

If the soc device is more generic and present on other SOCs, the
compatible property can specify the more generic device type also.

ie. mscan: compatible = "mpc5200-mscan\0mpc52xx-mscan\0fsl,mscan";

At the time of writing, exact chip may be either 'mpc5200' or
'mpc5200b'.

Device drivers should always try to match as generically as possible.

III - Structure
===============
The device tree for an mpc52xx board follows the structure defined in
booting-without-of.txt with the following additional notes:

0) the root node
----------------
Typical root description node; see booting-without-of.

1) The cpus node
----------------
The cpus node follows the basic layout described in booting-without-of.
The bus-frequency property holds the XLB bus frequency
The clock-frequency property holds the core frequency

2) The memory node
------------------
Typical memory description node; see booting-without-of.

3) The soc5200 node
-------------------
This node describes the on chip SOC peripherals.  Every mpc52xx based
board will have this node, and as such there is a common naming
convention for SOC devices.

Required properties:
name			type		description
----			----		-----------
device_type		string		must be "soc"
ranges			int		should be <0 baseaddr baseaddr+10000>
reg			int		must be <baseaddr 10000>

Recommended properties:
name			type		description
----			----		-----------
compatible		string		should be "<chip>-soc\0mpc52xx-soc"
					ie. "mpc5200b-soc\0mpc52xx-soc"
#interrupt-cells	int		must be <3>.  If it is not defined
					here then it must be defined in every
					soc device node.
bus-frequency		int		IPB bus frequency in HZ.  Clock rate
					used by most of the soc devices.
					Defining it here avoids needing it
					added to every device node.

4) soc5200 child nodes
----------------------
Any on chip SOC devices available to Linux must appear as soc5200 child nodes.

Note: in the tables below, '*' matches all <chip> values.  ie.
*-pic would translate to "mpc5200-pic\0mpc52xx-pic"

Required soc5200 child nodes:
name		device_type		compatible	Description
----		-----------		----------	-----------
cdm@<addr>	cdm			*-cmd		Clock Distribution
pic@<addr>	interrupt-controller	*-pic		need an interrupt
							controller to boot
bestcomm@<addr>	dma-controller		*-bestcomm	52xx pic also requires
							the bestcomm device

Recommended soc5200 child nodes; populate as needed for your board
name		device_type	compatible	Description
----		-----------	----------	-----------
gpt@<addr>	gpt		*-gpt		General purpose timers
rtc@<addr>	rtc		*-rtc		Real time clock
mscan@<addr>	mscan		*-mscan		CAN bus controller
pci@<addr>	pci		*-pci		PCI bridge
serial@<addr>	uart		*-psc-uart	PSC in serial mode
i2s@<addr>	i2s		*-psc-i2s	PSC in i2s mode
ac97@<addr>	ac97		*-psc-ac97	PSC in ac97 mode
spi@<addr>	spi		*-psc-spi	PSC in spi mode
irda@<addr>	irda		*-psc-irda	PSC in IrDA mode
spi@<addr>	spi		*-spi		MPC52xx spi device
ethernet@<addr>	network		*-fec		MPC52xx ethernet device
ata@<addr>	ata		*-ata		IDE ATA interface
i2c@<addr>	i2c		*-i2c		I2C controller
usb@<addr>	usb-ohci-be	*-ohci,ohci-be	USB controller
xlb@<addr>	xlb		*-xlb		XLB arbritrator

IV - Extra Notes
================

1. Interrupt mapping
--------------------
The mpc52xx pic driver splits hardware IRQ numbers into two levels.  The
split reflects the layout of the PIC hardware itself, which groups
interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
Bestcomm dma engine has it's own set of interrupt sources which are
cascaded off of peripheral interrupt 0, which the driver interprets as a
fourth group, SDMA.

The interrupts property for device nodes using the mpc52xx pic consists
of three cells; <L1 L2 level>

    L1 := [CRIT=0, MAIN=1, PERP=2, SDMA=3]
    L2 := interrupt number; directly mapped from the value in the
          "ICTL PerStat, MainStat, CritStat Encoded Register"
    level := [LEVEL_HIGH=0, EDGE_RISING=1, EDGE_FALLING=2, LEVEL_LOW=3]

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
