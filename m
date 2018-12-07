Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B86DC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:06:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7CA20868
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7CA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BB5l5FbHzDrhK
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 23:06:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BB2g1TSNzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 23:03:54 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB7AuFLX053835
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Dec 2018 07:03:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p7py3cbss-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 07:03:52 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Dec 2018 12:03:51 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 7 Dec 2018 12:03:49 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB7C3mdw19333334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 12:03:49 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7844AC05B;
 Fri,  7 Dec 2018 12:03:48 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AC49AC05E;
 Fri,  7 Dec 2018 12:03:48 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.115])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  7 Dec 2018 12:03:48 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id B4C4F2E4D2B; Fri,  7 Dec 2018 17:33:46 +0530 (IST)
Date: Fri, 7 Dec 2018 17:33:46 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
References: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
 <87a7li5zv2.fsf@morokweng.localdomain>
 <20181207104311.GA11431@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207104311.GA11431@in.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18120712-0072-0000-0000-000003D5EA86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010187; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01128270; UDB=6.00582089; IPR=6.00908402; 
 MB=3.00024558; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-07 12:03:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120712-0073-0000-0000-00004A5D130C
Message-Id: <20181207120346.GB11431@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812070095
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: ego@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 07, 2018 at 04:13:11PM +0530, Gautham R Shenoy wrote:
> Hi Thiago,
> 
> 
> Sure. I will test the patch and report back.

I added the following debug patch on top of your patch, and after an
hour's run, the system crashed. Appending the log at the end.

I suppose we still need to increase the number of tries since we wait
only for 2.5ms looping before giving up.

----------------------------x8-----------------------------------------
From 9e9e1e459cdc63540a73575af359a7bc0d43e455 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 7 Dec 2018 16:47:25 +0530
Subject: [PATCH] Add debug on top of Thiago's patch

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index fad3ceb..2545aab 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -214,6 +214,9 @@ static void pseries_cpu_die(unsigned int cpu)
 			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
