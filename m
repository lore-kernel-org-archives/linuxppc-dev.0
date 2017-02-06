Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHGwm3vrDzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 05:59:20 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v16Iwt3U142064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 13:59:17 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28euqvrexn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 13:59:17 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 16:59:15 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 51E59352005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:58:39 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v16IxCjC39911570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 16:59:12 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v16IxCmo012481
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 16:59:12 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [RFC] powerpc/pseries: Increase busy loop in pseries_cpu_die
Date: Mon,  6 Feb 2017 16:58:16 -0200
Message-Id: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When testing DLPAR CPU add/remove on a system under stress, pseries_cpu_die
doesn't wait long enough for a CPU to die and the kernel ends up crashing:

[  446.143648] cpu 152 (hwid 152) Ready to die...
[  446.464057] cpu 153 (hwid 153) Ready to die...
[  446.473525] cpu 154 (hwid 154) Ready to die...
[  446.474077] cpu 155 (hwid 155) Ready to die...
[  446.483529] cpu 156 (hwid 156) Ready to die...
[  446.493532] cpu 157 (hwid 157) Ready to die...
[  446.494078] cpu 158 (hwid 158) Ready to die...
[  446.503527] cpu 159 (hwid 159) Ready to die...
[  446.664534] cpu 144 (hwid 144) Ready to die...
[  446.964113] cpu 145 (hwid 145) Ready to die...
[  446.973525] cpu 146 (hwid 146) Ready to die...
[  446.974094] cpu 147 (hwid 147) Ready to die...
[  446.983944] cpu 148 (hwid 148) Ready to die...
[  446.984062] cpu 149 (hwid 149) Ready to die...
[  446.993518] cpu 150 (hwid 150) Ready to die...
[  446.993543] Querying DEAD? cpu 150 (150) shows 2
[  446.994098] cpu 151 (hwid 151) Ready to die...
[  447.133726] cpu 136 (hwid 136) Ready to die...
[  447.403532] cpu 137 (hwid 137) Ready to die...
[  447.403772] cpu 138 (hwid 138) Ready to die...
[  447.403839] cpu 139 (hwid 139) Ready to die...
[  447.403887] cpu 140 (hwid 140) Ready to die...
[  447.403937] cpu 141 (hwid 141) Ready to die...
[  447.403979] cpu 142 (hwid 142) Ready to die...
[  447.404038] cpu 143 (hwid 143) Ready to die...
[  447.513546] cpu 128 (hwid 128) Ready to die...
[  447.693533] cpu 129 (hwid 129) Ready to die...
[  447.693999] cpu 130 (hwid 130) Ready to die...
[  447.703530] cpu 131 (hwid 131) Ready to die...
[  447.704087] Querying DEAD? cpu 132 (132) shows 2
[  447.704102] cpu 132 (hwid 132) Ready to die...
[  447.713534] cpu 133 (hwid 133) Ready to die...
[  447.714064] Querying DEAD? cpu 134 (134) shows 2
cpu 0x86: Vector: 300 (Data Access) at [c000000007b0fd40]
    pc: 000000001ec3072c
    lr: 000000001ec2fee0
    sp: 1faf6bd0
   msr: 8000000102801000
   dar: 212d6c1a2a20c
 dsisr: 42000000
  current = 0xc000000474c6d600
  paca    = 0xc000000007b6b600   softe: 0        irq_happened: 0x01
    pid   = 0, comm = swapper/134
Linux version 4.8.0-34-generic (buildd@bos01-ppc64el-026) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #36~16.04.1-Ubuntu SMP Wed Dec 21 18:53:20 UTC 2016 (Ubuntu 4.8.0-34.36~16.04.1-generic 4.8.11)
WARNING: exception is not recoverable, can't continue

This was reproduced in v4.10-rc6 as well, but I don't have a crash log
handy for that version right now. Sorry.

This is a race between one CPU stopping and another one calling
pseries_cpu_die to wait for it to stop. That function does a short
busy loop calling RTAS query-cpu-stopped-state on the stopping CPU
to verify that it is stopped.

As can be seen in the dmesg right before or after the "Querying DEAD?"
messages, if pseries_cpu_die waited a little longer it would have seen
the CPU in the stopped state.

I see two cases that can be causing this race:

1. It's possible that CPU 134 was inactive at the time it was unplugged.
   In that case, dlpar_offline_cpu calls H_PROD on the CPU and immediately
   calls pseries_cpu_die. Meanwhile, the prodded CPU activates and start
   the process of stopping itself. It's possible that the busy loop is not
   long enough to allow for the CPU to wake up and complete the stopping
   process.
2. If CPU 134 was online at the time it was unplugged, it would have gone
   through the new CPU hotplug state machine in kernel/cpu.c that was
   introduced in v4.6 to get itself stopped. It's possible that the busy
   loop in pseries_cpu_die was long enough for the older hotplug code but
   not for the new hotplug state machine.

Either way, the solution is the same: wait an adequate amount in
pseries_cpu_die.

The simple solution is to increase the number of tries in the loop.
This was done to solve a similar problem in
commit 940ce422a367 ("powerpc/pseries: Increase cpu die timeout"), so
it's not as lame as it sounds. :-)

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

Notes:
    A solution that is probably better is to have pseries_cpu_die wait
    on a per-CPU semaphore at the beginning of the function, before doing a
    short busy loop. Then the CPU that is stopping unlocks that semaphore right
    before stopping itself, probably at pseries_mach_cpu_die.
    
    What do you think? I can implement that if there is interest.

 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a1b63e00b2f7..3d43317eec1b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -206,7 +206,7 @@ static void pseries_cpu_die(unsigned int cpu)
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
 
-		for (tries = 0; tries < 25; tries++) {
+		for (tries = 0; tries < 5000; tries++) {
 			cpu_status = smp_query_cpu_stopped(pcpu);
 			if (cpu_status == QCSS_STOPPED ||
 			    cpu_status == QCSS_HARDWARE_ERROR)
-- 
2.7.4
