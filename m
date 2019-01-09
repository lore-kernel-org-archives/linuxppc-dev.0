Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFFC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 06:10:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1375D20883
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 06:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1375D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZJdM445jzDqf4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 17:10:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZJbV0mr6zDqcS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 17:08:34 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0964jJI010180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2019 01:08:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pw5mabkbd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 01:08:32 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 9 Jan 2019 06:08:30 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Jan 2019 06:08:27 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0968QvH22085786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 06:08:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5275AC069;
 Wed,  9 Jan 2019 06:08:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8855EAC068;
 Wed,  9 Jan 2019 06:08:26 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.138])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jan 2019 06:08:26 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 9411F2E4C27; Wed,  9 Jan 2019 11:38:23 +0530 (IST)
Date: Wed, 9 Jan 2019 11:38:23 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
References: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
 <87a7li5zv2.fsf@morokweng.localdomain>
 <20181207104311.GA11431@in.ibm.com>
 <20181207120346.GB11431@in.ibm.com>
 <87va443fm3.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va443fm3.fsf@morokweng.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19010906-0052-0000-0000-000003755773
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010371; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01143838; UDB=6.00595524; IPR=6.00924101; 
 MB=3.00025045; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 06:08:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010906-0053-0000-0000-00005F657A4C
Message-Id: <20190109060823.GA20248@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090051
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
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Thiago,

Wish you a happy 2019!

On Sat, Dec 08, 2018 at 12:40:52AM -0200, Thiago Jung Bauermann wrote:
> 
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> > On Fri, Dec 07, 2018 at 04:13:11PM +0530, Gautham R Shenoy wrote:
> >> Sure. I will test the patch and report back.
> >
> > I added the following debug patch on top of your patch, and after an
> > hour's run, the system crashed. Appending the log at the end.
> 
> Thank you very much for testing! Your debug patch was very helpful as
> well.
> 
> > I suppose we still need to increase the number of tries since we wait
> > only for 2.5ms looping before giving up.
> 
> Do you think it would have helped? In the debug output you posted I
> would have expected the following message to show up if the loop
> finished too early, and it didn't:
> 
> "Querying DEAD? cpu %i (%i) shows %i\n"
> 
> So I don't think increasing the loop length would have made a
> difference. In fact, the call to smp_query_cpu_stopped() always
> succeeded on the first iteration.

I did some testing during the holidays. Here are the observations:

1) With just your patch (without any additional debug patch), if I run
DLPAR on /off operations on a system that has SMT=off, I am able to
see a crash involving RTAS stack corruption within an hour's time.

2) With the debug patch (appended below) which has additional debug to
capture the callers of stop-self, start-cpu, set-power-levels, the
system is able to perform DLPAR on/off operations on a system with
SMT=off for three days. And then, it crashed with the dead CPU showing
a "Bad kernel stack pointer". From this log, I can clearly
see that there were no concurrent calls to stop-self, start-cpu,
set-power-levels. The only concurrent RTAS calls were the dying CPU
calling "stop-self", and the CPU running the DLPAR operation calling
"query-cpu-stopped-state". The crash signature is appended below as
well.

3) Modifying your patch to remove the udelay and increase the loop
count from 25 to 1000 doesn't improve the situation. We are still able
to see the crash.

4) With my patch, even without any additional debug, I was able to
observe the system run the tests successfully for over a week (I
started the tests before the Christmas weekend, and forgot to turn it
off!)

It appears that there is a narrow race window involving rtas-stop-self
and rtas-query-cpu-stopped-state calls that can be observed with your
patch. Adding any printk's seems to reduce the probability of hitting
this race window. It might be worth the while to check with RTAS
folks, if they suspect something here.

The Crash log with this debug patch is as follows