+		u64 tb_before = mftb();
+		u64 tb_after;
+
 		/*
 		 * If the current state is not offline yet, it means that the
 		 * dying CPU (which is in pseries_mach_cpu_die) didn't have a
@@ -230,6 +233,11 @@ static void pseries_cpu_die(unsigned int cpu)
 				break;
 			udelay(100);
 		}
+
+		tb_after = mftb();
+
+		printk("[DEBUG] Waited for CPU %d to enter rtas: tries=%d, time=%llu\n", cpu, tries,
+			div_u64(tb_after - tb_before, tb_ticks_per_usec));
 	}
 
 	if (cpu_status != 0) {
-- 
1.9.4
----------------------------x8-----------------------------------------

cpu 112 (hwid 112) Ready to die...
[DEBUG] Waited for CPU 112 to enter rtas: tries=0, time=65
cpu 113 (hwid 113) Ready to die...
[DEBUG] Waited for CPU 113 to enter rtas: tries=0, time=1139
cpu 114 (hwid 114) Ready to die...
[DEBUG] Waited for CPU 114 to enter rtas: tries=0, time=1036
cpu 115 (hwid 115) Ready to die...
[DEBUG] Waited for CPU 115 to enter rtas: tries=0, time=133
cpu 116 (hwid 116) Ready to die...
[DEBUG] Waited for CPU 116 to enter rtas: tries=0, time=1231
cpu 117 (hwid 117) Ready to die...
[DEBUG] Waited for CPU 117 to enter rtas: tries=0, time=1231
cpu 118 (hwid 118) Ready to die...
[DEBUG] Waited for CPU 118 to enter rtas: tries=0, time=1231
cpu 119 (hwid 119) Ready to die...
[DEBUG] Waited for CPU 119 to enter rtas: tries=0, time=1131
cpu 104 (hwid 104) Ready to die...
[DEBUG] Waited for CPU 104 to enter rtas: tries=0, time=40  

******* RTAS CALL BUFFER CORRUPTION *******
393: rtas32_call_buff_ptr=
    0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
    0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
    0000 0060 0000 0060 0000 0060 0000 0060 [...`...`...`...`]
    0000 0060 0800 E07F ACA7 0000 0000 00C0 [...`............]
    2500 0000 0000 0000 0000 0000 0000 0000 [%...............]
    0000 0000 0000 0000 0000 0000 306E 7572 [............0nur]
    4800 0008 .... .... .... .... .... .... [H...........0nur]
394: rtas64_map_buff_ptr=
    0000 0000 5046 5743 0000 0000 4F44 4500 [....PFWC....ODE.]
    0000 0000 6000 0000 0000 0000 0000 0069 [....`..........i]
    0000 0000 0000 0000 0000 0000 0000 0000 [................]
    0000 0000 0000 0005 0000 0000 0000 0001 [................]
    0000 0000 1A00 0000 0000 0000 0000 0000 [................]
    0000 0000 8018 6398 0000 0000 0300 00C0 [......c.........]
    0000 0000 .... .... .... .... .... .... [......c.........]
cpu 105 (hwid 105) Ready to die...
Bad kernel stack pointer 1fafb6c0 at 0
Oops: Bad kernel stack pointer, sig: 6 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 105 PID: 0 Comm: swapper/105 Not tainted 4.20.0-rc5-thiago+ #45
NIP:  0000000000000000 LR: 0000000000000000 CTR: 00000000007829c8
REGS: c00000001e63bd30 TRAP: 0700   Not tainted  (4.20.0-rc5-thiago+)
MSR:  8000000000081000 <SF,ME>  CR: 28000004  XER: 00000010
CFAR: 000000001ec153f0 IRQMASK: 8000000000009033
GPR00: 0000000000000000 000000001fafb6c0 000000001ec236a0 0000000000000040
GPR04: 00000000000000c0 0000000000000080 00046c4fb4842557 00000000000000cd
GPR08: 000000000001f400 000000001ed035dc 0000000000000000 0000000000000000
GPR12: 0000000000000000 c00000001eb5e480 c0000003a1b53f90 000000001eea3e20
GPR16: 0000000000000000 c0000006fd845100 c00000000004c8b0 c0000000013d5300
GPR20: c0000006fd845300 0000000000000008 c0000000019d2cf8 c0000000013d6888
GPR24: 0000000000000069 c0000000013d688c 0000000000000002 c0000000013d688c
GPR28: c0000000019cecf0 0000000000000348 0000000000000000 0000000000000000
NIP [0000000000000000]           (null)
LR [0000000000000000]           (null)
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 60000000 60000000 60000000
---[ end trace 1aa3b4936949457e ]---
Bad kernel stack pointer 1fafb4b0 at 1ec15004
rcu: INFO: rcu_sched detected stalls on CPUs/tasks: 
rcu:    88-...!: (0 ticks this GP) idle=2ce/1/0x4000000000000000 softirq=28076/28076 fqs=78
rcu:    (detected by 72, t=10866 jiffies, g=180529, q=2526)
Sending NMI from CPU 72 to CPUs 88:
CPU 88 didn't respond to backtrace IPI, inspecting paca.
irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 22978 (drmgr)
Back trace of paca->saved_r1 (0xc0000006f94ab750) (possibly stale):
Call Trace:
[c0000006f94ab750] [c0000006f94ab790] 0xc0000006f94ab790 (unreliable)
[c0000006f94ab930] [c0000000000373f8] va_rtas_call_unlocked+0xc8/0xe0
[c0000006f94ab950] [c000000000037a98] rtas_call+0x98/0x200
[c0000006f94ab9a0] [c0000000000d7d28] smp_query_cpu_stopped+0x58/0xe0
[c0000006f94aba20] [c0000000000d9dbc] pseries_cpu_die+0x1ec/0x240
[c0000006f94abad0] [c00000000004f284] __cpu_die+0x44/0x60
[c0000006f94abaf0] [c0000000000d8e10] dlpar_cpu_remove+0x160/0x340
[c0000006f94abbc0] [c0000000000d9184] dlpar_cpu_release+0x74/0x100
[c0000006f94abc10] [c000000000025a74] arch_cpu_release+0x44/0x70
[c0000006f94abc30] [c0000000009bd1bc] cpu_release_store+0x4c/0x80
[c0000006f94abc60] [c0000000009ae000] dev_attr_store+0x40/0x70
[c0000006f94abc80] [c000000000495810] sysfs_kf_write+0x70/0xb0
[c0000006f94abca0] [c00000000049453c] kernfs_fop_write+0x17c/0x250
[c0000006f94abcf0] [c0000000003ccb6c] __vfs_write+0x4c/0x1f0
[c0000006f94abd80] [c0000000003ccf74] vfs_write+0xd4/0x240
[c0000006f94abdd0] [c0000000003cd338] ksys_write+0x68/0x110
[c0000006f94abe20] [c00000000000b288] system_call+0x5c/0x70
rcu: rcu_sched kthread starved for 10709 jiffies! g180529 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=72
rcu: RCU grace-period kthread stack dump:
rcu_sched       I    0    11      2 0x00000808
Call Trace:
[c0000000061ab840] [c0000003a4a84800] 0xc0000003a4a84800 (unreliable)
[c0000000061aba20] [c00000000001e24c] __switch_to+0x2dc/0x430
[c0000000061aba80] [c000000000e5fb94] __schedule+0x3d4/0xa20
[c0000000061abb50] [c000000000e6022c] schedule+0x4c/0xc0
[c0000000061abb80] [c000000000e64ffc] schedule_timeout+0x1dc/0x4e0
[c0000000061abc80] [c0000000001af40c] rcu_gp_kthread+0xc3c/0x11f0
[c0000000061abdb0] [c00000000013c7c8] kthread+0x168/0x1b0
[c0000000061abe20] [c00000000000b658] ret_from_kernel_thread+0x5c/0x64





