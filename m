Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s15.bay0.hotmail.com (bay0-omc2-s15.bay0.hotmail.com
	[65.54.246.151]) by ozlabs.org (Postfix) with ESMTP id 12BE1DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 18:52:03 +1000 (EST)
Message-ID: <BLU106-W36C0A416656182C69E06ACABF0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: DMA Generic Task
Date: Mon, 17 Sep 2007 10:39:58 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,
I=B4m developing an small module to use the DMA API to copy some audio data=
 in a PSC wich has attached an digital to analog converter. It is only a pr=
oof of concept before I can use this information to develop an audio driver=
 for the SPI interface.=20
I=B4m using a 2.6.20 kernel patched with the bestcomm patches from http://w=
ww.246tnt.com/mpc52xx/dev_full/ at Sylvain's page.=20
My board is also a pcm030. I had the same problems with the Ethernet so I d=
ecided to keep the old fec driver with the old bestcomm driver also just fo=
r the Ethernet stuff until I could take a look over it.
I took a look into the code for the bestcomm API for the generic tasks and =
thought that this was the way to initialize the bestcomm task:

        struct bcom_task *tx_bcom;  =20
        struct bcom_task *rx_bcom;
=09
        switch(psc_num) {
		case 1:
			initiator_tx =3D SDMA_INITIATOR_PSC1_TX;
			initiator_rx =3D SDMA_INITIATOR_PSC1_RX;
			break;
		case 2:
			initiator_tx =3D SDMA_INITIATOR_PSC2_TX;
			initiator_rx =3D SDMA_INITIATOR_PSC2_RX;
			break;
		default:
			panic("snd-SPImgt.o: invalid value for psc_num (%i)\n",psc_num);
			break;
	};

	tx_bcom =3D bcom_gen_bd_tx_init(512, MPC52xx_PA(MPC52xx_PSCx_OFFSET(psc_nu=
m))+0x80, initiator_tx, 6);   //(1)

	rx_bcom =3D bcom_gen_bd_rx_init(512, MPC52xx_PA(MPC52xx_PSCx_OFFSET(psc_nu=
m))+0x60, initiator_rx, 6, 1024);


where MPC52xx_PA(MPC52xx_PSCx_OFFSET(psc_num)) =3D 0xf0002000, wich added t=
o 0x80 or 0x60 gives TXFIFO or RXFIFO's physical address.
However, when I insert the module, it crashes at (1) Line (bcom_gen_bd_tx_i=
nit...) with this output:

root@MPC5200B:~ insmod SPIspeaker
Inserting SPIspeaker module
Unable to handle kernel paging request for data at address 0x0000000c
Faulting instruction address: 0xc001525c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: SPIspeaker eeprom
NIP: C001525C LR: C0016458 CTR: 00000010
REGS: c3e7bd80 TRAP: 0300   Not tainted  (2.6.20)
MSR: 00009032   CR: 24008222  XER: 00000000
DAR: 0000000C, DSISR: 20000000
TASK =3D c3f2c7b0[447] 'insmod' THREAD: c3e7a000
GPR00: 00000010 C3E7BE30 C3F2C7B0 00000200 00000008 00000010 00000006 00004=
000
GPR08: C3E7A000 00000000 00000000 C0016430 24008222 1008B4E8 00000000 00000=
000
GPR16: 00000012 00000011 C5068C74 C3FD08C0 00000000 00000056 C024408C 00000=
000
GPR24: C01E28DC 00000008 C0260000 00000200 0000000E 00000010 00000006 C0244=
338
Call Trace:
[C3E7BE30] [C5060000]  (unreliable)
[C3E7BE60] [C0016458]
[C3E7BE80] [C506026C]
[C3E7BEA0] [C003F804]
[C3E7BF40] [C000F5C8]
--- Exception: c01Instruction dump:
7c7b1b78 90010034 7c992378 7cbd2b78 8128000c 39290001 9128000c 3f40c026
38000010 813a01a8 7c0903a6 39400000  7d695b78 396b0004 800b0000
 note: insmod[447] exited with preempt_count 1
BUG: scheduling while atomic: insmod/0x10000001/447
Call Trace:
[C3E7BB80] [C00081E0]  (unreliable)
[C3E7BBB0] [C01DDCB0]
[C3E7BC00] [C0017CD8]
[C3E7BC10] [C01DE924]
[C3E7BC20] [C00520C0]
[C3E7BCA0] [C0055B0C]
[C3E7BCD0] [C001A764]
[C3E7BCE0] [C001E8A0]
[C3E7BD00] [C0020428]
[C3E7BD40] [C000DB84]
[C3E7BD60] [C0011084]
[C3E7BD70] [C000FA64]
--- Exception: 300[C3E7BE30] [C5060000]  (unreliable)
[C3E7BE60] [C0016458]
[C3E7BE80] [C506026C]
[C3E7BEA0] [C003F804]
[C3E7BF40] [C000F5C8]
--- Exception: c01Segmentation fault

How should I use the API to initialize the Bestcomm task?


Regards,
Pedro Dominguez

_________________________________________________________________
Prueba algunos de los nuevos servicios en l=EDnea que te ofrece Windows Liv=
e Ideas: tan nuevos que ni siquiera se han publicado oficialmente todav=EDa=
.
http://ideas.live.com=
