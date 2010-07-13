Return-Path: <jjdanimoth@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 617CDB6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 00:03:55 +1000 (EST)
Received: by wyb32 with SMTP id 32so536782wyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 07:03:51 -0700 (PDT)
MIME-Version: 1.0
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 13 Jul 2010 16:03:19 +0200
Message-ID: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
Subject: 2.6.35-rc4 ppc crash when loading radeon modeset=1
To: xorg-driver-ati@lists.x.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello to all.

Sorry if these aren't right place, please point me to the right
direction if you can :)

When trying new 2.6.35-rc4, our kernel team (ArchLinuxPPC) has tried
to setup KMS acceleration for radeon based machine.
We have removed radeonfb, and all others framebuffer driver, and added
fbcon and KMS enabled by default for radeon driver.

With a clean start, the screen freeze, when the control pass from
yaboot to kernel.

If we start with video=fbcon (or video=radeondrmfb), we could reach
the loading modules point, but after the loading of radeon, the screen
goes black, without any log information.

Loading kernel with video=fbcon radeon.modeset=0 allow us to reach the
end of init stage, and we could load X.org. In this case, acceleration
is disabled.

If we log out and do the following command:
modprobe -r radeon drm
modprobe drm debug=1
modprobe radeon modeset=1

The screen goes black, but at next boot we have found the logs. Any hint?

System information:

Xorg server: 1.8.1
xf86-video-ati 6.13.0
ati-dri 7.8.1
mesa 7.8.1
linux 2.6.35-rc4-00131-ge467e10

