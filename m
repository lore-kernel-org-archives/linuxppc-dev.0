Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s1mjW5my6zDrHn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jul 2016 23:32:15 +1000 (AEST)
Subject: [pasemi] problem with i2c-pasemi
To: luigi burdo <intermediadc@hotmail.com>,
 Darren Stevens <darren@stevens-zone.net>, Julian Margetson
 <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 wsa@the-dreams.de
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <576DAEAF.50106@xenosoft.de> <576EED63.2070702@xenosoft.de>
 <576EFD0F.50108@xenosoft.de> <5770F272.8000606@xenosoft.de>
 <577254E3.7080005@xenosoft.de>
 <3EEDD30A-C05E-4968-8328-44CFF909F663@xenosoft.de>
 <AM4PR01MB1538AEF7F7CCF2C62F2E7698C8230@AM4PR01MB1538.eurprd01.prod.exchangelabs.com>
 <5773AEFD.6070608@xenosoft.de>
 <AM4PR01MB1538D5E894F612122B81991AC8230@AM4PR01MB1538.eurprd01.prod.exchangelabs.com>
 <57752BB3.9060306@xenosoft.de>
 <7072d7cf-4d73-d424-af20-f5e94c8b399e@xenosoft.de>
 <816DC2B4-5B33-4C5E-A09A-F5BF7C7BF1FD@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <6ebc8c6f-ffee-ab4e-1ce1-bc29bf08569d@xenosoft.de>
Date: Sat, 30 Jul 2016 15:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Olof,

I compiled the latest git kernel 2 days ago. The kernel boots and works 
but unfortunately I get the following error messages about the 
i2c-pasemi during the start:

[    3.553461] i2c /dev entries driver
[    3.554462] couldn't get idr
[    3.554463] ------------[ cut here ]------------
[    3.554474] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.c:1789 
.__i2c_add_numbered_adapter+0x80/0xc0
[    3.554477] Modules linked in:
[    3.554482] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty #1
[    3.554485] task: c00000026d116d80 ti: c00000026d120000 task.ti: 
c00000026d120000
[    3.554487] NIP: c0000000007f1b70 LR: c0000000007f1b6c CTR: 
0000000000000000
[    3.554490] REGS: c00000026d123370 TRAP: 0700   Not tainted 
(4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty)
[    3.554502] MSR: 9000000002029032 <SF,HV,VEC,EE,ME,IR,DR,RI>  CR: 
42870d22  XER: 20000000
[    3.554540] SOFTE: 1
                GPR00: c0000000007f1b6c c00000026d1235f0 
c0000000017bc600 0000000000000010
                GPR04: 0000000000000001 0000000000000000 
0000000000000010 c0000000018ec600
                GPR08: 2067657420696472 0000000000000000 
0000000000000000 0000000000000030
                GPR12: 2067657420696472 c00000000ffff000 
c000000000009b10 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 c0000000016c86d8 
c000000001555110 0000000000000000
                GPR28: c000000001629ec8 c000000001628fc0 