[DEBUG] CPU 32 waiting for CPU 130 to enter rtas
cpu 130 (hwid 130) Ready to die...
[DEBUG] CPU 32 noticed CPU 130 enter rtas: tries=0, time=539
[DEBUG] CPU 32 waiting for CPU 131 to enter rtas
cpu 131 (hwid 131) Ready to die...
[DEBUG] CPU 32 noticed CPU 131 enter rtas: tries=0, time=137
[DEBUG] CPU 32 waiting for CPU 132 to enter rtas
cpu 132 (hwid 132) Ready to die...
[DEBUG] CPU 32 noticed CPU 132 enter rtas: tries=0, time=1238
[DEBUG] CPU 32 waiting for CPU 133 to enter rtas
cpu 133 (hwid 133) Ready to die...
[DEBUG] CPU 32 noticed CPU 133 enter rtas: tries=1, time=1259
[DEBUG] CPU 32 waiting for CPU 134 to enter rtas
cpu 134 (hwid 134) Ready to die...
[DEBUG] CPU 32 noticed CPU 134 enter rtas: tries=0, time=1141
[DEBUG] CPU 32 waiting for CPU 135 to enter rtas
cpu 135 (hwid 135) Ready to die...
[DEBUG] CPU 32 noticed CPU 135 enter rtas: tries=0, time=636
cpu 120 (hwid 120) Ready to die...
[DEBUG] CPU 32 waiting for CPU 120 to enter rtas
[DEBUG] CPU 32 noticed CPU 120 enter rtas: tries=0, time=53
[DEBUG] CPU 32 waiting for CPU 121 to enter rtas
cpu 121 (hwid 121) Ready to die...
Bad kernel stack pointer 1fafb400 at 1fafb4b0
Bad kernel stack pointer 1fafb4b0 at 1ec15270
Oops: Bad kernel stack pointer, sig: 6 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 121 PID: 0 Comm: swapper/121 Not tainted 4.20.0-thiago-original-with-debug+ #57
NIP:  000000001ec15270 LR: 000000001ec1526c CTR: 000000001ecd26c4
REGS: c00000001e577d30 TRAP: 0300   Not tainted  (4.20.0-thiago-original-with-debug+)
MSR:  8000000000001000 <SF,ME>  CR: 48000000  XER: 00000020
CFAR: 000000001ecd27a8 DAR: ffffffffffff8108 DSISR: 40000000 IRQMASK: 8000000000009033
GPR00: 000000001ec1526c 000000001fafb4b0 0000000000000000 0000000000000000
GPR04: 0000000001a40968 00000000000000e0 000000000000dfe8 0000000000000018
GPR08: 000000001f82ae00 000000001ed025d4 000000001f827850 0000000000000000
GPR12: 0000000001b6d998 c00000001eb4e080 c0000003a1bdbf90 000000001eea3020
GPR16: 0000000000000000 c0000006fdc45100 c00000000004c8b0 c0000000013d5300
GPR20: c0000006fdc45300 0000000000000008 c0000000019d2cf8 c0000000013d6888
GPR24: 0000000000000079 c0000000013d688c 0000000000000002 c0000000013d688c
GPR28: c0000000019cecf0 00000000000003c8 0000000000000000 000000001fafb4b0
NIP [000000001ec15270] 0x1ec15270
LR [000000001ec1526c] 0x1ec1526c
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace dd774c4912df6c89 ]---


The debug patch over your patch is as follows:

-----------------------x8-------------------------------------------
From e5cad5ff5b61e003810723e549f44a3cc0cef356 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 7 Dec 2018 16:47:25 +0530
Subject: [PATCH] Add debug to Thiago's patch

Also, add debug for callers of rtas-start-cpu and rtas-set-power-level

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c                   |  1 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 ++++++++++
 arch/powerpc/platforms/pseries/smp.c         |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index de35bd8f..9ecf957 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -576,6 +576,7 @@ int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 		return -ENOENT;
 
 	do {
+		printk("CPU %d calling rtas-set-power-level\n", smp_processor_id());
 		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
 	} while (rtas_busy_delay(rc));
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index fad3ceb..3dab7c3 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -214,6 +214,10 @@ static void pseries_cpu_die(unsigned int cpu)
 			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
+		u64 tb_before = mftb();
+		u64 tb_after;
+
+		printk("[DEBUG] CPU %d waiting for CPU %d to enter rtas\n", smp_processor_id(), cpu);
 		/*
 		 * If the current state is not offline yet, it means that the
 		 * dying CPU (which is in pseries_mach_cpu_die) didn't have a
@@ -230,6 +234,12 @@ static void pseries_cpu_die(unsigned int cpu)
 				break;
 			udelay(100);
 		}
+
+		tb_after = mftb();
+
+		printk("[DEBUG] CPU %d noticed CPU %d enter rtas: tries=%d, time=%llu\n",
+			smp_processor_id(), cpu, tries,
+			div_u64(tb_after - tb_before, tb_ticks_per_usec));
 	}
 
 	if (cpu_status != 0) {
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 3df4612..d4624c4 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -123,6 +123,8 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 	if (start_cpu == RTAS_UNKNOWN_SERVICE)
 		return 1;
 
+	printk("CPU %d calling start-cpu for CPU %d\n",
+	       smp_processor_id(), lcpu);
 	status = rtas_call(start_cpu, 3, 1, NULL, pcpu, start_here, pcpu);
 	if (status != 0) {
 		printk(KERN_ERR "start-cpu failed: %i\n", status);
-- 
1.9.4


--
Thanks and Regards
gautham.

