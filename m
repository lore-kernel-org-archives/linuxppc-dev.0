Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (mail.biologigrand.se [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id 0441767A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 00:37:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id A89136939D1 for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 16:37:44 +0200 (CEST)
Received: from 220a.licentiaten.umea.hsb.se (220a.licentiaten.umea.hsb.se
	[212.32.155.230])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id E46CB6939CC for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 16:37:43 +0200 (CEST)
Date: Wed, 6 Apr 2005 16:38:06 +0200 (CEST)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.50.0504061603250.22575-100000@220a.licentiaten.umea.hsb.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: MPC870, PCMCIA and IDE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I'm trying to get IDE working via PCMCIA on a custom board wih a MPC870 CPU. I
have a SanDisk 128MB CF card and a CF to PCMCIA adapter. I have it partly
working. The bootloader (RedBoot) dont configure the PCMCIA registers so I took
the initialization code from U-Boot and added it to m8xx_ide_init. The card is
identified but no IDE device is found. I have run out of options to try and
would be greatful for any ideas.

Relevant kernel messages:

Uncompressing Linux...done.
Now booting the kernel
hardware_enable: Slot A
<6>PIPR(fa2000f0)=0x4600ff00
PIPR: 0x4600ff00 ==> VS1=off, VS2=on
3.3V card found: <6>Enable PCMCIA buffers and stop RESET
# hardware_enable done
Win 0: BR: d0000000 OR: b8024491
Win 1: BR: d4000000 OR: 780244d9
Win 2: BR: d8000000 OR: 78024499
Win 3: BR: dc000000 OR: b8024491
Win 4: BR: 00000000 OR: 00000000
Win 5: BR: e0000000 OR: 780244d9
Win 6: BR: e4000000 OR: 78024499
Win 7: BR: 00000000 OR: 00000000

<snip>

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot A: phys mem d0000000...e8000000 (size 18000000)
PCMCIA virt base: c20f7000
PIPR = 0x4700C000  slot A ==> mask = 0x18000000
PCMCIA MEM: C20F7000
Card ID: SanDisk SDP 5/3 0.6
Fixed Disk Card
 IDE interface
 [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
base: c20f7000 + 00000000 = c20f7000
port[0]: c20f7000 + 04000320 = 00000000
port[1]: c20f7000 + 08000321 = 00000001
port[2]: c20f7000 + 08000322 = 00000002
port[3]: c20f7000 + 08000323 = 00000003
port[4]: c20f7000 + 08000324 = 00000004
port[5]: c20f7000 + 08000325 = 00000005
port[6]: c20f7000 + 08000326 = 00000006
port[7]: c20f7000 + 08000327 = 00000007
port[8]: c20f7000 + 00000106 = 00000008
port[9]: c20f7000 + 0000000a = 00000009
Probing IDE interface ide0...
probing for hda: present=0, media=32, probetype=ATA
probing for hda: present=0, media=32, probetype=ATAPI
probing for hdb: present=0, media=32, probetype=ATA
probing for hdb: present=0, media=32, probetype=ATAPI

<snip>

Thanks

/Markus
