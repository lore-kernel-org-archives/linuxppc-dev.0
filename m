Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 35764DDF6B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 17:45:42 +1000 (EST)
Message-ID: <4869E09E.5000108@matrix-vision.de>
Date: Tue, 01 Jul 2008 09:45:34 +0200
From: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC83xx ipic problem
References: <4868FCE9.1060103@matrix-vision.de>
	<48692E18.9050500@freescale.com>
In-Reply-To: <48692E18.9050500@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

thanks for your reply.

Honestly I don't think the board wiring is incorrect.
FPGA goes to IRQ0 and miniPCI is wired to IRQ1.

Maybe there's a crosstalk problem since the pull-up resistors are=20
packaged inside an array ... I'll check this.


regards,
Andr=C3=A9


Scott Wood schrieb:
> Andr=C3=A9 Schwarz wrote:
>> There are two external PCI devices connected (FPGA + miniPCI socket).
>> The FPGA is working fine and uses IRQ0 for its PCI_INTA line.
>>
>> As soon there's a miniPCI module present and the driver loaded=20
>> (actually an ath5k WiFi module) the system complains after a while :
>>
>> irq 48: nobody cared
>> handlers: .... location of the FPGA irq handler
>> Disabling IRQ #48
>>
>> -> This is weird since the FPGA isn't working at all and IRQ0 is *not*=
=20
>> asserted !
>=20
> Are you *sure* that IRQ0 isn't asserted?  The IPIC seems to think it is=
.
>=20
>> Of course the miniPCI irq is routed to a different pin on the CPU (IRQ=
1).
>=20
> Perhaps the board wiring is incorrect?
>=20
>> interrupt-map =3D <0x5800 0 0 1 &ipic 0x30 0x8      -> FPGA @ IRQ0
>>                  0x6000 0 0 1 &ipic 0x11 0x8      -> miniPCI INTA @ IR=
Q1
>>                  0x6000 0 0 2 &ipic 0x11 0x8>;    -> miniPCI INTB @ IR=
Q1
>>
>> Is it legal to use a single irq pin twice ?
>=20
> Yes.
>=20
> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
