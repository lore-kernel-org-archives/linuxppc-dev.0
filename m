Return-Path: <jstancek@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5CCA1A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 10:06:08 +1100 (AEDT)
Date: Sat, 9 Jan 2016 18:03:55 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: raghavendra.kt@linux.vnet.ibm.com, vdavydov@parallels.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, nacc@linux.vnet.ibm.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 Steve Best <sbest@redhat.com>, Gustavo Duarte <gduarte@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <1258383100.6297154.1452380635681.JavaMail.zimbra@redhat.com>
In-Reply-To: <1477405602.6296768.1452378871633.JavaMail.zimbra@redhat.com>
Subject: [BUG] PowerNV crash with 4.4.0-rc8 at sched_init_numa (related to
 commit c118baf80256)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm seeing bare metal ppc64le system crashing early during boot
with latest upstream kernel (4.4.0-rc8):

# git describe
v4.4-rc8-96-g751e5f5

[    0.625451] Unable to handle kernel paging request for data at address 0x00000000
[    0.625586] Faulting instruction address: 0xc0000000004ae000
[    0.625698] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.625789] SMP NR_CPUS=2048 NUMA PowerNV
[    0.625879] Modules linked in:
[    0.625973] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc8+ #6
[    0.626087] task: c000002ff4300000 ti: c000002ff6084000 task.ti: c000002ff6084000
[    0.626224] NIP: c0000000004ae000 LR: c00000000090b9e4 CTR: 0000000000000003
[    0.626361] REGS: c000002ff6087930 TRAP: 0300   Not tainted  (4.4.0-rc8+)
[    0.626475] MSR: 9000000100009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48002044  XER: 20000000
[    0.626808] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 1
GPR00: c00000000090b9ac c000002ff6087bb0 c000000001700900 c000003ff229e080
GPR04: c000003ff229e080 0000000000000000 0000000000000003 0000000000000001
GPR08: 0000000000000000 0000000000000000 0000000000000010 9000000100001003
GPR12: 0000000000002200 c00000000fb40000 c00000000000bd68 0000000000000002
GPR16: 0000000000000028 c000000000b25940 c00000000173ffa4 0000000000000000
GPR20: c000000000b259d8 c000000000b259e0 c000000000b259e8 0000000000000000
GPR24: c000003ff229e080 0000000000000000 c00000000189b180 0000000000000000
GPR28: 0000000000000000 c000000001740a94 0000000000000002 0000000000000002
[    0.627925] NIP [c0000000004ae000] __bitmap_or+0x30/0x50
[    0.627973] LR [c00000000090b9e4] sched_init_numa+0x440/0x7c8
[    0.628030] Call Trace:
[    0.628054] [c000002ff6087bb0] [c00000000090b9ac] sched_init_numa+0x408/0x7c8 (unreliable)
[    0.628136] [c000002ff6087ca0] [c000000000c60718] sched_init_smp+0x60/0x238
[    0.628206] [c000002ff6087d00] [c000000000c44294] kernel_init_freeable+0x1fc/0x3b4
[    0.628286] [c000002ff6087dc0] [c00000000000bd84] kernel_init+0x24/0x140
[    0.628356] [c000002ff6087e30] [c000000000009544] ret_from_kernel_thread+0x5c/0x98
[    0.628435] Instruction dump:
[    0.628470] 38c6003f 78c9d183 4d820020 38c9ffff 39200000 78c60020 38c60001 7cc903a6
[    0.628587] 60000000 60000000 60000000 60420000 <7d05482a> 7d44482a 7d0a5378 7d43492a
[    0.628711] ---[ end trace b423f3e02b333fbf ]---
[    0.628757]
[    2.628822] Kernel panic - not syncing: Fatal exception
[    2.628969] Rebooting in 10 seconds..[    0.000000] OPAL V3 detected !

# numactl -H
available: 4 nodes (0-1,16-17)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 0 size: 64941 MB
node 0 free: 64210 MB
node 1 cpus: 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
node 1 size: 65456 MB
node 1 free: 62424 MB
node 16 cpus: 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
node 16 size: 65457 MB
node 16 free: 65258 MB
node 17 cpus: 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151
node 17 size: 65186 MB
node 17 free: 65001 MB
node distances:
node   0   1  16  17
  0:  10  20  40  40
  1:  20  10  40  40
 16:  40  40  10  20
 17:  40  40  20  10

The crash goes away if I revert following commit:
  commit c118baf802562688d46e6002f2b5fe66b947da21
  Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
  Date:   Thu Nov 5 18:46:29 2015 -0800
    arch/powerpc/mm/numa.c: do not allocate bootmem memory for non existing nodes

Regards,
Jan
