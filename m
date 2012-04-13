Return-Path: <anton@samba.org>
Date: Fri, 13 Apr 2012 12:03:46 +1000
From: Anton Blanchard <anton@samba.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/21] EEH reorganization
Message-ID: <20120413120346.42e01402@kryten>
In-Reply-To: <20120413073931.0c36169b@kryten>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20120413073931.0c36169b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> I just hit this on mainline from today (3.4.0-rc2-00065-gf549e08).
> Haven't had a chance to narrow it down yet.

Looking closer, it was caused by an EEH error at boot. It looks like
the Mellanox infiniband card gets an error when probed by their
firmware tool (mstmread), but only if the kernel driver is not loaded.
I see this EEH error back on 3.0, so it's not new.

The question now is why we oops in the EEH code on mainline.

Anton

------------[ cut here ]------------
WARNING: at arch/powerpc/platforms/pseries/eeh.c:492
Modules linked in:
NIP: c000000000056cc4 LR: c000000000056cc0 CTR: c00000000051dd60
REGS: c000001f3953f6a0 TRAP: 0700   Not tainted  (3.4.0-rc2-00065-gf549e08-dirty)
MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 28004482  XER: 0000000f
SOFTE: 0
CFAR: c00000000074ea30
TASK = c000001f39685040[19058] 'mstmread' THREAD: c000001f3953c000 CPU: 38
GPR00: c000000000056cc0 c000001f3953f920 c000000000bd3a28 0000000000000021 
GPR04: 0000000000000000 ffffffffffffffff 00000000000323f7 0000000000000000 
GPR08: 000000006365203c c000000000b10a20 0000000000020000 c000000000a74cc0 
GPR12: 0000000024004422 c00000000eda8500 000000003a58582e 00000000583a5858 
GPR16: 000000002f585858 0000000069636573 000000002f646576 0000000010003b48 
GPR20: 00000fffc7a3d17c 0000000000000058 0000000000000004 c000001f3953fb90 
GPR24: 0000000000000000 0000000000000000 c000000000c77088 c000003e6fffeee8 
GPR28: c000000000d82680 0000000000000000 c000000000c770d0 0000000000000000 
NIP [c000000000056cc4] .eeh_dn_check_failure+0x304/0x320
LR [c000000000056cc0] .eeh_dn_check_failure+0x300/0x320
Call Trace:
[c000001f3953f920] [c000000000056cc0] .eeh_dn_check_failure+0x300/0x320 (unreliable)
[c000001f3953f9d0] [c00000000002717c] .rtas_read_config+0x13c/0x1b0
[c000001f3953fa70] [c0000000003d543c] .pci_user_read_config_dword+0xcc/0x150
[c000001f3953fb20] [c0000000003e19d8] .pci_read_config+0xe8/0x2a0
[c000001f3953fc00] [c00000000022d330] .read+0x130/0x210
[c000001f3953fce0] [c0000000001a723c] .vfs_read+0xec/0x1e0
[c000001f3953fd80] [c0000000001a73ec] .SyS_pread64+0xbc/0xd0
[c000001f3953fe30] [c000000000009780] syscall_exit+0x0/0x7c
Instruction dump:
7f83e378 48001909 60000000 2fbf0000 419e002c e89f00d8 2fa40000 409e0008 
e89f0098 e8629fb8 486f7d39 60000000 <0fe00000> 3b200001 4bfffdb4 e8829fa8 
---[ end trace a6e6d788c9869e00 ]---
EEH: Detected PCI bus error on device 0006:01:00.0
EEH: This PCI device has failed 1 times in the last hour:
EEH: Bus location=U78AB.001.WZSGRFL-P1-C4-T1 driver= pci addr=0006:01:00.0
EEH: Device location=U78AB.001.WZSGRFL-P1-C4-T1 driver= pci addr=0006:01:00.0
EEH: of node=/pci@800000020000203/pci1014,415@0
EEH: PCI device/vendor: 673c15b3
EEH: PCI cmd/status register: 00100140
