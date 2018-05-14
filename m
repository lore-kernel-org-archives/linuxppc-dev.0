Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kr4f2XCMzF2ZX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 16:14:09 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id bi12-v6so6718997plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 23:14:09 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r5-v6sm12795252pgp.81.2018.05.13.23.14.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 May 2018 23:14:07 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/cpu: nr_cpu_ids should be aligned on threads_per_core
Date: Mon, 14 May 2018 14:13:58 +0800
Message-Id: <1526278438-10519-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With p8 subcore mode, if nr_cpus is not aligned on threads_per_core,
then we will hit the following panic:
  [    0.310006] Unpacking initramfs...
  [    1.105015] Freeing initrd memory: 35968K
  [    1.105466] rtas_flash: no firmware flash support
  [    1.105688] Unable to handle kernel paging request for data at address 0x00001035
  [    1.105768] Faulting instruction address: 0xc000000000099bb8
  [    1.105837] Oops: Kernel access of bad area, sig: 11 [#1]
  [    1.105890] LE SMP NR_CPUS=2048 NUMA PowerNV
  [    1.105947] Modules linked in:
  [    1.105992] CPU: 8 PID: 11 Comm: migration/8 Not tainted 4.17.0-rc4+ #26
  [    1.106059] NIP:  c000000000099bb8 LR: c0000000000ac554 CTR: c000000000099b70
  [    1.106139] REGS: c000000ff649f860 TRAP: 0380   Not tainted  (4.17.0-rc4+)
  [    1.106205] MSR:  9000000000001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 28004022  XER: 00000000
  [    1.106293] CFAR: c0000000000ac550 SOFTE: 3
  [    1.106293] GPR00: c0000000000ac554 c000000ff649fae0 c0000000012e6d00 0000000000000060
  [    1.106293] GPR04: 0000000000000001 c0000000000ac914 9000000000001033 c000003fffffff80
  [    1.106293] GPR08: 0000000000000000 0000000000000001 0000000000000000 9000000000001003
  [    1.106293] GPR12: c000000000099b70 c000000001700000 c000000000141c28 c000000ffa201180
  [    1.106293] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  [    1.106293] GPR20: 0000000000000000 0000000000000000 0000000000000001 c000000fffd13840
  [    1.106293] GPR24: c000000fffd13838 0000000000000000 0000000000000001 0000000000000010
  [    1.106293] GPR28: 0000000000000008 0000000000000001 c000000001370548 000000000000000c
  [    1.106984] NIP [c000000000099bb8] icp_native_cause_ipi+0x48/0x70
  [    1.107053] LR [c0000000000ac554] pnv_cause_ipi+0x54/0x80
  [    1.107106] Call Trace:
  [    1.107137] [c000000ff649fae0] [c0000000000478b4] doorbell_try_core_ipi+0x74/0x90 (unreliable)
  [    1.107232] [c000000ff649fb10] [c0000000000ac554] pnv_cause_ipi+0x54/0x80
  [    1.107301] [c000000ff649fb40] [c00000000004ccfc] smp_muxed_ipi_message_pass+0x6c/0x90
  [    1.107384] [c000000ff649fb80] [c0000000000acbe8] cpu_do_split+0x2b8/0x2f0
  [    1.107453] [c000000ff649fbf0] [c0000000000acdb8] cpu_update_split_mode+0x68/0x204
  [    1.107536] [c000000ff649fc40] [c000000000204ab8] multi_cpu_stop+0x1c8/0x200
  [    1.107617] [c000000ff649fca0] [c000000000204eb4] cpu_stopper_thread+0x114/0x1f0
  [    1.107699] [c000000ff649fd60] [c000000000148650] smpboot_thread_fn+0x290/0x2a0
  [    1.107780] [c000000ff649fdc0] [c000000000141d84] kthread+0x164/0x1b0
  [    1.107850] [c000000ff649fe30] [c00000000000b628] ret_from_kernel_thread+0x5c/0xb4
  [    1.107929] Instruction dump:
  [    1.107971] 7c7f1b78 60000000 60000000 3d420004 394ab070 7be31f24 39200001 e90a0000
  [    1.108058] 3d42001b 394a2650 7d08182a 7d4a182a <99281035> 39000004 7c0004ac 990a000c
  [    1.108150] ---[ end trace 83dad19c162dc306 ]---
  [    1.110137]
  [    2.110227] Kernel panic - not syncing: Fatal exception

This is caused by that during subcore_init, it IPIs all cpu inside the core, but due to the limitation
imposed by nr_cpus, there are no mem allocated for percpu cpu_sibling_map.
To avoid a complicated fix, this patch just forces the nr_cpu_ids to be aligned on thread_per_code
at the cost of a bit more memory.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 arch/powerpc/kernel/prom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9dbed48..358adb4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -315,6 +315,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	int len;
 	int found = -1;
 	int found_thread = 0;
+	unsigned int nr_cpus_aligned;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -361,7 +362,13 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	/* Not the boot CPU */
 	if (found < 0)
 		return 0;
-
+	/* to work around p8 subcore mode */
+	nr_cpus_aligned = _ALIGN_UP(nr_cpu_ids, nthreads);
+	if (nr_cpus_aligned != nr_cpu_ids) {
+		pr_info("nr_cpus is forced to align up on threads_per_core,"
+			"from %u to %u\n", nr_cpu_ids, nr_cpus_aligned);
+		nr_cpu_ids = nr_cpus_aligned;
+	}
 	DBG("boot cpu: logical %d physical %d\n", found,
 	    be32_to_cpu(intserv[found_thread]));
 	boot_cpuid = found;
-- 
2.7.4
