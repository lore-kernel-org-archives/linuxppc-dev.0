Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB6DE67BC4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 22:57:51 +1000 (EST)
Subject: Re: oops in snd-powermac due to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060907124256.GA22928@aepfle.de>
References: <20060907124256.GA22928@aepfle.de>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 14:58:21 +0200
Message-Id: <1157633901.2857.61.camel@ux156>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 14:42 +0200, Olaf Hering wrote:
> I was playing with snd-aoa, maybe the driver would work on a G4/466.

Does it have a layout-id property in the device tree? :)

> mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
> reboot
> $insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
> alsamixer finds nothing.
> mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
> $insmod snd-powermac.ko -> oops
> TASK = c291d930[4987] 'modprobe' THREAD: c6b68000
> GPR00: D219CC8C C6B69CF0 C291D930 00000000 00000001 00000068 00000000 00000001 
> GPR08: 00000002 00000000 00000070 C0244AD8 00000000 1002F308 0000000D D2191214 
> GPR16: 0000001C D218FBE4 C1000300 D218FBBC 00000163 D218FB94 00000000 0000001E 
> GPR24: D218F639 00000000 CD6D40AC CD6D4000 C66E30C0 0000000A D21A3F24 D219E714 
> NIP [C0244AF8] i2c_smbus_write_byte_data+0x20/0x44
> LR [D219CC8C] send_init_client+0x30/0x8c [snd_powermac]
> Call Trace:
> [C6B69CF0] [C005B2FC] setup_irq+0x1e4/0x22c (unreliable)
> [C6B69D30] [D219CC8C] send_init_client+0x30/0x8c [snd_powermac]
> [C6B69D50] [D213BDA8] snd_pmac_tumbler_post_init+0x28/0x6c [snd_powermac]
> [C6B69D60] [D213A1F4] snd_pmac_probe+0x19c/0x2f0 [snd_powermac]
> [C6B69D90] [C01F2788] platform_drv_probe+0x20/0x30
> [C6B69DA0] [C01F0AD0] driver_probe_device+0x8c/0xf4
> [C6B69DC0] [C01F0270] bus_for_each_drv+0x50/0x98
> [C6B69DF0] [C01F0BAC] device_attach+0x70/0xac
> [C6B69E10] [C01EFF24] bus_attach_device+0x24/0x44
> [C6B69E20] [C01EEC14] device_add+0x1ec/0x314
> [C6B69E50] [C01F2C00] platform_device_add+0x118/0x160
> [C6B69E70] [C01F2E78] platform_device_register_simple+0x4c/0x78
> [C6B69E90] [D213A038] alsa_card_pmac_init+0x38/0x58 [snd_powermac]
> [C6B69EA0] [C004EB14] sys_init_module+0x1368/0x14f8
> [C6B69F40] [C00125A4] ret_from_syscall+0x0/0x40
> --- Exception: c01 at 0xff698a4
>     LR = 0x100039d0

I fail to see how this is related to aoa since, well, aoa shouldn't do
anything on your machine at all... And for those machines where aoa does
something, snd-powermac blocks its own operation.

johannes