ffffffffffffffe4 c00000026b16f408
[    3.554545] NIP [c0000000007f1b70] .__i2c_add_numbered_adapter+0x80/0xc0
[    3.554549] LR [c0000000007f1b6c] .__i2c_add_numbered_adapter+0x7c/0xc0
[    3.554551] Call Trace:
[    3.554557] [c00000026d1235f0] [c0000000007f1b6c] 
.__i2c_add_numbered_adapter+0x7c/0xc0 (unreliable)
[    3.554563] [c00000026d123680] [c0000000007f4b58] 
.pasemi_smb_probe+0x12c/0x188
[    3.554569] [c00000026d123710] [c0000000004b0fb0] 
.pci_device_probe+0x90/0x100
[    3.554576] [c00000026d1237a0] [c0000000006d3c10] 
.driver_probe_device+0x15c/0x2c8
[    3.554581] [c00000026d123840] [c0000000006d3e2c] 
.__driver_attach+0xb0/0xe0
[    3.554586] [c00000026d1238d0] [c0000000006d1920] 
.bus_for_each_dev+0xac/0xc0
[    3.554591] [c00000026d123970] [c0000000006d35ac] 
.driver_attach+0x34/0x40
[    3.554597] [c00000026d1239f0] [c0000000006d2ff4] 
.bus_add_driver+0x104/0x244
[    3.554602] [c00000026d123a90] [c0000000006d4758] 
.driver_register+0xc0/0x110
[    3.554608] [c00000026d123b20] [c0000000004b06f4] 
.__pci_register_driver+0x58/0x64
[    3.554615] [c00000026d123bb0] [c00000000153134c] 
.pasemi_smb_driver_init+0x24/0x38
[    3.554621] [c00000026d123c20] [c0000000000094ac] 
.do_one_initcall+0xd8/0x174
[    3.554626] [c00000026d123d00] [c0000000014eed98] 
.kernel_init_freeable+0x188/0x244
[    3.554632] [c00000026d123db0] [c000000000009b30] .kernel_init+0x20/0x130
[    3.554638] [c00000026d123e30] [c000000000007ee8] 
.ret_from_kernel_thread+0x58/0x70
[    3.554639] Instruction dump:
[    3.554648] 4bc8bac5 60000000 7c7e1b78 7fa3eb78 482e7ce1 60000000 
2f9e0000 409c002c
[    3.554657] 3c62ffc8 3863aaca 482eb255 60000000 <0fe00000> 2f9effe4 
3860fff0 419e002c
[    3.554661] ---[ end trace cac6a75782ca269c ]---
[    3.554673] i2c-pasemi: probe of 0000:00:1c.0 failed with error -16
[    3.554724] couldn't get idr
[    3.554725] ------------[ cut here ]------------
[    3.554733] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.c:1789 
.__i2c_add_numbered_adapter+0x80/0xc0
[    3.554735] Modules linked in:
[    3.554739] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G W 
4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty #1
[    3.554742] task: c00000026d116d80 ti: c00000026d120000 task.ti: 
c00000026d120000
[    3.554744] NIP: c0000000007f1b70 LR: c0000000007f1b6c CTR: 
0000000000000000
[    3.554747] REGS: c00000026d123370 TRAP: 0700   Tainted: G W 
(4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty)
[    3.554758] MSR: 9000000002029032 <SF,HV,VEC,EE,ME,IR,DR,RI>  CR: 
42870d22  XER: 20000000
[    3.554795] SOFTE: 1
                GPR00: c0000000007f1b6c c00000026d1235f0 
c0000000017bc600 0000000000000010
                GPR04: 0000000000000001 0000000000000000 
0000000000000010 c0000000018ec600
                GPR08: 2067657420696472 0000000000000000 
0000000000000000 0000000000000030
                GPR12: 2067657420696472 c00000000ffff000 
c000000000009b10 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 c0000000016c86d8 
c000000001555110 0000000000000000
                GPR28: c000000001629ec8 c000000001628fc0 
ffffffffffffffe4 c00000026b16f408
[    3.554800] NIP [c0000000007f1b70] .__i2c_add_numbered_adapter+0x80/0xc0
[    3.554805] LR [c0000000007f1b6c] .__i2c_add_numbered_adapter+0x7c/0xc0
[    3.554806] Call Trace:
[    3.554812] [c00000026d1235f0] [c0000000007f1b6c] 
.__i2c_add_numbered_adapter+0x7c/0xc0 (unreliable)
[    3.554818] [c00000026d123680] [c0000000007f4b58] 
.pasemi_smb_probe+0x12c/0x188
[    3.554823] [c00000026d123710] [c0000000004b0fb0] 
.pci_device_probe+0x90/0x100
[    3.554829] [c00000026d1237a0] [c0000000006d3c10] 
.driver_probe_device+0x15c/0x2c8
[    3.554834] [c00000026d123840] [c0000000006d3e2c] 
.__driver_attach+0xb0/0xe0
[    3.554839] [c00000026d1238d0] [c0000000006d1920] 
.bus_for_each_dev+0xac/0xc0
[    3.554844] [c00000026d123970] [c0000000006d35ac] 
.driver_attach+0x34/0x40
[    3.554850] [c00000026d1239f0] [c0000000006d2ff4] 
.bus_add_driver+0x104/0x244
[    3.554855] [c00000026d123a90] [c0000000006d4758] 
.driver_register+0xc0/0x110
[    3.554861] [c00000026d123b20] [c0000000004b06f4] 
.__pci_register_driver+0x58/0x64
[    3.554867] [c00000026d123bb0] [c00000000153134c] 
.pasemi_smb_driver_init+0x24/0x38
[    3.554873] [c00000026d123c20] [c0000000000094ac] 
.do_one_initcall+0xd8/0x174
[    3.554878] [c00000026d123d00] [c0000000014eed98] 
.kernel_init_freeable+0x188/0x244
[    3.554883] [c00000026d123db0] [c000000000009b30] .kernel_init+0x20/0x130
[    3.554889] [c00000026d123e30] [c000000000007ee8] 
.ret_from_kernel_thread+0x58/0x70
[    3.554891] Instruction dump:
[    3.554899] 4bc8bac5 60000000 7c7e1b78 7fa3eb78 482e7ce1 60000000 
2f9e0000 409c002c
[    3.554907] 3c62ffc8 3863aaca 482eb255 60000000 <0fe00000> 2f9effe4 
3860fff0 419e002c
[    3.554909] ---[ end trace cac6a75782ca269d ]---
[    3.554919] i2c-pasemi: probe of 0000:00:1c.1 failed with error -16
[    3.554968] couldn't get idr
[    3.554969] ------------[ cut here ]------------
[    3.554977] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.c:1789 
.__i2c_add_numbered_adapter+0x80/0xc0
[    3.554979] Modules linked in:
[    3.554983] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G W 
4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty #1
[    3.554986] task: c00000026d116d80 ti: c00000026d120000 task.ti: 
c00000026d120000
[    3.554988] NIP: c0000000007f1b70 LR: c0000000007f1b6c CTR: 
0000000000000000
[    3.554991] REGS: c00000026d123370 TRAP: 0700   Tainted: G W 
(4.8.0_a1_A-EON_AmigaONE_X1000_Nemo-05906-g194dc87-dirty)
[    3.555001] MSR: 9000000002029032 <SF,HV,VEC,EE,ME,IR,DR,RI>  CR: 
42870d22  XER: 20000000
[    3.555038] SOFTE: 1
                GPR00: c0000000007f1b6c c00000026d1235f0 
