Return-Path: <Marc.Dietrich@ap.physik.uni-giessen.de>
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de
	[134.176.2.3]) by ozlabs.org (Postfix) with ESMTP id 417EE2BF07
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Dec 2004 08:38:45 +1100 (EST)
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: Christian <evilninja@gmx.net>
Date: Mon, 27 Dec 2004 22:37:57 +0100
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net>
In-Reply-To: <41CF77A9.9040405@gmx.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1CI0BXJKw/25mkJ"
Message-Id: <200412272237.57241.marc.dietrich@ap.physik.uni-giessen.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-00=_1CI0BXJKw/25mkJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hallo Christian,

Am Montag, 27. Dezember 2004 03:47 schrieben Sie:
> Marc Dietrich schrieb:
>
> > I also tried to change the irq routings in prep_pci.c like in the latest
> > patch with the sym53c8xx_2 driver,
> > 	Slot 12 -> IRQ 15 (sym53c825)
> > 	Slot 15 -> IRQ 11 (dec 21140)
> > but this didn't helped.
>
> i'm still working these out too, gotta find some time...

maybe this helps:

I used the config file you sent me (and added serial console).

when booting a working 2.4.24-pre1 I get:

[...]
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: moved device 00:0b.1 resource 4 (101) to 1480
PCI: moved device 00:0b.1 resource 5 (101) to 1490
PCI: moved device 00:11.0 resource 0 (1208) to 0
[...]
SCSI subsystem driver Revision: 1.00
new devtbl    [4096] @c049e000.
PCI: Enabling device 00:0c.0 (0000 -> 0003)
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: changing PCI_LATENCY_TIMER from 0 to 80.
sym53c8xx: 53c825a detected
sym53c825a-0: rev 0x13 on pci bus 0 device 12 function 0 irq 15
new MPOOL     [ 188] @c049f000.
new VTOB      [  12] @c049f100.
new NCB       [2408] @c049c000.
new SQUEUE    [2336] @c049d000.
new VTOB      [  12] @c049f110.
new DQUEUE    [2336] @c049a000.
new TARGTBL   [ 256] @c049b000.
new VTOB      [  12] @c049f120.
new SCRIPT    [3504] @c0498000.
new SCRIPTH   [1504] @c049b800.
new CCB       [1300] @c0499000.
sym53c825a-0: ID 7, Fast-10, Parity Checking


while booting a non working 2.6.10 I get:

I already changed the irq of slot 12 to 15 and slot 14 to irq 11.

[...]
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: Cannot allocate resource region 5 of device 0000:00:01.1
SCSI subsystem initialized
[...]
PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
sym0: <825a> rev 0x13 at pci 0000:00:02.0 irq 15
new MPOOL     [ 180] @c7d99000.
new VTOB      [  12] @c7d99100.
new HCB       [1784] @c7d9a000.
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
new VTOB      [  12] @c7d99110.
new SQUEUE    [3600] @c7d9b000.
new VTOB      [  12] @c7d99120.
new DQUEUE    [3600] @c7d9c000.
new TARGTBL   [ 256] @c7d9a800.
new VTOB      [  12] @c7d99130.
new SCRIPTA0  [3024] @c7d9d000.
new VTOB      [  12] @c7d99140.
new SCRIPTB0  [1324] @c7d9e000.
new SCRIPTZ0  [  32] @c7d9a900.
new CCBH      [1024] @c7d99400.
new CCB       [ 988] @c7d9ac00.
new SNS_BBUF  [  32] @c7d9a920.
[...]
new BADLUNTBL [ 256] @c7d9aa00.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18m
elevator: using anticipatory as default io scheduler
sym0:0:0:ccb @c7d9ac00 using tag 256.
sym0: queuepos=2.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: DEVICE RESET operation started.
sym0:0:0: DEVICE RESET operation timed-out.
sym0:0:0: BUS RESET operation started.
sym0:0:0: BUS RESET operation timed-out.
sym0:0:0: HOST RESET operation started.
sym0:0:0:ccb @c7d9ac00 freeing tag 256.
sym0: SCSI BUS has been reset.
[ hangs here ]



Indeed, there seems to be something wrong with the pci resources - but I can't 
say what. I attached the compete boot logs. I also attached the lspci -v 
output.

Greetings

Marc

--Boundary-00=_1CI0BXJKw/25mkJ
Content-Type: application/x-bzip2;
  name="boot.log-2.4.24-pre1.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="boot.log-2.4.24-pre1.bz2"

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

--Boundary-00=_1CI0BXJKw/25mkJ
Content-Type: application/x-bzip2;
  name="boot.log-2.6.10.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="boot.log-2.6.10.bz2"

