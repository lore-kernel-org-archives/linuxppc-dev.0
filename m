Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxWWM6Rb0zDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 04:25:03 +1000 (AEST)
Received: by mail-pg0-x236.google.com with SMTP id j16so278080pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 11:25:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 19 Sep 2017 11:24:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Traceback due to 'powerpc/mm: Fix kernel RAM protection...' when
 running ppc image in qemu
Message-ID: <20170919182459.GA7933@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I see a the following traceback when running an SMP image based on
85xx/mpc85xx_cds_defconfig in qemu.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/smp.c:416 smp_call_function_many+0xcc/0x2fc
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc1-00009-g0666f56 #1
task: cf830000 task.stack: cf82e000
NIP:  c00a93c8 LR: c00a9634 CTR: 00000001
REGS: cf82fde0 TRAP: 0700   Not tainted  (4.14.0-rc1-00009-g0666f56)
MSR:  00021000 <CE,ME>  CR: 24000082  XER: 00000000

GPR00: c00a9634 cf82fe90 cf830000 c050ad3c c0015a54 00000000 00000001 00000001 
GPR08: 00000001 00000000 00000000 cf82e000 24000084 00000000 c0003150 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00000001 00000000 c0510000 
GPR24: 00000000 c0015a54 00000000 c050ad3c c051823c c050ad3c 00000025 00000000 
NIP [c00a93c8] smp_call_function_many+0xcc/0x2fc
LR [c00a9634] smp_call_function+0x3c/0x50
Call Trace:
[cf82fe90] [00000010] 0x10 (unreliable)
[cf82fed0] [c00a9634] smp_call_function+0x3c/0x50
[cf82fee0] [c0015d2c] flush_tlb_kernel_range+0x20/0x38
[cf82fef0] [c001524c] mark_initmem_nx+0x154/0x16c
[cf82ff20] [c001484c] free_initmem+0x20/0x4c
[cf82ff30] [c000316c] kernel_init+0x1c/0x108
[cf82ff40] [c000f3a8] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
7c0803a6 7d808120 38210040 4e800020 3d20c052 812981a0 2f890000 40beffac 
3d20c051 8929ac64 2f890000 40beff9c <0fe00000> 4bffff94 7fc3f378 7f64db78 
---[ end trace 7da7bdcf8b15ddb3 ]---

A complete log is available at:
http://kerneltests.org/builders/qemu-ppc-master/builds/814/steps/qemubuildcommand/logs/stdio

Bisect points to commit 3184cc4b6f6a1dc0 ("powerpc/mm: Fix kernel RAM protection
after freeing unused memory on PPC32"). Bisect log is attached. A quick look
suggests that mark_initmem_nx() is called with interrupts disabled, which
triggers the traceback.

Guenter

---
# bad: [ebb2c2437d8008d46796902ff390653822af6cc4] Merge tag 'mmc-v4.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
# good: [e7d0c41ecc2e372a81741a30894f556afec24315] Merge tag 'devprop-4.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect start 'HEAD' 'e7d0c41ecc2e'
# bad: [c0da4fa0d1a54495d6055c009ac46b76d1da2c86] Merge tag 'media/v4.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad c0da4fa0d1a54495d6055c009ac46b76d1da2c86
# good: [aae3dbb4776e7916b6cd442d00159bea27a695c1] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good aae3dbb4776e7916b6cd442d00159bea27a695c1
# bad: [3645e6d0dc80be4376f87acc9ee527768387c909] Merge tag 'md/4.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shli/md
git bisect bad 3645e6d0dc80be4376f87acc9ee527768387c909
# bad: [bac65d9d87b383471d8d29128319508d71b74180] Merge tag 'powerpc-4.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad bac65d9d87b383471d8d29128319508d71b74180
# good: [57e88b43b81301d9b28f124a5576ac43a1cf9e8d] Merge branch 'x86-platform-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 57e88b43b81301d9b28f124a5576ac43a1cf9e8d
# bad: [f9065c83ccf4a6c1ff5419d216ad8276e99bee6c] powerpc/configs: Explicitly drop CONFIG_INPUT_MOUSEDEV
git bisect bad f9065c83ccf4a6c1ff5419d216ad8276e99bee6c
# good: [ea16e83aec40f9110be9cb0c3398ef41ae890ca6] powerpc/cpm1: link to CONFIG_CPM1 instead of CONFIG_8xx
git bisect good ea16e83aec40f9110be9cb0c3398ef41ae890ca6
# bad: [8bfa42ab84910841336218265fcee94fd1e6285a] powerpc: Add const to bin_attribute structures
git bisect bad 8bfa42ab84910841336218265fcee94fd1e6285a
# good: [36992606eee8016c36ad2576687e97422f2f35ed] powerpc/chrp: Store the intended structure
git bisect good 36992606eee8016c36ad2576687e97422f2f35ed
# bad: [86b19520e7ef5539eb081c76fe2f5c955180205f] powerpc/mm: declare some local functions static
git bisect bad 86b19520e7ef5539eb081c76fe2f5c955180205f
# good: [87be3e2d31c01d3858bff43ab663769db03aab17] powerpc/8xx: Do not allow Pinned TLBs with STRICT_KERNEL_RWX or DEBUG_PAGEALLOC
git bisect good 87be3e2d31c01d3858bff43ab663769db03aab17
# good: [e611939fc8ec13387018df88083de7102a438730] powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned TLBs
git bisect good e611939fc8ec13387018df88083de7102a438730
# bad: [95902e6c8864d39b09134dcaa3c99d8161d1deea] powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
git bisect bad 95902e6c8864d39b09134dcaa3c99d8161d1deea
# bad: [3184cc4b6f6a1dc0c1745aafe2b14b1206ef3187] powerpc/mm: Fix kernel RAM protection after freeing unused memory on PPC32
git bisect bad 3184cc4b6f6a1dc0c1745aafe2b14b1206ef3187
# first bad commit: [3184cc4b6f6a1dc0c1745aafe2b14b1206ef3187] powerpc/mm: Fix kernel RAM protection after freeing unused memory on PPC32
