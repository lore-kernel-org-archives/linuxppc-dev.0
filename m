Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whHdn3z5WzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 00:44:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55EhouV076296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 10:44:26 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw5vfh797-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 10:44:26 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 08:44:24 -0600
Subject: [RFC v2] powerpc/hotplug: Resolve dlpar hot-add cpu deadlock
References: <d9d7db9f-3af0-ddf1-55be-c13690d5f3c1@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, ltc-virtual-io@lists.linux.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 5 Jun 2017 09:44:19 -0500
MIME-Version: 1.0
In-Reply-To: <d9d7db9f-3af0-ddf1-55be-c13690d5f3c1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4c18a538-9f54-3f26-47a6-bb02a5df73da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


A deadlock problem was detected in the hot-add CPU operation when
modifying a Shared CPU Topology configuration on powerpc.  The system
build is the latest 4.12 pull from Github plus the following patches:

    [PATCH 0/2] powerpc/dlpar: Correct display of hot-add/hot-remove CPUs and memory
        https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-May/158134.html
    [PATCH V4 1/2] powerpc/numa: Update CPU topology when VPHN enabled
        https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-May/158249.html
    [PATCH V4 2/2] powerpc/hotplug/mm: Fix hot-add memory node assoc
        https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-May/158250.html

We have a case where the cpu_hotplug_begin locks 'cpu_hotplug.lock' in
one thread, and then a call to get_online_cpus attempts to acquire the
same lock from lower in the same call chain.  The get_online_cpus call
cannot complete because 'cpu_hotplug.lock' is already held, nor can it
exit get_online_cpus early because the thread-specific value of
cpu_hotplug.active_writer set during the earlier call to cpu_hotplug_begin
does not match the value of 'current' in the new thread that is calling
get_online_cpus from lower in the same call chain.

Here is a dump of the deadlocked tasks in the system:

[  489.684102] INFO: task kworker/0:1:823 blocked for more than 120 seconds.
[  489.684131]       Not tainted 4.12.0-rc3.wi91275_054a_02.ppc64le+ #18
[  489.684138] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  489.684146] kworker/0:1     D    0   823      2 0x00000800
[  489.684161] Workqueue: events vmstat_shepherd
[  489.684169] Call Trace:
[  489.684177] [c0000004d1f57940] [c00000000001ce5c] __switch_to+0x30c/0x430
[  489.684188] [c0000004d1f579a0] [c000000000a1fa54] __schedule+0x4d4/0xfd0
[  489.684198] [c0000004d1f57a70] [c000000000a2059c] schedule+0x4c/0xd0
[  489.684208] [c0000004d1f57aa0] [c000000000a20b7c] schedule_preempt_disabled+0x2c/0x50
[  489.684218] [c0000004d1f57ad0] [c000000000a2272c] __mutex_lock+0x34c/0xb40
[  489.684228] [c0000004d1f57be0] [c0000000000e9194] get_online_cpus+0x94/0xd0
[  489.684238] [c0000004d1f57c10] [c0000000002c7178] vmstat_shepherd+0x38/0x150
[  489.684249] [c0000004d1f57c60] [c000000000114dcc] process_one_work+0x22c/0x7f0
[  489.684260] [c0000004d1f57d30] [c000000000115418] worker_thread+0x88/0x4b0
[  489.684270] [c0000004d1f57dc0] [c00000000011e520] kthread+0x170/0x1b0
[  489.684280] [c0000004d1f57e30] [c00000000000b4f4] ret_from_kernel_thread+0x5c/0x68
[  489.684312] INFO: task irqbalance:3141 blocked for more than 120 seconds.
[  489.684320]       Not tainted 4.12.0-rc3.wi91275_054a_02.ppc64le+ #18
[  489.684326] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  489.684334] irqbalance      D    0  3141      1 0x00040080
[  489.684343] Call Trace:
[  489.684349] [c0000004a6247860] [c00000000001ce5c] __switch_to+0x30c/0x430
[  489.684359] [c0000004a62478c0] [c000000000a1fa54] __schedule+0x4d4/0xfd0
[  489.684368] [c0000004a6247990] [c000000000a2059c] schedule+0x4c/0xd0
[  489.684378] [c0000004a62479c0] [c000000000a20b7c] schedule_preempt_disabled+0x2c/0x50
[  489.684388] [c0000004a62479f0] [c000000000a2272c] __mutex_lock+0x34c/0xb40
[  489.684398] [c0000004a6247b00] [c00000000067ecc8] online_show+0x38/0x90
[  489.684408] [c0000004a6247b80] [c00000000067f5a0] dev_attr_show+0x40/0xa0
[  489.684419] [c0000004a6247bb0] [c00000000043e8f0] sysfs_kf_seq_show+0xf0/0x1c0
[  489.684429] [c0000004a6247c00] [c00000000043c1cc] kernfs_seq_show+0x3c/0x50
[  489.684439] [c0000004a6247c20] [c0000000003ae4cc] seq_read+0xfc/0x570
[  489.684449] [c0000004a6247cc0] [c00000000043d484] kernfs_fop_read+0x1a4/0x270
[  489.684459] [c0000004a6247d10] [c000000000370380] __vfs_read+0x40/0x1b0
[  489.684469] [c0000004a6247da0] [c000000000371d3c] vfs_read+0xac/0x190
[  489.684479] [c0000004a6247de0] [c000000000373a40] SyS_read+0x60/0x110
[  489.684489] [c0000004a6247e30] [c00000000000b190] system_call+0x38/0xe0
[  489.684555] INFO: task kworker/24:3:12619 blocked for more than 120 seconds.
[  489.684563]       Not tainted 4.12.0-rc3.wi91275_054a_02.ppc64le+ #18
[  489.684570] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  489.684577] kworker/24:3    D    0 12619      2 0x00000880
[  489.684588] Workqueue: events rtas_event_scan
[  489.684596] Call Trace:
[  489.684603] [c0000004ba15b900] [c00000000001ce5c] __switch_to+0x30c/0x430
[  489.684612] [c0000004ba15b960] [c000000000a1fa54] __schedule+0x4d4/0xfd0
[  489.684622] [c0000004ba15ba30] [c000000000a2059c] schedule+0x4c/0xd0
[  489.684631] [c0000004ba15ba60] [c000000000a20b7c] schedule_preempt_disabled+0x2c/0x50
[  489.684642] [c0000004ba15ba90] [c000000000a2272c] __mutex_lock+0x34c/0xb40
[  489.684651] [c0000004ba15bba0] [c0000000000e9194] get_online_cpus+0x94/0xd0
[  489.684661] [c0000004ba15bbd0] [c000000000036318] rtas_event_scan+0xa8/0x2f0
[  489.684671] [c0000004ba15bc60] [c000000000114dcc] process_one_work+0x22c/0x7f0
[  489.684682] [c0000004ba15bd30] [c000000000115418] worker_thread+0x88/0x4b0
[  489.684692] [c0000004ba15bdc0] [c00000000011e520] kthread+0x170/0x1b0
[  489.684702] [c0000004ba15be30] [c00000000000b4f4] ret_from_kernel_thread+0x5c/0x68
[  489.684714] INFO: task drmgr:14416 blocked for more than 120 seconds.
[  489.684721]       Not tainted 4.12.0-rc3.wi91275_054a_02.ppc64le+ #18
[  489.684728] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  489.684735] drmgr           D    0 14416   4793 0x00040080
[  489.684744] Call Trace:
[  489.684750] [c00000049d8b3470] [c00000000001ce5c] __switch_to+0x30c/0x430
[  489.684760] [c00000049d8b34d0] [c000000000a1fa54] __schedule+0x4d4/0xfd0
[  489.684770] [c00000049d8b35a0] [c000000000a2059c] schedule+0x4c/0xd0
[  489.684779] [c00000049d8b35d0] [c000000000a26f74] schedule_timeout+0x284/0x590
[  489.684790] [c00000049d8b36f0] [c000000000a217fc] wait_for_common+0x18c/0x280
[  489.684800] [c00000049d8b3770] [c0000000000ebcf4] bringup_cpu+0x84/0xe0
[  489.684810] [c00000049d8b37a0] [c0000000000e9a00] cpuhp_invoke_callback+0x240/0xcd0
[  489.684820] [c00000049d8b3860] [c0000000000ea6d8] cpuhp_up_callbacks+0x58/0x190
[  489.684830] [c00000049d8b38f0] [c0000000000ec0d8] _cpu_up+0xe8/0x1d0
[  489.684840] [c00000049d8b3950] [c0000000000ec2e0] do_cpu_up+0x120/0x150
[  489.684850] [c00000049d8b39d0] [c00000000068b7fc] cpu_subsys_online+0x5c/0xe0
[  489.684860] [c00000049d8b3a20] [c000000000682fe4] device_online+0xb4/0x120
[  489.684871] [c00000049d8b3a60] [c0000000000b54b4] dlpar_online_cpu+0x1e4/0x220
[  489.684881] [c00000049d8b3b30] [c0000000000b5c28] dlpar_cpu_add+0x108/0x2f0
[  489.684891] [c00000049d8b3bc0] [c0000000000b691c] dlpar_cpu_probe+0x3c/0x80
[  489.684901] [c00000049d8b3c00] [c0000000000231b8] arch_cpu_probe+0x38/0x60
[  489.684911] [c00000049d8b3c20] [c00000000068c020] cpu_probe_store+0x40/0x70
[  489.684921] [c00000049d8b3c50] [c00000000067e014] dev_attr_store+0x34/0x60
[  489.684931] [c00000049d8b3c70] [c00000000043e7d4] sysfs_kf_write+0x94/0xc0
[  489.684951] [c00000049d8b3cb0] [c00000000043d1f4] kernfs_fop_write+0x194/0x280
[  489.684961] [c00000049d8b3d00] [c000000000370530] __vfs_write+0x40/0x1c0
[  489.684970] [c00000049d8b3d90] [c000000000371ee8] vfs_write+0xc8/0x240
[  489.684981] [c00000049d8b3de0] [c000000000373b50] SyS_write+0x60/0x110
[  489.684991] [c00000049d8b3e30] [c00000000000b190] system_call+0x38/0xe0
[  489.685002] INFO: task cpuhp/136:14931 blocked for more than 120 seconds.
[  489.685009]       Not tainted 4.12.0-rc3.wi91275_054a_02.ppc64le+ #18
[  489.685015] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  489.685022] cpuhp/136       D    0 14931      2 0x00000880
[  489.685031] Call Trace:
[  489.685038] [c00000049eb2b4a0] [c00000000001ce5c] __switch_to+0x30c/0x430
[  489.685047] [c00000049eb2b500] [c000000000a1fa54] __schedule+0x4d4/0xfd0
[  489.685057] [c00000049eb2b5d0] [c000000000a2059c] schedule+0x4c/0xd0
[  489.685066] [c00000049eb2b600] [c000000000a20b7c] schedule_preempt_disabled+0x2c/0x50
[  489.685077] [c00000049eb2b630] [c000000000a2272c] __mutex_lock+0x34c/0xb40
[  489.685086] [c00000049eb2b740] [c0000000000e9194] get_online_cpus+0x94/0xd0
[  489.685097] [c00000049eb2b770] [c000000000200844] stop_machine+0x34/0x1f0
[  489.685108] [c00000049eb2b7e0] [c000000000074b04] arch_update_cpu_topology+0x524/0x650
[  489.685119] [c00000049eb2ba80] [c00000000015f24c] partition_sched_domains+0x9c/0x4f0
[  489.685130] [c00000049eb2bb40] [c0000000001fb3c4] cpuset_update_active_cpus+0x24/0x60
[  489.685141] [c00000049eb2bb60] [c000000000137874] sched_cpu_activate+0x1a4/0x1b0
[  489.685151] [c00000049eb2bbb0] [c0000000000e9a00] cpuhp_invoke_callback+0x240/0xcd0
[  489.685161] [c00000049eb2bc70] [c0000000000ea6d8] cpuhp_up_callbacks+0x58/0x190
[  489.685171] [c00000049eb2bd00] [c0000000000ea978] cpuhp_thread_fun+0x168/0x1a0
[  489.685182] [c00000049eb2bd30] [c000000000124d2c] smpboot_thread_fn+0x2fc/0x3b0
[  489.685192] [c00000049eb2bdc0] [c00000000011e520] kthread+0x170/0x1b0
[  489.685203] [c00000049eb2be30] [c00000000000b4f4] ret_from_kernel_thread+0x5c/0x68