There are logs (most relevant part):
[...]
Jul 13 15:29:50 jim kernel: Caused by (from SRR1=149030): Transfer
error ack signal
Jul 13 15:29:50 jim kernel: Machine check in kernel mode.
Jul 13 15:29:50 jim kernel: Caused by (from SRR1=149030): Transfer
error ack signal
Jul 13 15:29:50 jim kernel: Machine check in kernel mode.
Jul 13 15:29:50 jim kernel: Caused by (from SRR1=149030): Transfer
error ack signal
Jul 13 15:29:50 jim kernel: Machine check in kernel mode.
Jul 13 15:29:50 jim kernel: Caused by (from SRR1=149030): Transfer
error ack signal
[....]
Jul 13 15:31:28 jim kernel: [drm] Module unloaded
Jul 13 15:31:39 jim kernel: [drm] Initialized drm 1.1.0 20060810
Jul 13 15:31:39 jim kernel: [drm] radeon kernel modesetting enabled.
Jul 13 15:31:39 jim kernel: [drm] initializing kernel modesetting
(RV350 0x1002:0x4E50).
Jul 13 15:31:39 jim kernel: [drm] register mmio base: 0xB0000000
Jul 13 15:31:39 jim kernel: [drm] register mmio size: 65536
Jul 13 15:31:39 jim kernel: [drm] Using generic clock info
Jul 13 15:31:39 jim kernel: agpgart-uninorth 0000:00:0b.0: putting AGP
V2 device into 4x mode
Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: putting AGP V2 device
into 4x mode
Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: GTT: 256M 0x00000000
- 0x0FFFFFFF
Jul 13 15:31:39 jim kernel: [drm] Generation 2 PCI interface, using
max accessible memory
Jul 13 15:31:39 jim kernel: radeon 0000:00:10.0: VRAM: 64M 0xB8000000
- 0xBBFFFFFF (64M used)
Jul 13 15:31:39 jim kernel: [drm] radeon: irq initialized.
Jul 13 15:31:39 jim kernel: [drm] Detected VRAM RAM=64M, BAR=128M
Jul 13 15:31:39 jim kernel: [drm] RAM width 128bits DDR
Jul 13 15:31:39 jim kernel: [TTM] Zone  kernel: Available graphics
memory: 384990 kiB.
Jul 13 15:31:39 jim kernel: [TTM] Zone highmem: Available graphics
memory: 516062 kiB.
Jul 13 15:31:39 jim kernel: [TTM] Initializing pool allocator.
Jul 13 15:31:39 jim kernel: [drm] radeon: 64M of VRAM memory ready
Jul 13 15:31:39 jim kernel: [drm] radeon: 256M of GTT memory ready.
Jul 13 15:31:39 jim kernel: [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
Jul 13 15:31:39 jim kernel: [drm] Loading R300 Microcode
Jul 13 15:31:39 jim kernel: [drm] radeon: ring at 0x0000000000000000
Jul 13 15:31:39 jim kernel: [drm] ring test succeeded in 3 usecs
Jul 13 15:31:39 jim kernel: [drm] radeon: ib pool ready.
Jul 13 15:31:40 jim kernel: GPU lockup (waiting for 0x00000001 last
fence id 0x00000000)
Jul 13 15:31:40 jim kernel: NIP: f260fda4 LR: f260fda4 CTR: 00000001
Jul 13 15:31:40 jim kernel: REGS: ef3a3b90 TRAP: 0700   Not tainted
(2.6.35-rc4-NAT-00131-ge467e10)
Jul 13 15:31:40 jim kernel: MSR: 00029032 <EE,ME,CE,IR,DR>  CR:
22822484  XER: 20000000
Jul 13 15:31:40 jim kernel: TASK = eedb9ac0[2066] 'modprobe' THREAD: ef3a2000
Jul 13 15:31:40 jim kernel: GPR00: f260fda4 ef3a3c40 eedb9ac0 00000040
416d5d8c ffffffff c04db984 416d5d09
Jul 13 15:31:40 jim kernel: GPR08: 416d5d8c 00000001 00000000 0000000a
22822482 100238a8 00000000 00000000
Jul 13 15:31:40 jim kernel: GPR16: 00000000 0000007d c04a0000 f26a1d54
00000001 00000000 00000000 ef3a2000
Jul 13 15:31:40 jim kernel: GPR24: c005f328 ef3a3c54 00000000 eed386cc
ef3a3c48 00000000 eed38000 ef085d40
Jul 13 15:31:40 jim kernel: NIP [f260fda4]
radeon_fence_wait+0x28c/0x2f4 [radeon]
Jul 13 15:31:40 jim kernel: LR [f260fda4] radeon_fence_wait+0x28c/0x2f4 [radeon]
Jul 13 15:31:40 jim kernel: Call Trace:
Jul 13 15:31:40 jim kernel: [ef3a3c40] [f260fda4]
radeon_fence_wait+0x28c/0x2f4 [radeon] (unreliable)
Jul 13 15:31:40 jim kernel: [ef3a3cb0] [f2638234]
r100_ib_test+0x158/0x280 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3ce0] [f26383a4]
r100_ib_init+0x28/0xc8 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3cf0] [f263f65c]
r300_startup+0xd4/0x1e4 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3d00] [f263fb3c] r300_init+0x150/0x334 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3d10] [f25fc514]
radeon_device_init+0x2b0/0x418 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3d30] [f25fdc0c]
radeon_driver_load_kms+0xa4/0x1f4 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3d60] [f2444c4c] drm_get_dev+0x284/0x43c [drm]
Jul 13 15:31:40 jim kernel: [ef3a3d90] [f268d75c]
radeon_pci_probe+0x18/0x28 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3da0] [c01f6f20] pci_device_probe+0x80/0xa4
Jul 13 15:31:40 jim kernel: [ef3a3dc0] [c025cf2c] driver_probe_device+0xc0/0x208
Jul 13 15:31:40 jim kernel: [ef3a3de0] [c025d130] __driver_attach+0xbc/0xc0
Jul 13 15:31:40 jim kernel: [ef3a3e00] [c025bd28] bus_for_each_dev+0x64/0xa0
Jul 13 15:31:40 jim kernel: [ef3a3e30] [c025cb58] driver_attach+0x24/0x34
Jul 13 15:31:40 jim kernel: [ef3a3e40] [c025c618] bus_add_driver+0xd8/0x308
Jul 13 15:31:40 jim kernel: [ef3a3e70] [c025d418] driver_register+0x88/0x154
Jul 13 15:31:40 jim kernel: [ef3a3e90] [c01f7200]
__pci_register_driver+0x4c/0xdc
Jul 13 15:31:40 jim kernel: [ef3a3eb0] [f243ee50] drm_init+0x120/0x134 [drm]
Jul 13 15:31:40 jim kernel: [ef3a3ed0] [f26c00e4]
radeon_init+0xe4/0x128 [radeon]
Jul 13 15:31:40 jim kernel: [ef3a3ef0] [c0003ff4] do_one_initcall+0x3c/0x1d8
Jul 13 15:31:40 jim kernel: [ef3a3f20] [c007b434] sys_init_module+0xdc/0x1e0
Jul 13 15:31:40 jim kernel: [ef3a3f40] [c0017f84] ret_from_syscall+0x0/0x40
Jul 13 15:31:40 jim kernel: --- Exception: c01 at 0xff62b58
Jul 13 15:31:40 jim kernel: LR = 0x10002c7c
Jul 13 15:31:40 jim kernel: Instruction dump:
Jul 13 15:31:40 jim kernel: 4bffffc4 813e0a18 7fc3f378 80090014
7c0903a6 4e800421 2f830000 419eff78
Jul 13 15:31:40 jim kernel: 809f0010 7e639b78 7ec5b378 4807dc59
<0fe00000> 9a9e16a8 7fc3f378 4bfecd41
Jul 13 15:31:40 jim kernel: radeon 0000:00:10.0: GPU reset succeed
Jul 13 15:31:40 jim kernel: [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
Jul 13 15:31:40 jim kernel: [drm] radeon: ring at 0x0000000000000000
Jul 13 15:31:41 jim kernel: Oops: Kernel access of bad area, sig: 11 [#1]
Jul 13 15:31:41 jim kernel: PREEMPT PowerMac
Jul 13 15:31:41 jim kernel: Modules linked in: radeon(+) ttm
drm_kms_helper drm i2c_algo_bit hid_apple appletouch usbhid arc4 ecb
b43 mac80211 cfg80211 ohci_hcd snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device therm_adt746x snd_pcm_oss snd_aoa_codec_tas
snd_mixer_oss snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_pcm
snd_timer snd_page_alloc snd ehci_hcd ohci1394 ssb ams input_polldev
yenta_socket soundcore pcmcia usbcore ide_cd_mod pcmcia_rsrc ieee1394
cpufreq_userspace snd_aoa_soundbus i2c_powermac pcmcia_core evdev
cdrom uninorth_agp sungem sungem_phy [last unloaded: i2c_algo_bit]
Jul 13 15:31:41 jim kernel: NIP: f2482248 LR: f25fcb88 CTR: 00000000
Jul 13 15:31:41 jim kernel: REGS: ef3a3b50 TRAP: 0300   Tainted: G
   W    (2.6.35-rc4-NAT-00131-ge467e10)
Jul 13 15:31:41 jim kernel: MSR: 00009032 <EE,ME,IR,DR>  CR: 22822484
XER: 20000000
Jul 13 15:31:41 jim kernel: DAR: 00000000, DSISR: 40000000
Jul 13 15:31:41 jim kernel: TASK = eedb9ac0[2066] 'modprobe' THREAD: ef3a2000
Jul 13 15:31:41 jim kernel: GPR00: f25fcb88 ef3a3c00 eedb9ac0 ef2c8c00
416d67bb ffffffff c04db97e 416d66f1
Jul 13 15:31:41 jim kernel: GPR08: 416d67bb 00000030 f28e002c eed39670
22822482 100238a8 00000000 00000000
Jul 13 15:31:41 jim kernel: GPR16: 00000000 0000007d c04a0000 f26a1d54
00000001 00000000 00000000 ef3a2000
Jul 13 15:31:41 jim kernel: GPR24: c005f328 ef3a3c54 f2484054 f2483878
ef2c8c00 ef2c8ea4 ef2c8e98 fffffffc
Jul 13 15:31:41 jim kernel: NIP [f2482248]
drm_helper_resume_force_mode+0x38/0x16c [drm_kms_helper]
Jul 13 15:31:41 jim kernel: LR [f25fcb88] radeon_gpu_reset+0x98/0x104 [radeon]
Jul 13 15:31:41 jim kernel: Call Trace:
Jul 13 15:31:41 jim kernel: [ef3a3c00] [ffffffea] 0xffffffea (unreliable)
Jul 13 15:31:41 jim kernel: [ef3a3c30] [f25fcb88]
radeon_gpu_reset+0x98/0x104 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3c40] [f260fdb4]
radeon_fence_wait+0x29c/0x2f4 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3cb0] [f2638234]
r100_ib_test+0x158/0x280 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3ce0] [f26383a4]
r100_ib_init+0x28/0xc8 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3cf0] [f263f65c]
r300_startup+0xd4/0x1e4 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3d00] [f263fb3c] r300_init+0x150/0x334 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3d10] [f25fc514]
radeon_device_init+0x2b0/0x418 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3d30] [f25fdc0c]
radeon_driver_load_kms+0xa4/0x1f4 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3d60] [f2444c4c] drm_get_dev+0x284/0x43c [drm]
Jul 13 15:31:41 jim kernel: [ef3a3d90] [f268d75c]
radeon_pci_probe+0x18/0x28 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3da0] [c01f6f20] pci_device_probe+0x80/0xa4
Jul 13 15:31:41 jim kernel: [ef3a3dc0] [c025cf2c] driver_probe_device+0xc0/0x208
Jul 13 15:31:41 jim kernel: [ef3a3de0] [c025d130] __driver_attach+0xbc/0xc0
Jul 13 15:31:41 jim kernel: [ef3a3e00] [c025bd28] bus_for_each_dev+0x64/0xa0
Jul 13 15:31:41 jim kernel: [ef3a3e30] [c025cb58] driver_attach+0x24/0x34
Jul 13 15:31:41 jim kernel: [ef3a3e40] [c025c618] bus_add_driver+0xd8/0x308
Jul 13 15:31:41 jim kernel: [ef3a3e70] [c025d418] driver_register+0x88/0x154
Jul 13 15:31:41 jim kernel: [ef3a3e90] [c01f7200]
__pci_register_driver+0x4c/0xdc
Jul 13 15:31:41 jim kernel: [ef3a3eb0] [f243ee50] drm_init+0x120/0x134 [drm]
Jul 13 15:31:41 jim kernel: [ef3a3ed0] [f26c00e4]
radeon_init+0xe4/0x128 [radeon]
Jul 13 15:31:41 jim kernel: [ef3a3ef0] [c0003ff4] do_one_initcall+0x3c/0x1d8
Jul 13 15:31:41 jim kernel: [ef3a3f20] [c007b434] sys_init_module+0xdc/0x1e0
Jul 13 15:31:41 jim kernel: [ef3a3f40] [c0017f84] ret_from_syscall+0x0/0x40
Jul 13 15:31:41 jim kernel: --- Exception: c01 at 0xff62b58
Jul 13 15:31:41 jim kernel: LR = 0x10002c7c
Jul 13 15:31:41 jim kernel: Instruction dump:
Jul 13 15:31:41 jim kernel: bf010010 7c7d1b78 3f60f248 90010034
3f40f248 3b7b382c 7c7c1b78 3bc30298
Jul 13 15:31:41 jim kernel: 3b5a4054 3b7b004c 87fd02a4 3bfffffc
<813f0004> 2f890000 419e0008 7c004a2c
Jul 13 15:31:41 jim kernel: ---[ end trace 9928f19443a4dfb8 ]---
Jul 13 15:31:48 jim kernel: Oops: Kernel access of bad area, sig: 11 [#2]
Jul 13 15:31:48 jim kernel: PREEMPT PowerMac
Jul 13 15:31:48 jim kernel: Modules linked in: radeon(+) ttm
drm_kms_helper drm i2c_algo_bit hid_apple appletouch usbhid arc4 ecb
b43 mac80211 cfg80211 ohci_hcd snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device therm_adt746x snd_pcm_oss snd_aoa_codec_tas
snd_mixer_oss snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_pcm
snd_timer snd_page_alloc snd ehci_hcd ohci1394 ssb ams input_polldev
yenta_socket soundcore pcmcia usbcore ide_cd_mod pcmcia_rsrc ieee1394
cpufreq_userspace snd_aoa_soundbus i2c_powermac pcmcia_core evdev
cdrom uninorth_agp sungem sungem_phy [last unloaded: i2c_algo_bit]
Jul 13 15:31:48 jim kernel: NIP: c0382df4 LR: c0382de0 CTR: 00000000
Jul 13 15:31:48 jim kernel: REGS: eed7dd80 TRAP: 0300   Tainted: G
 D W    (2.6.35-rc4-NAT-00131-ge467e10)
Jul 13 15:31:48 jim kernel: MSR: 00001032 <ME,IR,DR>  CR: 24000424
XER: 20000000
Jul 13 15:31:48 jim kernel: DAR: 00000000, DSISR: 42000000
Jul 13 15:31:48 jim kernel: TASK = efb46820[2095] 'X' THREAD: eed7c000
Jul 13 15:31:48 jim kernel: GPR00: ffffffff eed7de30 efb46820 ef2c8e3c
eed7de38 eed7c000 eed7de44 0000082f
Jul 13 15:31:48 jim kernel: GPR08: 0000e200 00000000 0000007f c0382fc8
24000422 101d3ea8 101cbed4 00000000
Jul 13 15:31:48 jim kernel: GPR16: 10478758 00000000 00000001 101d3c0c
00000000 101cb8c8 ef2c8c00 00009032
Jul 13 15:31:48 jim kernel: GPR24: ef2c8dc0 ef2c8e40 eed7de38 efb46820
c04d0000 00009032 eed7c000 ef2c8e3c
Jul 13 15:31:48 jim kernel: NIP [c0382df4] __mutex_lock_slowpath+0xa0/0x274
Jul 13 15:31:48 jim kernel: LR [c0382de0] __mutex_lock_slowpath+0x8c/0x274
Jul 13 15:31:48 jim kernel: Call Trace:
Jul 13 15:31:48 jim kernel: [eed7de30] [c0382dd0]
__mutex_lock_slowpath+0x7c/0x274 (unreliable)
Jul 13 15:31:48 jim kernel: [eed7de70] [c0382fe0] mutex_lock+0x18/0x34
Jul 13 15:31:48 jim kernel: [eed7de80] [f244d010] drm_fb_release+0x28/0xac [drm]
Jul 13 15:31:48 jim kernel: [eed7dea0] [f243fab8] drm_release+0x674/0x770 [drm]
Jul 13 15:31:48 jim kernel: [eed7dee0] [c00fc410] fput+0x118/0x264
Jul 13 15:31:48 jim kernel: [eed7df00] [c00f87d0] filp_close+0x6c/0x98
Jul 13 15:31:48 jim kernel: [eed7df20] [c00f88ac] sys_close+0xb0/0x12c
Jul 13 15:31:48 jim kernel: [eed7df40] [c0017f84] ret_from_syscall+0x0/0x40
Jul 13 15:31:48 jim kernel: --- Exception: c01 at 0xfec3730
Jul 13 15:31:48 jim kernel: LR = 0xf8b9340
Jul 13 15:31:48 jim kernel: Instruction dump:
Jul 13 15:31:48 jim kernel: 7f44d378 3b3f0004 4bcee849 80bb0004
7fe3fb78 7f44d378 4bcee9e5 813f0008
Jul 13 15:31:48 jim kernel: 3800ffff 93210008 935f0008 9121000c
<93490000> 93610010 7d20f828 7c00f92d
Jul 13 15:31:48 jim kernel: ---[ end trace 9928f19443a4dfb9 ]---
Jul 13 15:31:48 jim kernel: note: X[2095] exited with preempt_count 2
Jul 13 15:31:48 jim kernel: Modules linked in: radeon(+) ttm
drm_kms_helper drm i2c_algo_bit hid_apple appletouch usbhid arc4 ecb
b43 mac80211 cfg80211 ohci_hcd snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device therm_adt746x snd_pcm_oss snd_aoa_codec_tas
snd_mixer_oss snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_pcm
snd_timer snd_page_alloc snd ehci_hcd ohci1394 ssb ams input_polldev
yenta_socket soundcore pcmcia usbcore ide_cd_mod pcmcia_rsrc ieee1394
cpufreq_userspace snd_aoa_soundbus i2c_powermac pcmcia_core evdev
cdrom uninorth_agp sungem sungem_phy [last unloaded: i2c_algo_bit]
Jul 13 15:31:48 jim kernel: Call Trace:
Jul 13 15:31:48 jim kernel: [eed7da50] [c000a6e8]
show_stack+0x50/0x158 (unreliable)
Jul 13 15:31:48 jim kernel: [eed7da90] [c00369bc] __schedule_bug+0x64/0x68
Jul 13 15:31:48 jim kernel: [eed7daa0] [c03816a0] schedule+0x360/0x428
Jul 13 15:31:48 jim kernel: [eed7dae0] [c0382068] schedule_timeout+0x1c0/0x304
Jul 13 15:31:48 jim kernel: [eed7db30] [c0381b7c] wait_for_common+0xd4/0x1c8
Jul 13 15:31:48 jim kernel: [eed7db70] [c005a0b8] flush_cpu_workqueue+0xdc/0x110
Jul 13 15:31:48 jim kernel: [eed7dbb0] [c022fc7c] tty_ldisc_release+0x2c/0x84
Jul 13 15:31:48 jim kernel: [eed7dbd0] [c0228374] tty_release+0x428/0x5b0
Jul 13 15:31:48 jim kernel: [eed7dc70] [c00fc410] fput+0x118/0x264
Jul 13 15:31:48 jim kernel: [eed7dc90] [c00f87d0] filp_close+0x6c/0x98
Jul 13 15:31:48 jim kernel: [eed7dcb0] [c0042958] put_files_struct+0x12c/0x158
Jul 13 15:31:48 jim kernel: [eed7dce0] [c0042b7c] do_exit+0x118/0x708
Jul 13 15:31:48 jim kernel: [eed7dd30] [c0015560] die+0x100/0x2c0
Jul 13 15:31:48 jim kernel: [eed7dd60] [c001f350] bad_page_fault+0x90/0xc8
Jul 13 15:31:48 jim kernel: [eed7dd70] [c001843c] handle_page_fault+0x7c/0x80
Jul 13 15:31:48 jim kernel: --- Exception: 300 at
__mutex_lock_slowpath+0xa0/0x274
Jul 13 15:31:48 jim kernel: LR = __mutex_lock_slowpath+0x8c/0x274
Jul 13 15:31:48 jim kernel: [eed7de30] [c0382dd0]
__mutex_lock_slowpath+0x7c/0x274 (unreliable)
Jul 13 15:31:48 jim kernel: [eed7de70] [c0382fe0] mutex_lock+0x18/0x34
Jul 13 15:31:48 jim kernel: [eed7de80] [f244d010] drm_fb_release+0x28/0xac [drm]
Jul 13 15:31:48 jim kernel: [eed7dea0] [f243fab8] drm_release+0x674/0x770 [drm]
Jul 13 15:31:48 jim kernel: [eed7dee0] [c00fc410] fput+0x118/0x264
Jul 13 15:31:48 jim kernel: [eed7df00] [c00f87d0] filp_close+0x6c/0x98
Jul 13 15:31:48 jim kernel: [eed7df20] [c00f88ac] sys_close+0xb0/0x12c
Jul 13 15:31:48 jim kernel: [eed7df40] [c0017f84] ret_from_syscall+0x0/0x40
Jul 13 15:31:48 jim kernel: --- Exception: c01 at 0xfec3730
Jul 13 15:31:48 jim kernel: LR = 0xf8b9340
Jul 13 15:33:09 jim kernel: Using PowerMac machine description
[Next boot..]


Many thanks
