Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51EA1DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 05:50:16 +1000 (EST)
Date: Tue, 14 Apr 2009 21:49:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c   
	drivers
Message-ID: <20090414214949.736597d9@hyperion.delvare>
In-Reply-To: <1239730915.24771.12.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes,

On Tue, 14 Apr 2009 19:41:55 +0200, Johannes Berg wrote:
> Alright, with the patch Andreas pointed out it loads, but segfaults, as
> below. Works fine without your patch.

Thanks for the quick test and sorry that it didn't work. I'll take a
look at the trace below and try to figure out what went wrong.

Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
please pick the latest version of my patch which doesn't have them:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/sound-aoa-codecs-convert-to-new-style.patch
I don't think they are the reason of the crash, but who knows...

Are you using a machine with onyx or tas? I guess onyx but I want to be
sure.

> [   10.267137] snd-aoa-codec-onyx: found pcm3052
> [   10.267238] PM: Adding info for i2c:2-0046
> [   10.267926] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!

Does this error also happen without my patch? It would help to see the
logs without my patch to see where it starts diverging.

> [   10.267930] snd-aoa: fabric didn't like codec onyx
> [   10.268041] aoa_codec_onyx: probe of 2-0046 failed with error -22

Apparently aoa_codec_register failed in onyx_i2c_probe(), I have to
understand why.

> [   10.268067] Unable to handle kernel paging request for data at address 0x000000d0
> [   10.268070] Faulting instruction address: 0xd000000001291d68
> [   10.268074] Oops: Kernel access of bad area, sig: 11 [#1]
> [   10.268076] PREEMPT SMP NR_CPUS=4 PowerMac
> [   10.268080] Modules linked in: snd_aoa_codec_onyx(+) firewire_ohci usbhid(+) arc4 snd_aoa_fabric_layout(+) snd_aoa ecb firewire_core crc_itu_t snd_aoa_i2sbus snd_aoa_soundbus iwlagn iwlcore snd_pcm snd_page_alloc ohci_hcd snd_timer ohci1394 ehci_hcd rfkill led_class ieee1394 usbcore snd mac80211 soundcore cfg80211
> [   10.268109] NIP: d000000001291d68 LR: d000000001291d20 CTR: 0000000000000000
> [   10.268113] REGS: c0000001e19a34e0 TRAP: 0300   Not tainted  (2.6.30-rc1-wl-dirty)
> [   10.268115] MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 22000488  XER: 00000000
> [   10.268124] DAR: 00000000000000d0, DSISR: 0000000040000000
> [   10.268127] TASK = c000000205cd9d30[3391] 'modprobe' THREAD: c0000001e19a0000 CPU: 1
> [   10.268130] GPR00: d000000001291d20 c0000001e19a3760 d00000000129cdd8 c000000200c177e0 
> [   10.268135] GPR04: c000000205cda760 0000000000000007 c000000205cd9d68 c000000205cd9d68 
> [   10.268140] GPR08: 0000000000000000 0000000000000000 c000000200c179f0 c0000000010ab590 
> [   10.268145] GPR12: 0000000088000488 c0000000009c2500 0000000000000000 0000000000000000 
> [   10.268150] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [   10.268155] GPR20: 0000000000000000 0000000000000001 000000000054bda0 00000000001ed780 
> [   10.268160] GPR24: 0000000000548080 00000000008c1858 c000000000847b18 0000000000000046 
> [   10.268165] GPR28: c000000217ff56d8 c000000200a59e68 d00000000129c990 c0000001e19a37d8 
> [   10.268175] NIP [d000000001291d68] .onyx_create+0xc0/0x100 [snd_aoa_codec_onyx]
> [   10.268181] LR [d000000001291d20] .onyx_create+0x78/0x100 [snd_aoa_codec_onyx]
> [   10.268183] Call Trace:
> [   10.268188] [c0000001e19a3760] [d000000001291d20] .onyx_create+0x78/0x100 [snd_aoa_codec_onyx] (unreliable)
> [   10.268196] [c0000001e19a3840] [c00000000037f900] .__attach_adapter+0x4c/0x6c
> [   10.268203] [c0000001e19a38d0] [c0000000002f7e34] .class_for_each_device+0xb4/0x10c
> [   10.268208] [c0000001e19a3990] [c00000000037ecec] .i2c_register_driver+0xf0/0x128
> [   10.268214] [c0000001e19a3a30] [d000000001291f20] .onyx_init+0x20/0x668 [snd_aoa_codec_onyx]
> [   10.268219] [c0000001e19a3ab0] [c000000000007f68] .do_one_initcall+0x9c/0x1dc
> [   10.268225] [c0000001e19a3d90] [c000000000099b0c] .SyS_init_module+0xd8/0x238
> [   10.268229] [c0000001e19a3e30] [c000000000007554] syscall_exit+0x0/0x40
> [   10.268232] Instruction dump:
> [   10.268235] a0090022 8129001e b0010074 91210070 48000341 e8410028 2fa30000 3900ffed 
> [   10.268242] 419e0028 e9230020 39430210 39000000 <e96900d0> 380900c8 f94900d0 f8030210 
> [   10.268253] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/3391
> [   10.268258] caller is .die+0x188/0x1d4
> [   10.268260] Call Trace:
> [   10.268264] [c0000001e19a3210] [c00000000000fcc4] .show_stack+0x6c/0x174 (unreliable)
> [   10.268271] [c0000001e19a32c0] [c00000000029e65c] .debug_smp_processor_id+0xe0/0x118
> [   10.268275] [c0000001e19a3350] [c000000000020918] .die+0x188/0x1d4
> [   10.268280] [c0000001e19a33f0] [c000000000027f74] .bad_page_fault+0xb8/0xd4
> [   10.268284] [c0000001e19a3470] [c00000000000524c] handle_page_fault+0x3c/0x5c
> [   10.268293] --- Exception: 300 at .onyx_create+0xc0/0x100 [snd_aoa_codec_onyx]
> [   10.268295]     LR = .onyx_create+0x78/0x100 [snd_aoa_codec_onyx]
> [   10.268299] [c0000001e19a3840] [c00000000037f900] .__attach_adapter+0x4c/0x6c
> [   10.268304] [c0000001e19a38d0] [c0000000002f7e34] .class_for_each_device+0xb4/0x10c
> [   10.268308] [c0000001e19a3990] [c00000000037ecec] .i2c_register_driver+0xf0/0x128
> [   10.268315] [c0000001e19a3a30] [d000000001291f20] .onyx_init+0x20/0x668 [snd_aoa_codec_onyx]
> [   10.268319] [c0000001e19a3ab0] [c000000000007f68] .do_one_initcall+0x9c/0x1dc
> [   10.268323] [c0000001e19a3d90] [c000000000099b0c] .SyS_init_module+0xd8/0x238
> [   10.268328] [c0000001e19a3e30] [c000000000007554] syscall_exit+0x0/0x40
> [   10.268331] ---[ end trace dbcf63aa775331e7 ]---
> 


-- 
Jean Delvare