Here is a dump of all of the locks help in the system:

[  489.685213] Showing all locks held in the system:
[  489.685221] hm, tasklist_lock locked, retrying...
[  489.685223]  #1 locked it.
[  489.885281] 4 locks held by kworker/0:1/823:
[  489.885288]  #0:  ("events"){.+.+.+}, at: [<c000000000114d1c>] process_one_work+0x17c/0x7f0
[  489.885308]  #1:  ((shepherd).work){+.+...}, at: [<c000000000114d1c>] process_one_work+0x17c/0x7f0
[  489.885327]  #2:  (cpu_hotplug.dep_map){++++++}, at: [<c0000000000e9158>] get_online_cpus+0x58/0xd0
[  489.885345]  #3:  (cpu_hotplug.lock){+.+.+.}, at: [<c0000000000e9194>] get_online_cpus+0x94/0xd0
[  489.885363] 1 lock held by khungtaskd/829:
[  489.885368]  #0:  (tasklist_lock){.+.+..}, at: [<c00000000016b974>] debug_show_all_locks+0xa4/0x210
[  489.885397] 4 locks held by irqbalance/3141:
[  489.885403]  #0:  (&p->lock){+.+.+.}, at: [<c0000000003ae43c>] seq_read+0x6c/0x570
[  489.885420]  #1:  (&of->mutex){+.+.+.}, at: [<c00000000043c7a8>] kernfs_seq_start+0x38/0x120
[  489.885439]  #2:  (s_active#14){.+.+.+}, at: [<c00000000043c7b4>] kernfs_seq_start+0x44/0x120
[  489.885459]  #3:  (&dev->mutex){......}, at: [<c00000000067ecc8>] online_show+0x38/0x90
[  489.885477] 2 locks held by agetty/3195:
[  489.885482]  #0:  (&tty->ldisc_sem){++++.+}, at: [<c00000000062b0e4>] tty_ldisc_ref_wait+0x34/0x90
[  489.885501]  #1:  (&ldata->atomic_read_lock){+.+...}, at: [<c000000000626e1c>] n_tty_read+0xec/0x960
[  489.885528] 2 locks held by bash/7902:
[  489.885534]  #0:  (&tty->ldisc_sem){++++.+}, at: [<c00000000062b0e4>] tty_ldisc_ref_wait+0x34/0x90
[  489.885552]  #1:  (&ldata->atomic_read_lock){+.+...}, at: [<c000000000626e1c>] n_tty_read+0xec/0x960
[  489.885589] 4 locks held by kworker/24:3/12619:
[  489.885595]  #0:  ("events"){.+.+.+}, at: [<c000000000114d1c>] process_one_work+0x17c/0x7f0
[  489.885612]  #1:  ((event_scan_work).work){+.+...}, at: [<c000000000114d1c>] process_one_work+0x17c/0x7f0
[  489.885630]  #2:  (cpu_hotplug.dep_map){++++++}, at: [<c0000000000e9158>] get_online_cpus+0x58/0xd0
[  489.885648]  #3:  (cpu_hotplug.lock){+.+.+.}, at: [<c0000000000e9194>] get_online_cpus+0x94/0xd0
[  489.885667] 8 locks held by drmgr/14416:
[  489.885673]  #0:  (sb_writers#3){.+.+.+}, at: [<c000000000372030>] vfs_write+0x210/0x240
[  489.885692]  #1:  (&of->mutex){+.+.+.}, at: [<c00000000043d1a4>] kernfs_fop_write+0x144/0x280
[  489.885710]  #2:  (s_active#150){.+.+.+}, at: [<c00000000043d1b0>] kernfs_fop_write+0x150/0x280
[  489.885730]  #3:  (device_hotplug_lock){+.+.+.}, at: [<c000000000680e30>] lock_device_hotplug_sysfs+0x20/0x90
[  489.885749]  #4:  (&dev->mutex){......}, at: [<c000000000682f64>] device_online+0x34/0x120
[  489.885766]  #5:  (cpu_add_remove_lock){+.+.+.}, at: [<c0000000000ec288>] do_cpu_up+0xc8/0x150
[  489.885784]  #6:  (cpu_hotplug.dep_map){++++++}, at: [<c0000000000ebdd8>] cpu_hotplug_begin+0x8/0x100
[  489.885802]  #7:  (cpu_hotplug.lock){+.+.+.}, at: [<c0000000000ebe68>] cpu_hotplug_begin+0x98/0x100
[  489.885821] 3 locks held by cpuhp/136/14931:
[  489.885827]  #0:  (sched_domains_mutex){+.+.+.}, at: [<c00000000015f23c>] partition_sched_domains+0x8c/0x4f0
[  489.885845]  #1:  (cpu_hotplug.dep_map){++++++}, at: [<c0000000000e9158>] get_online_cpus+0x58/0xd0
[  489.885863]  #2:  (cpu_hotplug.lock){+.+.+.}, at: [<c0000000000e9194>] get_online_cpus+0x94/0xd0
[  489.885880]
[  489.885885] =============================================
[  489.885885]

