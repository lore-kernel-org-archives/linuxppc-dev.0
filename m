Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E61352C016B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 19:16:38 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 7 May 2013 19:08:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB71C2BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 19:16:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4792XBh12779608
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 19:02:33 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r479GV56007503
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 19:16:32 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc,
 cpu hotplug: Fix warning on boot regarding sysfs file permission
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 07 May 2013 14:43:34 +0530
Message-ID: <20130507091309.12448.70498.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: caiqian@redhat.com, gregkh@linuxfoundation.org, balbi@ti.com,
 paulus@samba.org, anton@samba.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On boot, the following warning shows up on each CPU online operation:

------------[ cut here ]------------
WARNING: at drivers/base/core.c:575
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.9.0+ #2
task: c0000006fa180000 ti: c0000006fa200000 task.ti: c0000006fa200000
NIP: c00000000053772c LR: c000000000537728 CTR: 0000000001764c5c
REGS: c0000006fa203780 TRAP: 0700   Tainted: G        W     (3.9.0+)
MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 28000024  XER: 00000002
SOFTE: 1
CFAR: c0000000008a6994

GPR00: c000000000537728 c0000006fa203a00 c000000000dafaf0 0000000000000020
GPR04: 0000000000000001 c000000000085d9c 0000000000000000 0000000000000002
GPR08: 0000000000000000 c0000006fa180000 c0000006fa180000 c000000000e38804
GPR12: 0000000000000000 c000000001db0000 c00000000000c1b0 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000001 c000000000e44880
GPR20: c000000000e44d18 c000000000c726a8 0000000000000000 0000000000000000
GPR24: c000000000bab158 000000000000007e c000000000e68200 c000000000c71d48
GPR28: c0000000130c0030 0000000000000002 c0000000130c0030 c000000000c71f58
NIP [c00000000053772c] .device_create_file+0xac/0xc0
LR [c000000000537728] .device_create_file+0xa8/0xc0
PACATMSCRATCH [8000000000009032]
Call Trace:
[c0000006fa203a00] [c000000000537728] .device_create_file+0xa8/0xc0 (unreliable)
[c0000006fa203a80] [c00000000089f3e4] .register_cpu_online+0x10c/0x238
[c0000006fa203b30] [c000000000bc9a80] .topology_init+0x1fc/0x200
[c0000006fa203c10] [c00000000000b870] .do_one_initcall+0x60/0x1e0
[c0000006fa203cd0] [c000000000bc3fc0] .kernel_init_freeable+0x22c/0x310
[c0000006fa203da0] [c00000000000c1cc] .kernel_init+0x1c/0x1c0
[c0000006fa203e30] [c00000000000a170] .ret_from_kernel_thread+0x64/0x74
Instruction dump:
0fe00000 4bffffb8 60000000 60000000 60000000 e8040028 2fa00000 409eff98
3c62ffd6 3863dc38 4836f221 60000000 <0fe00000> a13f0008 4bffff7c 60000000
---[ end trace b53dfda141d62ab0 ]---


The problem is that the 'spurr' per-cpu sysfs file sports a write permission
without the corresponding ->store() method. So remove the bogus write
permission to fix the warning.

Reported-by: CAI Qian <caiqian@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 3ce1f86..e68a845 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -180,7 +180,7 @@ SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 SYSFS_PMCSETUP(pir, SPRN_PIR);
 
 static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
-static DEVICE_ATTR(spurr, 0600, show_spurr, NULL);
+static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
 static DEVICE_ATTR(purr, 0600, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
