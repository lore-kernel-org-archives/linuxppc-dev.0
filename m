Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4728C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 23:00:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D6A206C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 23:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D6A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445myF0fxVzDqZ3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 10:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445mwP4PHdzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 09:58:28 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MMn0FY017794
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 17:58:26 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtqctgjve-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 17:58:26 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 22 Feb 2019 22:58:25 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 22:58:22 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MMwLBp17367120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 22:58:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FE27AC064;
 Fri, 22 Feb 2019 22:58:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19297AC05B;
 Fri, 22 Feb 2019 22:58:19 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.132.183])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 22:58:18 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
Date: Fri, 22 Feb 2019 19:57:52 -0300
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022222-0068-0000-0000-000003983108
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010646; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164933; UDB=6.00608378; IPR=6.00945521; 
 MB=3.00025703; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-22 22:58:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022222-0069-0000-0000-00004798C9BA
Message-Id: <20190222225752.6375-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220157
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When testing DLPAR CPU add/remove on a system under stress,
pseries_cpu_die() doesn't wait long enough for a CPU to die:

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

This is a race between one CPU stopping and another one calling
pseries_cpu_die() to wait for it to stop. That function does a short busy
loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
that it is stopped, but I think there's a lot for the stopping CPU to do
which may take longer than this loop allows.

As can be seen in the dmesg right before or after the "Querying DEAD?"
messages, if pseries_cpu_die() waited a little longer it would have seen
the CPU in the stopped state.

I see two cases that can be causing this race:

1. It's possible that CPU 134 was inactive at the time it was unplugged. In
   that case, dlpar_offline_cpu() calls H_PROD on that CPU and immediately
   calls pseries_cpu_die(). Meanwhile, the prodded CPU activates and start
   the process of stopping itself. It's possible that the busy loop is not
   long enough to allow for the CPU to wake up and complete the stopping
   process.

2. If CPU 134 was online at the time it was unplugged, it would have gone
   through the new CPU hotplug state machine in kernel/cpu.c that was
   introduced in v4.6 to get itself stopped. It's possible that the busy
   loop in pseries_cpu_die() was long enough for the older hotplug code but
   not for the new hotplug state machine.

I don't know if this race condition has any ill effects, but we can make
the race a lot more even if we only start querying if the CPU is stopped
when the stopping CPU is close to call rtas_stop_self().

Since pseries_mach_cpu_die() sets the CPU current state to offline almost
immediately before calling rtas_stop_self(), we use that as a signal that
it is either already stopped or very close to that point, and we can start
the busy loop.

As suggested by Michael Ellerman, this patch also changes the busy loop to
wait for a fixed amount of wall time.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

I tried to estimate good amounts for the timeout and loop delays, but
I'm not sure how reasonable my numbers are. The busy loops will wait for
100 µs between each try, and spin_event_timeout() will timeout after
100 ms. I'll be happy to change these values if you have better
suggestions.

Gautham was able to test this patch and it solved the race condition.

v1 was a cruder patch which just increased the number of loops:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/153734.html

v1 also mentioned a kernel crash but Gautham narrowed it down to a bug
in RTAS, which is in the process of being fixed.

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 97feb6e79f1a..424146cc752e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -214,13 +214,21 @@ static void pseries_cpu_die(unsigned int cpu)
 			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
+		/*
+		 * If the current state is not offline yet, it means that the
+		 * dying CPU (which is in pseries_mach_cpu_die) didn't have a
+		 * chance to call rtas_stop_self yet and therefore it's too
+		 * early to query if the CPU is stopped.
+		 */
+		spin_event_timeout(get_cpu_current_state(cpu) == CPU_STATE_OFFLINE,
+				   100000, 100);
 
 		for (tries = 0; tries < 25; tries++) {
 			cpu_status = smp_query_cpu_stopped(pcpu);
 			if (cpu_status == QCSS_STOPPED ||
 			    cpu_status == QCSS_HARDWARE_ERROR)
 				break;
-			cpu_relax();
+			udelay(100);
 		}
 	}
 

