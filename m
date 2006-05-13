Return-Path: <silverpower@bellsouth.net>
Received: from imf17aec.mail.bellsouth.net (imf17aec.mail.bellsouth.net
	[205.152.59.65]) by ozlabs.org (Postfix) with ESMTP id BEE2A679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 11:44:20 +1000 (EST)
Received: from ibm56aec.bellsouth.net ([68.212.242.176])
	by imf16aec.mail.bellsouth.net with ESMTP id
	<20060513010949.WKES26160.imf16aec.mail.bellsouth.net@ibm56aec.bellsouth.net>
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 21:09:49 -0400
Date: Fri, 12 May 2006 21:09:37 -0400
From: Jordan Herring <silverpower@bellsouth.net>
To: benh@kernel.crashing.org
Subject: gentoo-2.6.15-r1 - Kernel oops when removing then reinstalling DVD
	drive into Pismo mediabay
Message-ID: <20060512210937.70edf87b@zetagundam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is using the 2.6.15 kernel with the Gentoo patches. The 2.6.16
kernel also exhibits this behavior.

Mar  4 08:48:50 zetagundam mediabay0: switching to 3
Mar  4 08:48:50 zetagundam mediabay0: powering up
Mar  4 08:48:50 zetagundam mediabay0: enabling (kind:3)
Mar  4 08:48:50 zetagundam mediabay0: waiting reset (kind:3)
Mar  4 08:48:51 zetagundam mediabay0: waiting IDE reset (kind:3)
Mar  4 08:48:52 zetagundam mediabay0: waiting IDE ready (kind:3)
Mar  4 08:48:52 zetagundam mediabay 0, registering IDE...
Mar  4 08:48:52 zetagundam Probing IDE interface ide2...
Mar  4 08:48:52 zetagundam hde: MATSHITADVD-ROM SR-8173, ATAPI CD/DVD-ROM drive 
Mar  4 08:48:52 zetagundam Oops: kernel access of bad area, sig: 11 [#1] 
Mar  4 08:48:52 zetagundam NIP: C010EF6C LR: C010E1F4 SP: CFEE5EB0 REGS: cfee5e00 TRAP: 0300    Not tainted 
Mar  4 08:48:52 zetagundam MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Mar  4 08:48:52 zetagundam DAR: 220000A2, DSISR: 40000000 
Mar  4 08:48:52 zetagundam TASK = cfe387f0[721] 'media-bay' THREAD: cfee4000
Mar  4 08:48:52 zetagundam Last syscall: -1 
Mar  4 08:48:52 zetagundam GPR00: C016BC14 CFEE5EB0 CFE387F0 220000A2 C0373D50 C016BD14 C0373D4C 00000000 
Mar  4 08:48:52 zetagundam GPR08: C02DAC53 FFFFFFFF 00004000 C0373DC0 82004088 00000000 00000000 00000000 
Mar  4 08:48:52 zetagundam GPR16: 00000000 00000000 00000000 00000000 00230000 00000000 00000000 00009032 
Mar  4 08:48:52 zetagundam GPR24: C0310000 00000014 00000000 FFFFFFEA C0373768 C0373D4C C0373D18 2200008A 
Mar  4 08:48:52 zetagundam NIP [c010ef6c] kref_get+0x0/0x24 
Mar  4 08:48:52 zetagundam LR [c010e1f4] kobject_get+0x20/0x38 
Mar  4 08:48:52 zetagundam Call trace:
Mar  4 08:48:52 zetagundam [c016bc14] get_device+0x20/0x38 
Mar  4 08:48:52 zetagundam [c016bde4] device_add+0x48/0x170 
Mar  4 08:48:52 zetagundam [c019663c] probe_hwif+0x600/0x780 
Mar  4 08:48:52 zetagundam [c0197374] probe_hwif_init_with_fixup+0x1c/0xac 
Mar  4 08:48:52 zetagundam [c018f688] ide_register_hw_with_fixup+0x198/0x1dc 
Mar  4 08:48:52 zetagundam [c0184e24] media_bay_step+0x3b0/0x54c 
Mar  4 08:48:52 zetagundam [c0185054] media_bay_task+0x94/0xf8 
Mar  4 08:48:52 zetagundam [c00069bc] kernel_thread+0x44/0x60

Basically, what happens is that if I pull the drive and then reinsert
it (doesn't matter how long) it immediately does this and the keyboard
seizes up. If I ssh in and kill the process that was on that console,
the kernel will continue to run, if I recall correctly. (Of course,
being a laptop, this is rather impractical most of the time.) Usually
when this happens, the drive is *not* mounted at all.
