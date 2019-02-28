Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71249C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:49:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57812171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57812171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44977l4MdCzDqND
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:49:55 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4497574W2yzDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:47:36 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S9iacq123993
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:47:28 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qxd250r22-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 04:47:27 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Feb 2019 09:47:26 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 09:47:24 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S9lNZE21364748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Feb 2019 09:47:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8439C124053;
 Thu, 28 Feb 2019 09:47:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41055124054;
 Thu, 28 Feb 2019 09:47:23 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.84])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 09:47:23 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id B9F412E2D5F; Thu, 28 Feb 2019 15:17:19 +0530 (IST)
Date: Thu, 28 Feb 2019 15:17:19 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries: Only wait for dying CPU after call
 to rtas_stop_self()
References: <20190222225752.6375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222225752.6375-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19022809-0060-0000-0000-000003138F03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010679; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167516; UDB=6.00609944; IPR=6.00948130; 
 MB=3.00025777; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 09:47:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022809-0061-0000-0000-00004873BC6A
Message-Id: <20190228094719.GA24751@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280069
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Thiago,

On Fri, Feb 22, 2019 at 07:57:52PM -0300, Thiago Jung Bauermann wrote:
> When testing DLPAR CPU add/remove on a system under stress,
> pseries_cpu_die() doesn't wait long enough for a CPU to die:
> 
> [  446.983944] cpu 148 (hwid 148) Ready to die...
> [  446.984062] cpu 149 (hwid 149) Ready to die...
> [  446.993518] cpu 150 (hwid 150) Ready to die...
> [  446.993543] Querying DEAD? cpu 150 (150) shows 2
> [  446.994098] cpu 151 (hwid 151) Ready to die...
> [  447.133726] cpu 136 (hwid 136) Ready to die...
> [  447.403532] cpu 137 (hwid 137) Ready to die...
> [  447.403772] cpu 138 (hwid 138) Ready to die...
> [  447.403839] cpu 139 (hwid 139) Ready to die...
> [  447.403887] cpu 140 (hwid 140) Ready to die...
> [  447.403937] cpu 141 (hwid 141) Ready to die...
> [  447.403979] cpu 142 (hwid 142) Ready to die...
> [  447.404038] cpu 143 (hwid 143) Ready to die...
> [  447.513546] cpu 128 (hwid 128) Ready to die...
> [  447.693533] cpu 129 (hwid 129) Ready to die...
> [  447.693999] cpu 130 (hwid 130) Ready to die...
> [  447.703530] cpu 131 (hwid 131) Ready to die...
> [  447.704087] Querying DEAD? cpu 132 (132) shows 2
> [  447.704102] cpu 132 (hwid 132) Ready to die...
> [  447.713534] cpu 133 (hwid 133) Ready to die...
> [  447.714064] Querying DEAD? cpu 134 (134) shows 2
> 
> This is a race between one CPU stopping and another one calling
> pseries_cpu_die() to wait for it to stop. That function does a short busy
> loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
> that it is stopped, but I think there's a lot for the stopping CPU to do
> which may take longer than this loop allows.
> 
> As can be seen in the dmesg right before or after the "Querying DEAD?"
> messages, if pseries_cpu_die() waited a little longer it would have seen
> the CPU in the stopped state.

> 
> I see two cases that can be causing this race:
> 
> 1. It's possible that CPU 134 was inactive at the time it was unplugged. In
>    that case, dlpar_offline_cpu() calls H_PROD on that CPU and immediately
>    calls pseries_cpu_die(). Meanwhile, the prodded CPU activates and start
>    the process of stopping itself. It's possible that the busy loop is not
>    long enough to allow for the CPU to wake up and complete the stopping
>    process.

The problem is a bit more severe since, after printing "Querying
DEAD?" for CPU X, this CPU can prod another offline CPU Y on the same
core which, on waking up, will call rtas_stop_self. Thus we can have two
concurrent calls to rtas-stop-self, which is prohibited by the PAPR.


> 
> 2. If CPU 134 was online at the time it was unplugged, it would have gone
>    through the new CPU hotplug state machine in kernel/cpu.c that was
>    introduced in v4.6 to get itself stopped. It's possible that the busy
>    loop in pseries_cpu_die() was long enough for the older hotplug code but
>    not for the new hotplug state machine.

I haven't been able to observe the "Querying DEAD?" messages for the
online CPU which was being offlined and dlpar'ed out.

> 
> I don't know if this race condition has any ill effects, but we can make
> the race a lot more even if we only start querying if the CPU is stopped
> when the stopping CPU is close to call rtas_stop_self().
> 
> Since pseries_mach_cpu_die() sets the CPU current state to offline almost
> immediately before calling rtas_stop_self(), we use that as a signal that
> it is either already stopped or very close to that point, and we can start
> the busy loop.
> 
> As suggested by Michael Ellerman, this patch also changes the busy loop to
> wait for a fixed amount of wall time.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> I tried to estimate good amounts for the timeout and loop delays, but
> I'm not sure how reasonable my numbers are. The busy loops will wait for
> 100 µs between each try, and spin_event_timeout() will timeout after
> 100 ms. I'll be happy to change these values if you have better
> suggestions.

Based on the measurements that I did on a POWER9 system, in successful
cases of smp_query_cpu_stopped(cpu) returning affirmative, the maximum
time spent inside the loop was was 10ms.


> Gautham was able to test this patch and it solved the race condition.
> 
> v1 was a cruder patch which just increased the number of loops:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/153734.html
> 
> v1 also mentioned a kernel crash but Gautham narrowed it down to a bug
> in RTAS, which is in the process of being fixed.
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 97feb6e79f1a..424146cc752e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -214,13 +214,21 @@ static void pseries_cpu_die(unsigned int cpu)
>  			msleep(1);
>  		}
>  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
> +		/*
> +		 * If the current state is not offline yet, it means that the
> +		 * dying CPU (which is in pseries_mach_cpu_die) didn't have a
> +		 * chance to call rtas_stop_self yet and therefore it's too
> +		 * early to query if the CPU is stopped.
> +		 */
> +		spin_event_timeout(get_cpu_current_state(cpu) == CPU_STATE_OFFLINE,
> +				   100000, 100);
> 
>  		for (tries = 0; tries < 25; tries++) {

Can we bumped up the tries to 100, so that we wait for 10ms before
printing the warning message ?

>  			cpu_status = smp_query_cpu_stopped(pcpu);
>  			if (cpu_status == QCSS_STOPPED ||
>  			    cpu_status == QCSS_HARDWARE_ERROR)
>  				break;
> -			cpu_relax();
> +			udelay(100);
>  		}
>  	}
> 

