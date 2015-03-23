Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 588821A05F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 06:28:38 +1100 (AEDT)
Received: by yhjf44 with SMTP id f44so74091190yhj.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 12:28:36 -0700 (PDT)
MIME-Version: 1.0
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 23 Mar 2015 15:28:05 -0400
Message-ID: <CAJhHMCDB-ymUnUqED6=c2L-wju0ZTW=OTfw3Jqwie44FqmkV=Q@mail.gmail.com>
Subject: frequent lockups on ppc32
To: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I see frequent lockups with the latest rc5 kernel on a mac mini power
pc 32 system. I see the following in dmesg. I could git bisect, but
was wondering if you guys have seen this before and if anyone has any
pointers which can reduce my bisect search space.

Thanks!

[ 5735.022209] Unable to handle kernel paging request for data at
address 0x002800bc
[ 5735.022223] Faulting instruction address: 0xc00fa01c
[ 5735.022232] Oops: Kernel access of bad area, sig: 11 [#1]
[ 5735.022307] PowerMac
[ 5735.022335] Modules linked in: uinput radeon ttm drm_kms_helper drm
evdev snd_aoa_codec_tas snd_aoa_codec_toonie snd_aoa_fabric_layout
snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_powermac snd_pcm snd_timer
snd soundcore loop fuse autofs4 ext4 mbcache jbd2 sg ohci_pci
firewire_ohci sungem sungem_phy firewire_core sr_mod cdrom sd_mod
ehci_pci ohci_hcd ehci_hcd usbcore usb_common
[ 5735.022786] CPU: 0 PID: 28783 Comm: make Not tainted 4.0.0-rc5 #75
[ 5735.022851] task: eea69770 ti: d03be000 task.ti: d03be000
[ 5735.022906] NIP: c00fa01c LR: c00efe14 CTR: 00000000
[ 5735.022959] REGS: d03bfc90 TRAP: 0300   Not tainted  (4.0.0-rc5)
[ 5735.023020] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 44022224  XER: 20000000
[ 5735.023114] DAR: 002800bc DSISR: 40000000
GPR00: c00efe14 d03bfd40 eea69770 ecc96210 d03bfe40 00000000 00000000 c05aa334
GPR08: c05b0000 00000000 ef654000 d03bfdb0 24022422 1004a930 00000000 10040000
GPR16: 00000000 100b2b10 00000000 10040000 10030194 100429e0 10040000 00000000
GPR24: 00000008 c1dfa032 d03bfd78 f6f113ca d03bfe40 ecc96210 002800b8 002800c0
[ 5735.023528] NIP [c00fa01c] __d_lookup_rcu+0x68/0x128
[ 5735.023585] LR [c00efe14] lookup_fast+0x40/0x288
[ 5735.023633] Call Trace:
[ 5735.023662] [d03bfd40] [c00eec18] __inode_permission+0x70/0xbc (unreliable)
[ 5735.023739] [d03bfd70] [c00efe14] lookup_fast+0x40/0x288
[ 5735.023796] [d03bfdb0] [c00f1004] path_lookupat+0xbc/0x654
[ 5735.023855] [d03bfe10] [c00f15c8] filename_lookup+0x2c/0xa8
[ 5735.023916] [d03bfe30] [c00f3828] user_path_at_empty+0x60/0x90
[ 5735.023985] [d03bfeb0] [c00e9cc8] vfs_fstatat+0x58/0x9c
[ 5735.024041] [d03bfee0] [c00ea4a4] SyS_stat64+0x1c/0x38
[ 5735.024099] [d03bff40] [c00113b4] ret_from_syscall+0x0/0x40
[ 5735.024163] --- interrupt: c01 at 0xfc59760
    LR = 0x10020ca0
[ 5735.024237] Instruction dump:
[ 5735.024271] 7d29da14 83240008 7d4951d6 81270004 21290020 7d494c30
8148a334 5529103a
[ 5735.024369] 7fea482e 2f9f0000 419e00bc 3bdffff8 <80bffffc> 813f0008
7f9d4800 40be0098
[ 5735.048904] ---[ end trace 7b70a99f1f56d6ab ]---

[ 6029.453156] Unable to handle kernel paging request for data at
address 0x002800bc
[ 6029.453170] Faulting instruction address: 0xc00fa01c
[ 6029.453179] Oops: Kernel access of bad area, sig: 11 [#2]
[ 6029.453252] PowerMac
[ 6029.453279] Modules linked in: uinput radeon ttm drm_kms_helper drm
evdev snd_aoa_codec_tas snd_aoa_codec_toonie snd_aoa_fabric_layout
snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_powermac snd_pcm snd_timer
snd soundcore loop fuse autofs4 ext4 mbcache jbd2 sg ohci_pci
firewire_ohci sungem sungem_phy firewire_core sr_mod cdrom sd_mod
ehci_pci ohci_hcd ehci_hcd usbcore usb_common
[ 6029.453732] CPU: 0 PID: 29103 Comm: make Tainted: G      D
4.0.0-rc5 #75
[ 6029.453809] task: c788c770 ti: e6570000 task.ti: e6570000
[ 6029.453865] NIP: c00fa01c LR: c00efe14 CTR: 00000000
[ 6029.453917] REGS: e6571c90 TRAP: 0300   Tainted: G      D
(4.0.0-rc5)
[ 6029.453989] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 44022224  XER: 20000000
[ 6029.454084] DAR: 002800bc DSISR: 40000000
GPR00: c00efe14 e6571d40 c788c770 ecc96210 e6571e40 00000000 00000000 c05aa334
GPR08: c05b0000 00000000 ef654000 e6571db0 24022222 1004a930 00000000 10040000
GPR16: 00000000 1024ddc8 00000000 10040000 10030194 100429e0 10040000 00000000
GPR24: 00000008 c1c8f032 e6571d78 f6f113ca e6571e40 ecc96210 002800b8 002800c0
[ 6029.454497] NIP [c00fa01c] __d_lookup_rcu+0x68/0x128
[ 6029.454554] LR [c00efe14] lookup_fast+0x40/0x288
[ 6029.454602] Call Trace:
[ 6029.454631] [e6571d40] [c00eec18] __inode_permission+0x70/0xbc (unreliable)
[ 6029.454708] [e6571d70] [c00efe14] lookup_fast+0x40/0x288
[ 6029.454766] [e6571db0] [c00f1004] path_lookupat+0xbc/0x654
[ 6029.454825] [e6571e10] [c00f15c8] filename_lookup+0x2c/0xa8
[ 6029.454885] [e6571e30] [c00f3828] user_path_at_empty+0x60/0x90
[ 6029.454955] [e6571eb0] [c00e9cc8] vfs_fstatat+0x58/0x9c
[ 6029.455012] [e6571ee0] [c00ea4a4] SyS_stat64+0x1c/0x38
[ 6029.455069] [e6571f40] [c00113b4] ret_from_syscall+0x0/0x40
[ 6029.455133] --- interrupt: c01 at 0xfc59760
    LR = 0x10020ca0
[ 6029.455207] Instruction dump:
[ 6029.455241] 7d29da14 83240008 7d4951d6 81270004 21290020 7d494c30
8148a334 5529103a
[ 6029.455339] 7fea482e 2f9f0000 419e00bc 3bdffff8 <80bffffc> 813f0008
7f9d4800 40be0098
[ 6029.455442] ---[ end trace 7b70a99f1f56d6ac ]---

[ 6085.014642] Unable to handle kernel paging request for data at
address 0x002800bc
[ 6085.014656] Faulting instruction address: 0xc00fa01c
[ 6085.014664] Oops: Kernel access of bad area, sig: 11 [#3]
[ 6085.014737] PowerMac
[ 6085.014764] Modules linked in: uinput radeon ttm drm_kms_helper drm
evdev snd_aoa_codec_tas snd_aoa_codec_toonie snd_aoa_fabric_layout
snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_powermac snd_pcm snd_timer
snd soundcore loop fuse autofs4 ext4 mbcache jbd2 sg ohci_pci
firewire_ohci sungem sungem_phy firewire_core sr_mod cdrom sd_mod
ehci_pci ohci_hcd ehci_hcd usbcore usb_common
[ 6085.015216] CPU: 0 PID: 29136 Comm: make Tainted: G      D
4.0.0-rc5 #75
[ 6085.015293] task: c7ac0770 ti: c1d60000 task.ti: c1d60000
[ 6085.015349] NIP: c00fa01c LR: c00efe14 CTR: 00000000
[ 6085.019439] REGS: c1d61c90 TRAP: 0300   Tainted: G      D
(4.0.0-rc5)
[ 6085.023481] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 42022224  XER: 20000000
[ 6085.027427] DAR: 002800bc DSISR: 40000000
GPR00: c00efe14 c1d61d40 c7ac0770 ecc96210 c1d61e40 00000000 00000000 c05aa334
GPR08: c05b0000 00000000 ef654000 c1d61db0 22022222 1004a930 00000000 10040000
GPR16: 00000000 10233920 00000000 10040000 10030194 100429e0 10040000 00000000
GPR24: 00000008 c1df1032 c1d61d78 f6f113ca c1d61e40 ecc96210 002800b8 002800c0
[ 6085.046247] NIP [c00fa01c] __d_lookup_rcu+0x68/0x128
[ 6085.049987] LR [c00efe14] lookup_fast+0x40/0x288
[ 6085.053706] Call Trace:
[ 6085.057384] [c1d61d40] [c00eec18] __inode_permission+0x70/0xbc (unreliable)
[ 6085.061121] [c1d61d70] [c00efe14] lookup_fast+0x40/0x288
[ 6085.064843] [c1d61db0] [c00f1004] path_lookupat+0xbc/0x654
[ 6085.068549] [c1d61e10] [c00f15c8] filename_lookup+0x2c/0xa8
[ 6085.072228] [c1d61e30] [c00f3828] user_path_at_empty+0x60/0x90
[ 6085.075914] [c1d61eb0] [c00e9cc8] vfs_fstatat+0x58/0x9c
[ 6085.079587] [c1d61ee0] [c00ea4a4] SyS_stat64+0x1c/0x38
[ 6085.083236] [c1d61f40] [c00113b4] ret_from_syscall+0x0/0x40
[ 6085.086883] --- interrupt: c01 at 0xfc59760
    LR = 0x10020ca0
[ 6085.094143] Instruction dump:
[ 6085.097755] 7d29da14 83240008 7d4951d6 81270004 21290020 7d494c30
8148a334 5529103a
[ 6085.101457] 7fea482e 2f9f0000 419e00bc 3bdffff8 <80bffffc> 813f0008
7f9d4800 40be0098
[ 6085.105194] ---[ end trace 7b70a99f1f56d6ad ]---

[ 6317.864818] Unable to handle kernel paging request for data at
address 0x002800bc
[ 6317.864832] Faulting instruction address: 0xc00fa01c
[ 6317.864841] Oops: Kernel access of bad area, sig: 11 [#4]
[ 6317.868670] PowerMac
[ 6317.872365] Modules linked in: uinput radeon ttm drm_kms_helper drm
evdev snd_aoa_codec_tas snd_aoa_codec_toonie snd_aoa_fabric_layout
snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_powermac snd_pcm snd_timer
snd soundcore loop fuse autofs4 ext4 mbcache jbd2 sg ohci_pci
firewire_ohci sungem sungem_phy firewire_core sr_mod cdrom sd_mod
ehci_pci ohci_hcd ehci_hcd usbcore usb_common
[ 6317.880595] CPU: 0 PID: 30103 Comm: make Tainted: G      D
4.0.0-rc5 #75
[ 6317.884692] task: e649d770 ti: c1f8a000 task.ti: c1f8a000
[ 6317.888766] NIP: c00fa01c LR: c00efe14 CTR: 00000000
[ 6317.892811] REGS: c1f8bc90 TRAP: 0300   Tainted: G      D
(4.0.0-rc5)
[ 6317.896884] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 44022224  XER: 20000000
[ 6317.900863] DAR: 002800bc DSISR: 40000000
GPR00: c00efe14 c1f8bd40 e649d770 ecc96210 c1f8be40 00000000 00000000 c05aa334
GPR08: c05b0000 00000000 ef654000 c1f8bdb0 24022222 1004a930 00000000 10040000
GPR16: 00000000 100a5420 00000000 10040000 10030194 100429e0 10040000 00000000
GPR24: 00000008 c1e2a032 c1f8bd78 f6f113ca c1f8be40 ecc96210 002800b8 002800c0
[ 6317.919838] NIP [c00fa01c] __d_lookup_rcu+0x68/0x128
[ 6317.923602] LR [c00efe14] lookup_fast+0x40/0x288
[ 6317.927345] Call Trace:
[ 6317.931044] [c1f8bd40] [c00eec18] __inode_permission+0x70/0xbc (unreliable)
[ 6317.934804] [c1f8bd70] [c00efe14] lookup_fast+0x40/0x288
[ 6317.938546] [c1f8bdb0] [c00f1004] path_lookupat+0xbc/0x654
[ 6317.942275] [c1f8be10] [c00f15c8] filename_lookup+0x2c/0xa8
[ 6317.945974] [c1f8be30] [c00f3828] user_path_at_empty+0x60/0x90
[ 6317.949680] [c1f8beb0] [c00e9cc8] vfs_fstatat+0x58/0x9c
[ 6317.953374] [c1f8bee0] [c00ea4a4] SyS_stat64+0x1c/0x38
[ 6317.957042] [c1f8bf40] [c00113b4] ret_from_syscall+0x0/0x40
[ 6317.960707] --- interrupt: c01 at 0xfc59760
    LR = 0x10020ca0
[ 6317.968007] Instruction dump:
[ 6317.971643] 7d29da14 83240008 7d4951d6 81270004 21290020 7d494c30
8148a334 5529103a
[ 6317.975364] 7fea482e 2f9f0000 419e00bc 3bdffff8 <80bffffc> 813f0008
7f9d4800 40be0098
[ 6317.979121] ---[ end trace 7b70a99f1f56d6ae ]---



-- 
Pranith
