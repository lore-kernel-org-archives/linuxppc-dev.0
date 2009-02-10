Return-Path: <wartan.hachaturow@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 7E444DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 22:18:20 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so1340060fgb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 03:18:18 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 10 Feb 2009 14:18:18 +0300
Message-ID: <4aaa2e1c0902100318l376be033g26d67ed88450a6e8@mail.gmail.com>
Subject: 2.6.28 radeon.ko oops, QS22 (Cell) blade.
From: Wartan Hachaturow <wartan.hachaturow@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there.

While trying to bring up X.org on this beast, I've stumbled upon this
oops in radeon.ko
(right on the first write attempt):

[drm] Initialized drm 1.1.0 20060810
pci 0005:01:00.0: enabling device (0140 -> 0143)
[drm] Initialized radeon 1.29.0 20080528 on minor 0
[drm] Setting GART location based on new memory map
[drm] GART aligned down from 0x04010000 to 0x04000000
[drm] Loading R500 Microcode
[drm] Num pipes: 1
[drm] writeback test failed
[drm] BEGIN_RING( 8 )
[drm]    OUT_RING( 0x000005c9 ) at 0x6402505
Unable to handle kernel paging request for data at address 0xd00000001a04c414
Faulting instruction address: 0xd000000000fd6d68
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA Cell
Modules linked in: radeon drm sunrpc pmi tg3 mptsas mptscsih mptbase
scsi_transport_sas
NIP: d000000000fd6d68 LR: d000000000fd6d54 CTR: 0000000000000001
REGS: c0000000fb4f38b0 TRAP: 0300   Not tainted  (2.6.28-lks-wks-alt1)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 24004424  XER: 20000000
DAR: d00000001a04c414, DSISR: 0000000042000000
TASK = c0000000fb4e4f50[4088] 'X' THREAD: c0000000fb4f0000 CPU: 2
GPR00: 00000000000005c9 c0000000fb4f3b30 d000000001016c80 d000000000fff578
GPR04: 0000000000000000 ffffffffffffffff c00000000097d6b0 c000000000805554
GPR08: 000000000001ffff 0000000019009414 c00000000097d6b4 0000000000000001
GPR12: d000000000ffab80 c000000000952800 0000000000000005 0000000000000000
GPR16: 00000000100b3e50 0000000010090000 0000000010080000 0000000010090000
GPR20: 00000000100b3e80 0000000000000000 0000000000000006 0000000000000000
GPR24: ffffffffffffffea d000000001043000 c0000000fecba000 000000000003ffff
GPR28: d000000000fff578 0000000006402506 d000000001015b38 c0000000fecbf000
NIP [d000000000fd6d68] .radeon_cp_start+0x358/0x73c [radeon]
LR [d000000000fd6d54] .radeon_cp_start+0x344/0x73c [radeon]
Call Trace:
[c0000000fb4f3b30] [d000000000fd6d54] .radeon_cp_start+0x344/0x73c [radeon]
(unreliable)
[c0000000fb4f3be0] [d000000000d9cbbc] .drm_ioctl+0x230/0x300 [drm]
[c0000000fb4f3ca0] [d000000000ff8e98] .radeon_compat_ioctl+0xb4/0xfc [radeon]
[c0000000fb4f3d40] [c000000000189944] .compat_sys_ioctl+0x140/0x488
[c0000000fb4f3e30] [c000000000008570] syscall_exit+0x0/0x40
Instruction dump:
388005c9 837a002c 3929ffe0 7fa5eb78 7f83e378 913a0030 48023e31 e8410028
7ba91764 380005c9 3bbd0001 7f83e378 <7c19492e> 38800033 7fbdd838 7fbd07b4
---[ end trace b46b031df5997cbf ]---
[drm:drm_release] *ERROR* Device busy: 1 0

Any quick ideas for me to check? The ring address seems to be quite strange.

-- 
Regards, Wartan.
