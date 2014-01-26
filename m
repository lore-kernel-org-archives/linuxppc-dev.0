Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB8CA2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2014 16:09:17 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Sun, 26 Jan 2014 15:09:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7657D2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2014 16:09:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0Q58tnW5964114
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2014 16:08:55 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0Q597VN019797
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2014 16:09:07 +1100
Message-ID: <1390712942.3911.8.camel@ThinkPad-T5421>
Subject: [PATCH powerpc] cpuidle: fix per cpu accessing of cpuidle_devices
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 linux-pm@vger.kernel.org
Date: Sun, 26 Jan 2014 13:09:02 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: deepthi@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 b.zolnierkie@samsung.com, daniel.lezcano@linaro.org, kyungmin.park@samsung.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch tries to fix following bad address accessing, seems caused by
a typo in commit 7f74dc0f. cpuidle_devices is defined statically, so
per_cpu should be used to access it. 

[  204.774193] Unable to handle kernel paging request for data at address 0x00a7d000
[  204.774215] Faulting instruction address: 0xc0000000006ee92c
[  204.774225] Oops: Kernel access of bad area, sig: 11 [#1]
[  204.774230] PREEMPT SMP NR_CPUS=16 DEBUG_PAGEALLOC NUMA pSeries
[  204.774244] Modules linked in: binfmt_misc
[  204.774254] CPU: 8 PID: 3590 Comm: bash Not tainted 3.13.0-08526-gb2e448e-dirty #2
[  204.774262] task: c0000001faf40000 ti: c0000001fa904000 task.ti: c0000001fa904000
[  204.774268] NIP: c0000000006ee92c LR: c0000000006ee920 CTR: c000000000064e94
[  204.774275] REGS: c0000001fa907240 TRAP: 0300   Not tainted  (3.13.0-08526-gb2e448e-dirty)
[  204.774281] MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 22242424  XER: 20000000
[  204.774303] CFAR: 0000000000009088 DAR: 0000000000a7d000 DSISR: 40000000 SOFTE: 1 
GPR00: c0000000006ee920 c0000001fa9074c0 c000000000d764a8 c000000000c5d4c0 
GPR04: 0000000000000010 0000000000000010 0000000000000000 0000000000000000 
GPR08: ffffffffffffffff c0000000016564a8 ffffffffffffffff 0000000000000000 
GPR12: 0000000000000002 c00000000f33e800 000000001012b3dc 0000000000000000 
GPR16: 0000000000000000 0000000010129c58 0000000010129bf8 000000001012b948 
GPR20: 0000000000000000 000000001012b3e4 000000001013ea90 0000000000000000 
GPR24: c000000000c5d858 c0000000015f38e8 c000000000cb8b26 c000000000c664a8 
GPR28: 0000000000000000 ffffffffffffffe5 0000000000a7d000 0000000000a7d000 
[  204.774407] NIP [c0000000006ee92c] .cpuidle_disable_device+0x30/0xc4
[  204.774413] LR [c0000000006ee920] .cpuidle_disable_device+0x24/0xc4
[  204.774419] Call Trace:
[  204.774424] [c0000001fa9074c0] [c0000000006ee920] .cpuidle_disable_device+0x24/0xc4 (unreliable)
[  204.774435] [c0000001fa907540] [c0000000000652a4] .pseries_cpuidle_add_cpu_notifier+0xb8/0xe0
[  204.774445] [c0000001fa9075c0] [c000000000855548] .notifier_call_chain+0x150/0x1c0
[  204.774455] [c0000001fa907670] [c0000000000b3564] .__raw_notifier_call_chain+0x40/0x50
[  204.774463] [c0000001fa907710] [c000000000079c40] .__cpu_notify+0x50/0x9c
[  204.774472] [c0000001fa9077a0] [c00000000018a054] ._cpu_down+0x1ec/0x388
[  204.774479] [c0000001fa9078b0] [c00000000018a234] .cpu_down+0x44/0x64
[  204.774488] [c0000001fa907940] [c0000000005627bc] .cpu_subsys_offline+0x24/0x3c
[  204.774497] [c0000001fa9079c0] [c00000000055b2a4] .device_offline+0xc8/0x120
[  204.774504] [c0000001fa907a50] [c00000000055d000] .online_store+0x74/0xb0
[  204.774512] [c0000001fa907b00] [c000000000559924] .dev_attr_store+0x60/0x78
[  204.774520] [c0000001fa907ba0] [c00000000028cc78] .sysfs_kf_write+0x7c/0x9c
[  204.774528] [c0000001fa907c30] [c000000000291ae8] .kernfs_fop_write+0x108/0x174
[  204.774537] [c0000001fa907cd0] [c0000000001f8308] .vfs_write+0x110/0x21c
[  204.774545] [c0000001fa907d70] [c0000000001f854c] .SyS_write+0x70/0xbc
[  204.774553] [c0000001fa907e30] [c000000000009d88] syscall_exit+0x0/0x7c
[  204.774560] Instruction dump:
[  204.774565] 7c0802a6 f8010010 fbe1fff8 f821ff81 7c7f1b78 60000000 60000000 7fe3fb78 
[  204.774582] 48000c89 60000000 2fbf0000 419e0084 <e81f0000> 780b17e1 41820078 2fa30000 
[  204.774601] ---[ end trace edf1df93cf81e28d ]---

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 94134a5..197cadc 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -190,7 +190,7 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
 {
 	int hotcpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev =
-			per_cpu_ptr(cpuidle_devices, hotcpu);
+			per_cpu(cpuidle_devices, hotcpu);
 
 	if (dev && cpuidle_get_driver()) {
 		switch (action) {
