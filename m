Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 757CEDDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 02:27:36 +1100 (EST)
Message-ID: <473DB6DF.9010804@anagramm.de>
Date: Fri, 16 Nov 2007 16:27:27 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: 85xx software reset problems from paulus.git
References: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
In-Reply-To: <f87675ee0711160700m17122edcv51b55f4a0cbe38b1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello, Robert!

robert lazarski schrieb:
 > Hi all, on my custom 85xx board I can't do a soft reset. I'm using
 > u-boot 1.3rc3 that has the latest cpu/mpc85xx/cpu.c patch to fix some
 > type of reset problem. When I press the software reset button on my
 > board after my nfs kernel panic, I get this:

Please define "software reset button" in your case. :-)
I consider a "button" clearly as hardware.

In my case (my button) asserts the HRESET# CPU pin low.

As far as I understood the details (not verified again):
To trigger a hard reset via software, the CPU (8540 at least)
should assert the HRESET_REQ# (Pin AG20) low (which needs
to be triggered in software, somehow).
Some external glue logic should then issue the HRESET#
(pin AH16) low to reset the CPU (hard, Power On Reset).

The SRESET# (pin AF20) is the soft reset input, causes
an mcp assertion to the core.... (RTFM)

So, the detailed explanation seems to be implementation
specific (if HRESET_REQ# can get triggered and if HRESET_REQ#
assertion is glued to assert HRESET# from the HW guys).

 > Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
 > Rebooting in 10 seconds..Machine check in kernel mode.
 > Caused by (from MCSR=80000000): Machine Check Signal
 > Oops: Machine check, sig: 7 [#1]
 > MPC85xx CDS
 > NIP: c00131f8 LR: c0014060 CTR: c00230dc
 > REGS: c0289f50 TRAP: 0202   Not tainted  (2.6.24-rc2-ge6a5c27f-dirty)
 > MSR: 00021000 <ME>  CR: 24000028  XER: 20000000
 > TASK = c1020000[1] 'swapper' THREAD: c1022000
 > GPR00: 00000002 c1023e30 c1020000 00000000 00000686 00000047 c1023e38 00000000
 > GPR08: 7e58da6f f10000b0 003d0900 c0281ec8 44000088 7fffa7e3 3ffefb00 00800000
 > GPR16: ffffffff 00000000 007fff00 c0220000 c0260000 c0260000 00000000 3ffeb254
 > GPR24: c0260000 00000000 c0280000 c0219f84 c0290000 00002710 c0260000 00000000
 > NIP [c00131f8] fsl_rstcr_restart+0x20/0x24
 > LR [c0014060] mpc85xx_cds_restart+0x78/0x8c
 > Call Trace:
 > [c1023e30] [c0014008] mpc85xx_cds_restart+0x20/0x8c (unreliable)
 > [c1023e50] [c000c894] machine_restart+0x34/0x48
 > [c1023e60] [c0031f9c] emergency_restart+0x14/0x24
 > [c1023e70] [c00234e8] panic+0x134/0x174
 > [c1023f00] [c0242d5c] mount_block_root+0x108/0x24c
 > [c1023f50] [c02431c0] prepare_namespace+0xd0/0x210
 > [c1023f70] [c0242938] kernel_init+0x170/0x290
 > [c1023ff0] [c000d2dc] kernel_thread+0x44/0x60
 > Instruction dump:
 > 80010014 38210010 7c0803a6 4e800020 7c000146 3d20c029 8129821c 2f890000
 > 419e0010 38000002 7c0004ac 90090000 <48000000> 81230044 8009003c 70090008
 > Kernel panic - not syncing: Attempted to kill init!
 > Rebooting in 10 seconds..
 >
 > I believe Clemens recently confirmed the same issue. Any ideas?
 > Robert

Not really. I just can confirm that the a $shutdown -r now doesn't
reboot my board anymore whereas 2.6.21-rc4 did.
IIRC, I've seen a patch which changed some instructions in some reboot()
function some time ago.

(Please note, I'm using the mpc8540_ads which might be slightly different
from the *_cds.)

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
