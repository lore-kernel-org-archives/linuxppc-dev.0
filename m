Message-ID: <39BF6F59.B3CAAB31@vas-gmbh.de>
Date: Wed, 13 Sep 2000 14:13:13 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: Erik Kunze <Erik.Kunze@philosys.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Access PCMCIA control registers
References: <20000913101622.J10108@philos.philosys.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Erik,

> I'm running Linux 2.2.13 on a MPC860L based PPC-board from TQ-Systems
> (http://www.tqc.de/HTM_Files/TQM8xx_Serie.htm).

I assume, you are using a STK8xxL? I only gathered some experiences with a
STK8xxL.300. I think TQM changed a lot with the PCMCIA slot. So your board
revision should be important to know.

>
> I must access the PCMCIA control space within the internal memorty map.
> The values I read from are not valid according to the docs and it doesn't
> recognise any write access.
>
> I've put a trace in the m8xx_setup.c and it always shows the following
> values (bits):
>

> Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PIPR  1111 1111 0000 0000 1111 1111 0000 00000
> Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PSCR  1111 1100 0111 0000 0000 0000 0100 00000
> Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PER   0000 0000 0000 0000 0001 1000 0000 00000
> Sep  1 15:16:51 193 kernel: m8xx_pcmcia: PGCRA 0000 0000 0000 0000 0000 0000 0000 00000

PIPR = 0xff00ff00 =
(CAVS1|CAVS2|CAWP|CACD2|CACD1|CABVD2|CABVD1|CARDY|CBVS1|CBVS2|CBWP|CBCD2|CBCD1|CBBVD2|CBBVD1|CBRDY)

means no card detected on neither slot (is this a wrong double negation? ;-),
but this might be the case with card inserted but no power on the slot:

>
> How do I switch power on the PCMCIA-Slot.
>

On STK8xxL.300 a MIC2562A-1 is used for power control of the PCMCIA slot.
If you don't have a 'STK8xxL HWM Rev 004.pdf' ask them to send one to you. It
includes the schematics of the STK.
In addition to the standard MPC PCMCIA lines, there are the following
connections:
PC14 -> VCC5EN
PC13 -> VCC3EN
PB22 <- FLAG#	 power error
PB23 <- PCINPACK
The MIC2562A-1 uses inverted values on VCC5EN and VCC3EN, so e.g. 0 on PC14
enables VCC5.

Because the STK uses slot B, you have to setup SIUMCR to proper values,
especially SIUMCR[DBGC=0x0] needs to be configured (I use a value of 0x01012440,
but you may need to adapt it for your board), for proper operation of the
IP_B[0-1] pins. Otherwise you will not be able to detect inserted cards properly
(VS1,VS2).

To power up the card with e.g. 5V use MPC port C
pcdir = 0x0006 # PC13 and PC14 as output
pcdat = 0x0004 # set PC13 to 1 and PC14 to 0 for 5V, see above

with inserted card you should now get some feedback in pipr:
PIPR = 0xff004700 =
(CAVS1|CAVS2|CAWP|CACD2|CACD1|CABVD2|CABVD1|CARDY|CBVS2|CBBVD2|CBBVD1|CBRDY)

Then have a look into 860UM for proper values for PCMCIA card setup, e.g.:
por0 = 0xc0024455 = (BSIZE=0x18|PSHT=0x2|PSST=0x4|PSL=0x8|PPS|PRS=0x2|PSLOT|PV)
pbr0 = 0xe0000000
This is for attribute mem access starting at 0xe0000000, 64KByte space, 16 bit
wide,
slot b, valid and three timing parameters (see p.517 for PORx description).

hth
  Frank

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
