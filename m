Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjJtN6hCZzDqJr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 14:44:44 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1G3iSWk028359
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 22:44:42 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5ke7f7th-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 22:44:42 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 22:44:41 -0500
Subject: [PATCH] pseries/drmem: Check for zero filled ibm,
 dynamic-memory property.
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, camb@cyrilbur.gho.pok.ibm.com,
 daniel@linux.vnet.ibm.com, ""@gmail.com
Date: Thu, 15 Feb 2018 21:27:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151875166139.16739.9174261168457130221.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some versions of QEMU will produce an ibm,dynamic-reconfiguration-memory
node with a ibm,dynamic-memory property that is zero-filled. This causes
the drmem code to oops trying to parse this property.

The fix for this is to validate that the property does contain LMB
entries before trying to parse it and bail if the count is zero.

Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048
NUMA
pSeries
Modules linked in:
Supported: Yes
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.14-11.2-default #1
task: c00000007e639680 task.stack: c00000007e648000
NIP: c000000000c709a4 LR: c000000000c70998 CTR: 0000000000000000
REGS: c00000007e64b8d0 TRAP: 0300   Not tainted  (4.12.14-11.2-default)
MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
  CR: 84000248  XER: 00000000
CFAR: c00000000067018c DAR: 0000000000000010 DSISR: 42000000 SOFTE: 1
GPR00: c000000000c70998 c00000007e64bb50 c000000001157b00 0000000000000000
GPR04: c00000007e64bb70 0000000000000000 000000000000002f 0000000000000022
GPR08: 0000000000000003 c000000006f63fac c000000006f63fb0 000000000000001e
GPR12: 0000000000000000 c00000000fa80000 c00000000000dca8 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: c000000000cccb98 c000000000c636f0 c000000000c56cd0 0000000000000007
GPR28: c000000000cccba8 c00000007ffffc30 c00000007e64bbf0 0000000000000010
NIP [c000000000c709a4] read_drconf_v1_cell+0x54/0x9c
LR [c000000000c70998] read_drconf_v1_cell+0x48/0x9c
Call Trace:
[c00000007e64bb50] [c000000000c56cd0] __param_initcall_debug+0x0/0x28 (unreliable)
[c00000007e64bb90] [c000000000c70e24] drmem_init+0x144/0x2f8
[c00000007e64bc40] [c00000000000d034] do_one_initcall+0x64/0x1d0
[c00000007e64bd00] [c000000000c643d0] kernel_init_freeable+0x298/0x38c
[c00000007e64bdc0] [c00000000000dcc4] kernel_init+0x24/0x160
[c00000007e64be30] [c00000000000b428] ret_from_kernel_thread+0x5c/0xb4
Instruction dump:
7c9e2378 60000000 e9429050 e93e0000 7c240b78 7c7f1b78 f9240021 e86a0002
4804e41d 60000000 e9210020 39490004 <f87f0000> f9410020 39490010 7d004c2c

The ibm,dynamic-reconfiguration-memory device tree property
generated that causes this:

ibm,dynamic-reconfiguration-memory {
        ibm,lmb-size = <0x0 0x10000000>;
        ibm,memory-flags-mask = <0xff>;
        ibm,dynamic-memory = <0x0 0x0 0x0 0x0 0x0 0x0>;
        linux,phandle = <0x7e57eed8>;
        ibm,associativity-lookup-arrays = <0x1 0x4 0x0 0x0 0x0 0x0>;
        ibm,memory-preservation-time = <0x0>;
};

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/drmem.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 1604110c4238..916844f99c64 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -216,6 +216,8 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
 	u32 i, n_lmbs;
 
 	n_lmbs = of_read_number(prop++, 1);
+	if (n_lmbs == 0)
+		return;
 
 	for (i = 0; i < n_lmbs; i++) {
 		read_drconf_v1_cell(&lmb, &prop);
@@ -245,6 +247,8 @@ static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
 	u32 i, j, lmb_sets;
 
 	lmb_sets = of_read_number(prop++, 1);
+	if (lmb_sets == 0)
+		return;
 
 	for (i = 0; i < lmb_sets; i++) {
 		read_drconf_v2_cell(&dr_cell, &prop);
@@ -354,6 +358,8 @@ static void __init init_drmem_v1_lmbs(const __be32 *prop)
 	struct drmem_lmb *lmb;
 
 	drmem_info->n_lmbs = of_read_number(prop++, 1);
+	if (drmem_info->n_lmbs == 0)
+		return;
 
 	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
 				   GFP_KERNEL);
@@ -373,6 +379,8 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 	int lmb_index;
 
 	lmb_sets = of_read_number(prop++, 1);
+	if (lmb_sets == 0)
+		return;
 
 	/* first pass, calculate the number of LMBs */
 	p = prop;