c0000000017bc600 0000000000000010
                GPR04: 0000000000000001 0000000000000000 
0000000000000010 c0000000018ec600
                GPR08: 2067657420696472 0000000000000000 
0000000000000000 0000000000000030
                GPR12: 2067657420696472 c00000000ffff000 
c000000000009b10 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 c0000000016c86d8 
c000000001555110 0000000000000000
                GPR28: c000000001629ec8 c000000001628fc0 
ffffffffffffffe4 c00000026b16f408
[    3.555043] NIP [c0000000007f1b70] .__i2c_add_numbered_adapter+0x80/0xc0
[    3.555047] LR [c0000000007f1b6c] .__i2c_add_numbered_adapter+0x7c/0xc0
[    3.555048] Call Trace:
[    3.555055] [c00000026d1235f0] [c0000000007f1b6c] 
.__i2c_add_numbered_adapter+0x7c/0xc0 (unreliable)
[    3.555060] [c00000026d123680] [c0000000007f4b58] 
.pasemi_smb_probe+0x12c/0x188
[    3.555065] [c00000026d123710] [c0000000004b0fb0] 
.pci_device_probe+0x90/0x100
[    3.555071] [c00000026d1237a0] [c0000000006d3c10] 
.driver_probe_device+0x15c/0x2c8
[    3.555076] [c00000026d123840] [c0000000006d3e2c] 
.__driver_attach+0xb0/0xe0
[    3.555082] [c00000026d1238d0] [c0000000006d1920] 
.bus_for_each_dev+0xac/0xc0
[    3.555087] [c00000026d123970] [c0000000006d35ac] 
.driver_attach+0x34/0x40
[    3.555092] [c00000026d1239f0] [c0000000006d2ff4] 
.bus_add_driver+0x104/0x244
[    3.555097] [c00000026d123a90] [c0000000006d4758] 
.driver_register+0xc0/0x110
[    3.555103] [c00000026d123b20] [c0000000004b06f4] 
.__pci_register_driver+0x58/0x64
[    3.555109] [c00000026d123bb0] [c00000000153134c] 
.pasemi_smb_driver_init+0x24/0x38
[    3.555115] [c00000026d123c20] [c0000000000094ac] 
.do_one_initcall+0xd8/0x174
[    3.555120] [c00000026d123d00] [c0000000014eed98] 
.kernel_init_freeable+0x188/0x244
[    3.555126] [c00000026d123db0] [c000000000009b30] .kernel_init+0x20/0x130
[    3.555131] [c00000026d123e30] [c000000000007ee8] 
.ret_from_kernel_thread+0x58/0x70
[    3.555133] Instruction dump:
[    3.555141] 4bc8bac5 60000000 7c7e1b78 7fa3eb78 482e7ce1 60000000 
2f9e0000 409c002c
[    3.555149] 3c62ffc8 3863aaca 482eb255 60000000 <0fe00000> 2f9effe4 
3860fff0 419e002c
[    3.555151] ---[ end trace cac6a75782ca269e ]---
[    3.555161] i2c-pasemi: probe of 0000:00:1c.2 failed with error -16

The commit "Merge branch 'i2c/for-4.8'" is the problem. Link: 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=66304207cd341045df34195b4a8d422075bff513

I reverted the i2c commit with:

git revert 66304207cd341045df34195b4a8d422075bff513 -m 1

After that I was able to compile it. It boots without the error messages 
about the i2c-pasemi.

Do we need to modify the "i2c-pasemi.c"?

Cheers,

Christian
