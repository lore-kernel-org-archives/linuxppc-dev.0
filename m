Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73501DDE31
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 07:49:14 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: linux1394-devel@lists.sourceforge.net
Subject: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
Date: Fri, 29 Dec 2006 21:49:09 +0100
Message-ID: <je7iwa1l8a.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm getting this BUG on PowerMac with 2.6.20-rc2 during probing of
firewire devices:

kernel BUG at include/asm/dma-mapping.h:110!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=2 
Modules linked in: sbp2 snd_aoa_codec_tas ide_cd ohci1394 snd_aoa_fabric_layout snd_aoa cdrom ieee1394 snd_aoa_i2sbus snd_aoa_soundbus sungem sungem_phy uninorth_agp agpgart snd_powermac snd_pcm snd_page_alloc snd_timer snd soundcore sg sata_svw libata sd_mod scsi_mod
NIP: D0000000002F5A90 LR: D0000000002F5A38 CTR: 0000000000000000
REGS: c00000000f447490 TRAP: 0700   Not tainted  (2.6.20-rc2)
MSR: 9000000000029032 <EE,ME,IR,DR>  CR: 84222482  XER: 00000000
TASK = c000000001139080[2224] 'modprobe' THREAD: c00000000f444000 CPU: 0
GPR00: 0000000000000001 C00000000F447710 D000000000303F38 C00000000F2E00F0 
GPR04: D000000000282000 C000000001FD4228 C00000000F517140 0000000000000004 
GPR08: 0000000000012800 0000000000000000 D0000000002F7970 D0000000002F7968 
GPR12: D00000000005B200 C0000000004D1280 D0000000002EE6C0 0000000000000000 
GPR16: D0000000002EE680 0000000000000009 000000001002BD88 D0000000002EDDB2 
GPR20: 0000000000000000 0000000000000028 00000000000000C8 D0000000002E8000 
GPR24: 0000000000000021 0000000000000022 C00000004E32D450 C00000004E32D400 
GPR28: 0000000000000000 C00000004E662FB0 D000000000303A00 C000000001FD4200 
NIP [D0000000002F5A90] .sbp2_probe+0x298/0x71c [sbp2]
LR [D0000000002F5A38] .sbp2_probe+0x240/0x71c [sbp2]
Call Trace:
[C00000000F447710] [D0000000002F5A38] .sbp2_probe+0x240/0x71c [sbp2] (unreliable)
[C00000000F4477D0] [C0000000002494A0] .really_probe+0xbc/0x180
[C00000000F447870] [C000000000249858] .__driver_attach+0xb4/0x138
[C00000000F447900] [C00000000024848C] .bus_for_each_dev+0x7c/0xd4
[C00000000F4479C0] [C00000000024928C] .driver_attach+0x28/0x40
[C00000000F447A40] [C000000000248960] .bus_add_driver+0x80/0x1ec
[C00000000F447AE0] [C000000000249C58] .driver_register+0xa8/0xc4
[C00000000F447B60] [D0000000001727F8] .__hpsb_register_protocol+0x48/0xbc [ieee1394]
[C00000000F447C00] [D0000000002F5FB0] .sbp2_module_init+0x9c/0xe0 [sbp2]
[C00000000F447C90] [C000000000071EFC] .sys_init_module+0x17c4/0x198c
[C00000000F447E30] [C0000000000086AC] syscall_exit+0x0/0x40
Instruction dump:
48001839 e8410028 7fe3fb78 3ba0fff4 48000470 e8030240 2fa00000 7c090378 
40fe0008 39200000 7d200074 7800d182 <0b000000> e9290000 38800010 38c000d0 

Bisecting has identified this commit:

commit 9b7d9c096dd4e4baacc21b2588662bbb56f36c4e
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Wed Nov 22 21:44:34 2006 +0100

    ieee1394: sbp2: convert from PCI DMA to generic DMA
    
    API conversion without change in functionality
    
    Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>


I'm only seeing this on ppc64, ppc32 seems to be working fine.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
