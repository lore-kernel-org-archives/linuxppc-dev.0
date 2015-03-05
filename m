Return-Path: <runaway@candw.ms>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2ECEF1A047B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 22:15:49 +1100 (AEDT)
Received: by qgaj5 with SMTP id j5so4509717qga.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 03:15:47 -0800 (PST)
Message-ID: <54F83ADC.9050203@candw.ms>
Date: Thu, 05 Mar 2015 07:15:40 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>	
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>	
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>	
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>	
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>	
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>	
 <54ECDE7D.6070303@candw.ms> <54EDCD9E.5010104@candw.ms>	
 <54F6F081.9060007@candw.ms> <1425513154.32154.12.camel@ellerman.id.au>
In-Reply-To: <1425513154.32154.12.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/4/2015 7:52 PM, Michael Ellerman wrote:
> On Wed, 2015-03-04 at 07:46 -0400, Julian Margetson wrote:
>> Still stuck.
>> Problem still exist with 4.0.0-rc2 and I cant finish the bisect.
>> Triggered when using HDMI. No problem when using DVI.
>> [   33.535692] Unable to handle kernel paging request for data at address 0x00000008
>> [   33.566786] Faulting instruction address: 0xc049db84
>> [   33.574188] Vector: 300 (Data Access) at [eeb13c20]
>> [   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
>> [   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
>> [   33.590429]     sp: eeb13cd0
>> [   33.593310]    msr: 29000
>> [   33.595931]    dar: 8
>> [   33.598207]  dsisr: 0
>> [   33.600480]   current = 0xeea93ac0
>> [   33.603885]     pid   = 2311, comm = Xorg
>> [   33.607922] enter ? for help
>> [   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
>> [   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
>> [   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
>> [   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
>> [   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
>> [   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
>> [   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
>> [   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
>> [   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
>> [   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
>> [   33.671253] SP (bfa56d20) is in userspace
>> [   33.675263] mon>  <no input ...>
> This just looks like a missing NULL check in the radeon code. Probably here:
>
> void radeon_audio_detect(struct drm_connector *connector,
> 	enum drm_connector_status status)
> {
> 	struct radeon_device *rdev;
> 	struct radeon_encoder *radeon_encoder;
> 	struct radeon_encoder_atom_dig *dig;
>
> 	if (!connector || !connector->encoder)
> 		return;
>
> 	rdev = connector->encoder->dev->dev_private;
> 	                           ^
>
> So you could try adding "!connector->encoder->dev" to the if there.
>
> cheers
>
>
>
Thanks.

Results in the following .
[    3.179934] [drm] Radeon Display Connectors
[    3.184711] [drm] Connector 0:
[    3.187827] [drm]   DP-1
[    3.190443] [drm]   HPD1
[    3.193018] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 
0x647c 0x6                         47c
[    3.200502] [drm]   Encoders:
[    3.203510] [drm]     DFP1: INTERNAL_UNIPHY2
[    3.207823] [drm] Connector 1:
[    3.210923] [drm]   HDMI-A-1
[    3.213831] [drm]   HPD5
[    3.216381] [drm]   DDC: 0x6480 0x6480 0x6484 0x6484 0x6488 0x6488 
0x648c 0x6                         48c
[    3.223809] [drm]   Encoders:
[    3.226795] [drm]     DFP2: INTERNAL_UNIPHY2
[    3.231083] [drm] Connector 2:
[    3.234155] [drm]   DVI-I-1
[    3.236968] [drm]   HPD4
[    3.239523] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 
0x645c 0x6                         45c
[    3.246942] [drm]   Encoders:
[    3.249929] [drm]     DFP3: INTERNAL_UNIPHY
[    3.254130] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.262872] Unable to handle kernel paging request for data at 
address 0x00000000
[    3.270407] Faulting instruction address: 0xc04a4280
[    3.275394] Vector: 300 (Data Access) at [ea847b20]
[    3.280286]     pc: c04a4280: radeon_audio_detect+0x1c/0x290
[    3.286016]     lr: c03e6170: radeon_dp_detect+0x218/0x224
[    3.291563]     sp: ea847bd0
[    3.294453]    msr: 29000
[    3.297084]    dar: 0
[    3.299366]  dsisr: 0
[    3.301649]   current = 0xea850000
[    3.305062]     pid   = 1, comm = swapper
[    3.309101] enter ? for help
[    3.311994] [ea847c00] c03e6170 radeon_dp_detect+0x218/0x224
[    3.317709] [ea847c20] c039160c 
drm_helper_probe_single_connector_modes_merge _bits+0xf4/0x434
[    3.326303] [ea847c60] c0398d68 
drm_fb_helper_probe_connector_modes+0x5c/0x70
[    3.333499] [ea847c80] c039ad40 drm_fb_helper_initial_config+0x38/0x380
[    3.340174] [ea847cc0] c03f1848 radeon_fbdev_init+0xc8/0xfc
[    3.345808] [ea847ce0] c03eb1cc radeon_modeset_init+0x77c/0x94c
[    3.351781] [ea847d40] c03c72fc radeon_driver_load_kms+0xcc/0x134
[    3.357935] [ea847d60] c03a3cfc drm_dev_register+0x9c/0x120
[    3.363569] [ea847d80] c03a6538 drm_get_pci_dev+0xf4/0x190
[    3.369116] [ea847da0] c033d194 pci_device_probe+0x68/0xb4
[    3.374680] [ea847dc0] c04b8a4c driver_probe_device+0xd4/0x1f4
[    3.380583] [ea847df0] c04b8c48 __driver_attach+0x78/0xa0
[    3.386034] [ea847e10] c04b6fd8 bus_for_each_dev+0x8c/0x9c
[    3.391572] [ea847e40] c04b81a8 bus_add_driver+0xf8/0x1d4
[    3.397024] [ea847e60] c04b90fc driver_register+0xb4/0xf8
[    3.402475] [ea847e80] c00016f0 do_one_initcall+0x114/0x19c
[    3.408109] [ea847ef0] c0992a8c kernel_init_freeable+0x124/0x1c0
[    3.414176] [ea847f30] c0001cc0 kernel_init+0x14/0xf4
[    3.419280] [ea847f40] c000ac5c ret_from_kernel_thread+0x5c/0x64
[    3.425347] mon>  <no input ...>
[    5.428725] Oops: Kernel access of bad area, sig: 11 [#1]
[    5.434140] PREEMPT Canyonlands
[    5.437301] Modules linked in:
[    5.440378] CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc2-Sam460ex #1
[    5.447182] task: ea850000 ti: ea846000 task.ti: ea846000
[    5.452597] NIP: c04a4280 LR: c03e6170 CTR: c03e44c0
[    5.457571] REGS: ea847b20 TRAP: 0300   Not tainted (4.0.0-rc2-Sam460ex)
[    5.464374] MSR: 00029000 <CE,EE,ME>  CR: 82000028  XER: 00000000
[    5.470582] DEAR: 00000000 ESR: 00000000
GPR00: c03e6170 ea847bd0 ea850000 eeb6e400 00000002 00000000 ea847a48 
00000000
GPR08: 00000000 ffffffff 00000000 ea847c00 22000022 00000000 c0910000 
c091798f
GPR16: c09179a5 c09179bb c09179d1 c09179e7 c09179fc c0910000 00000001 
00004000
GPR24: 00004000 c0759c14 c0b40000 eeac8000 eeb671a0 eeb66400 00000000 
eeb6e400
[    5.503365] NIP [c04a4280] radeon_audio_detect+0x1c/0x290
[    5.508780] LR [c03e6170] radeon_dp_detect+0x218/0x224
[    5.513931] Call Trace:
[    5.516391] [ea847bd0] [eeb6e40c] 0xeeb6e40c (unreliable)
[    5.521835] [ea847c00] [c03e6170] radeon_dp_detect+0x218/0x224
[    5.527696] [ea847c20] [c039160c] 
drm_helper_probe_single_connector_modes_mer ge_bits+0xf4/0x434
[    5.536429] [ea847c60] [c0398d68] 
drm_fb_helper_probe_connector_modes+0x5c/0x 70
[    5.543772] [ea847c80] [c039ad40] drm_fb_helper_initial_config+0x38/0x380
[    5.550587] [ea847cc0] [c03f1848] radeon_fbdev_init+0xc8/0xfc
[    5.556358] [ea847ce0] [c03eb1cc] radeon_modeset_init+0x77c/0x94c
[    5.562477] [ea847d40] [c03c72fc] radeon_driver_load_kms+0xcc/0x134
[    5.568771] [ea847d60] [c03a3cfc] drm_dev_register+0x9c/0x120
[    5.574544] [ea847d80] [c03a6538] drm_get_pci_dev+0xf4/0x190
[    5.580231] [ea847da0] [c033d194] pci_device_probe+0x68/0xb4
[    5.585916] [ea847dc0] [c04b8a4c] driver_probe_device+0xd4/0x1f4
[    5.591948] [ea847df0] [c04b8c48] __driver_attach+0x78/0xa0
[    5.597547] [ea847e10] [c04b6fd8] bus_for_each_dev+0x8c/0x9c
[    5.603233] [ea847e40] [c04b81a8] bus_add_driver+0xf8/0x1d4
[    5.608831] [ea847e60] [c04b90fc] driver_register+0xb4/0xf8
[    5.614430] [ea847e80] [c00016f0] do_one_initcall+0x114/0x19c
[    5.620204] [ea847ef0] [c0992a8c] kernel_init_freeable+0x124/0x1c0
[    5.626408] [ea847f30] [c0001cc0] kernel_init+0x14/0xf4
[    5.631661] [ea847f40] [c000ac5c] ret_from_kernel_thread+0x5c/0x64
[    5.637864] Instruction dump:
[    5.640851] 80890010 38210020 4bfffb20 39610020 4bb6ced0 9421ffd0 
7c0802a6 bf                         810020
[    5.648732] 7c7f1b79 90010034 41820274 83df020c <813e0000> 2f890000 
419e0264                          2b840001
[    5.656812] ---[ end trace bdaa0514de2b69bd ]---
[    5.661441]
[    6.663014] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x00                         00000b
[    6.663014]
[    6.672182] Rebooting in 180 seconds..