This patch provides a way to short-circuit the call chains underneath
rebuild_sched_domains which run through arch_update_cpu_topology, and,
eventually reaches get_online_cpus and deadlocks.  This patch allows
only a copy of the arch_update_cpu_topology which is actually in the
same thread as the DLPAR hot-add cpu operation to operate.  To compensate,
the function arch_update_cpu_topology will be invoked by a repeating
timer worker function shortly after the device_online operation has
completed.

This workaround is completely contained within the powerpc-arch code.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/sparsemem.h         |    4 +++
 arch/powerpc/mm/numa.c                       |   31 ++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    4 +++
 3 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index c88930c..2cf0bac 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -26,8 +26,12 @@ static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
 #endif

 #ifdef CONFIG_NUMA
+extern int set_single_dlpar_cpu_readchg(void);
+extern int clear_single_dlpar_cpu_readchg(void);
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
 #else
+#define set_single_dlpar_cpu_readchg()	0
+#define clear_single_dlpar_cpu_readchg()	0
 static inline int hot_add_scn_to_nid(unsigned long scn_addr)
 {
 	return 0;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 4f06409..05325a0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1305,6 +1305,34 @@ static int update_lookup_table(void *data)
 }

 /*
+ * Support for singleton execution of arch_update_cpu_topology
+ */
+int dlpar_cpu_chg_in_progress;
+pid_t dlpar_cpu_chg_pid;
+
+int set_single_dlpar_cpu_readchg(void)
+{
+	if (dlpar_cpu_chg_in_progress)
+		return dlpar_cpu_chg_pid;
+
+	dlpar_cpu_chg_in_progress = 1;
+	dlpar_cpu_chg_pid = current->pid;
+
+	return 0;
+}
+
+int clear_single_dlpar_cpu_readchg(void)
+{
+	if (dlpar_cpu_chg_pid != current->pid)
+		return current->pid;
+
+	dlpar_cpu_chg_in_progress = 0;
+	dlpar_cpu_chg_pid = -1;
+
+	return 0;
+}
+
+/*
  * Update the node maps and sysfs entries for each cpu whose home node
  * has changed. Returns 1 when the topology has changed, and 0 otherwise.
  */
@@ -1317,6 +1345,9 @@ int arch_update_cpu_topology(void)
 	struct device *dev;
 	int weight, new_nid, i = 0;

+	if (dlpar_cpu_chg_in_progress && (dlpar_cpu_chg_pid != current->pid))
+		return 0;
+
 	if (!prrn_enabled && !vphn_enabled) {
 		if (!topology_inited)
 			topology_update_needed = 1;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 7bc0e91..0e97086 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -356,7 +356,9 @@ static int dlpar_online_cpu(struct device_node *dn)
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
+			set_single_dlpar_cpu_readchg();
 			rc = device_online(get_cpu_device(cpu));
+			clear_single_dlpar_cpu_readchg();
 			if (rc)
 				goto out;
 			cpu_maps_update_begin();
@@ -522,7 +524,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				set_preferred_offline_state(cpu,
 							    CPU_STATE_OFFLINE);
 				cpu_maps_update_done();
+				set_single_dlpar_cpu_readchg();
 				rc = device_offline(get_cpu_device(cpu));
+				clear_single_dlpar_cpu_readchg();
 				if (rc)
 					goto out;
 				cpu_maps_update_begin();