QlpoOTFBWSZTWRiNw8gAArnfgHgQXG//+3/v/xq/7//wUAR9eh7TzdayDbPTtDQImhCbVPGhMptT
PSGJmVP0o0DNTQeptTzVADRNBMTU8Uj1AaAAAAAaAAAA0BEmnqJvUj1GgANAaDRkBoMgAAMUUniT
bSnqP0p+qbRNAAA0ZMhpoGTQ2oAJIgITISeINTT0IZNNB6QBpoD1BoGROBESKP6E1SL3eDZIN8fW
MNKIiRPogTU2QkTIEjUPXpIUmE8SJ9MSDyjSQ+bB90oUdrosemIa89jAbOYgyQfLzdR794iN9SlL
B3o456OXmjZ/jYC+wyInYx0DntUktJaVE4nlbRY+8JE39s5pAmEiF1GQnLrMLklS/d1iE14URxDu
uHRFJK6XjbEXUA2lYseHAFzQK0LHzM2yaFWQi59MB+sN0LP0AebAXb+shiJi3Qd/t2eqgiLoqPKb
zdljb6Ljas889W+V2o4c8kd2RekkQRAAaDNlMzM9F9pgFRX1/yAS+t+rJ01o2zumFtneymBnazED
mRUGBPCEeUFYyrsbzBPRKnm0U+VmRW4+EwGMDJfMhjJJalEdJ0DApUUo+XFnNTxtNcMsbVG5FFEg
k1LIyCydM9hrL1oIpWLs2IObOqGQMQqZnomFkYYC0osBIwqkIrRXvRZBV5r3mTRZFEVc8LAMzuo5
olBFhqC04BtRB4UYUuaJB2MRAQdbfc1YkIvWyZwk9oI4KkN2UsgitMC1+FuPiYcbntDyMMwzHByN
PmIgjPxX+ParMwfjymLNmcKHEQDvxtUQ5LxIcB7lri/bmFIjcBwd9jUZAdhCsTziOVbW0f4VKZEO
6IHSTdv7O+BkoYrB2VCV52EcRfgLUvZzQhnG8gSpB8YCrQ0ClCqsTtnRZCmVVwNmUO/RGDe1FU5T
+yJX4ODN2qNuUxohWZ8DP9DA4SOEaEMXIgg5GLFRD1Ds7yG0VoD6WDCfsh1+zu2mBWxDbSxd5NG5
C8j/jjlPxzqN/A/OACBjIWVTS/IitxnVZIyzgZfZnAh/ouDUiqR60g+fRBrCh07DcL7lXdCJC/qk
h9LIZksexIKyvTUYstD7wV2t7gkajIMGkHx9veHyzeG5A1Q9zNY9vWxOatCYR2FHC+5Y2pWTfCZu
78doMd1cNTFzRDUlGK73zOyETvuGkLV3CttzHRmQGrNv7QRcZBmhXFMJ3IkzJb6wZD6LJsyb4UDQ
DKhJgDhda9al2SRdvgY5jwEyZtIjoLqsK1eK2EfsGvZStwOmLAMN8FiI8IDnvmg9zDVcjkkeNxBc
MQ03SpyuXQBxgG9TQpFsyfeQEEKPys25rCylB0P62C2DZDNZku0qJU42QaOTnkWXG5luS5Tg1hyz
tCtaMg7Fpvf0mHfFpQDCWU2SmsKRCQAYwCkNL5Bod1DaCRuwVpLPAJBZtsVYaCaIMwYvtUNcSaIY
KwpnU7aSoHBQH7gJtOitX0Ua64xKNCliHGO5aALkAp5kcgHWIJIVHvBBhCzBCXCIvDf6vXjgSusI
TFGZ2gpdWKFYMQIEddUcYzcjtdB64WMVAJeB51n/i7kinChIDEbh5AA=

--Boundary-00=_1CI0BXJKw/25mkJ
Content-Type: text/plain;
  charset="iso-8859-15";
  name="lspci-v"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-v"

00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Flags: bus master, medium devsel, latency 0

00:0b.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Flags: medium devsel
	I/O ports at 01f0 [disabled] [size=8]
	I/O ports at 03f4 [disabled] [size=4]
	I/O ports at 0170 [disabled] [size=8]
	I/O ports at 0374 [disabled] [size=4]
	I/O ports at 1480 [disabled] [size=16]
	I/O ports at 1490 [disabled] [size=16]

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
	Flags: bus master, medium devsel, latency 80, IRQ 15
	I/O ports at 1000 [size=256]
	Memory at c200c000 (32-bit, non-prefetchable) [size=256]
	Memory at c200d000 (32-bit, non-prefetchable) [size=4K]

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1400 [size=128]
	Memory at c200e000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at c1040000 [disabled] [size=256K]

00:11.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
	Flags: medium devsel, IRQ 11
	Memory at c0000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at c2000000 [disabled] [size=32K]

00:12.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Flags: 66Mhz, medium devsel, IRQ 15
	Memory at c2008000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <available only to root>

00:12.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Flags: 66Mhz, medium devsel, IRQ 15
	Memory at c2009000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <available only to root>

00:12.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: ALi Corporation USB 1.1 Controller
	Flags: 66Mhz, medium devsel, IRQ 15
	Memory at c200a000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <available only to root>

00:12.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: ALi Corporation USB 2.0 Controller
	Flags: 66Mhz, medium devsel, IRQ 15
	Memory at c200b000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: <available only to root>


--Boundary-00=_1CI0BXJKw/25mkJ--
