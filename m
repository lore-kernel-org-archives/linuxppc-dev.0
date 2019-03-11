Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B00C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:31:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E072147C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E072147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J7X16ZXYzDqC0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 06:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44J7V8442zzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 06:30:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2BJK5V9114817
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 15:30:05 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r5vd8v34s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 15:30:04 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 11 Mar 2019 19:30:04 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Mar 2019 19:30:01 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2BJU0DI20971726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2019 19:30:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 793AD7805C;
 Mon, 11 Mar 2019 19:30:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED41478064;
 Mon, 11 Mar 2019 19:29:48 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.211.206])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Mar 2019 19:29:47 +0000 (GMT)
References: <20190222225752.6375-1-bauerman@linux.ibm.com>
 <20190228094719.GA24751@in.ibm.com>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: ego@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
In-reply-to: <20190228094719.GA24751@in.ibm.com>
Date: Mon, 11 Mar 2019 16:29:41 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19031119-0036-0000-0000-00000A96FB86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010740; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01172944; UDB=6.00613221; IPR=6.00953599; 
 MB=3.00025932; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-11 19:30:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031119-0037-0000-0000-00004AFF17C8
Message-Id: <87sgvtciqi.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-11_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110134
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
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello Gautham,

Thanks for your review.

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:

> Hello Thiago,
>
> On Fri, Feb 22, 2019 at 07:57:52PM -0300, Thiago Jung Bauermann wrote:
>> I see two cases that can be causing this race:
>>
>> 1. It's possible that CPU 134 was inactive at the time it was unplugged.=
 In
>>    that case, dlpar_offline_cpu() calls H_PROD on that CPU and immediate=
ly
>>    calls pseries_cpu_die(). Meanwhile, the prodded CPU activates and sta=
rt
>>    the process of stopping itself. It's possible that the busy loop is n=
ot
>>    long enough to allow for the CPU to wake up and complete the stopping
>>    process.
>
> The problem is a bit more severe since, after printing "Querying
> DEAD?" for CPU X, this CPU can prod another offline CPU Y on the same
> core which, on waking up, will call rtas_stop_self. Thus we can have two
> concurrent calls to rtas-stop-self, which is prohibited by the PAPR.

Inded, very good point. I added this information to the patch
description.

>> 2. If CPU 134 was online at the time it was unplugged, it would have gone
>>    through the new CPU hotplug state machine in kernel/cpu.c that was
>>    introduced in v4.6 to get itself stopped. It's possible that the busy
>>    loop in pseries_cpu_die() was long enough for the older hotplug code =
but
>>    not for the new hotplug state machine.
>
> I haven't been able to observe the "Querying DEAD?" messages for the
> online CPU which was being offlined and dlpar'ed out.

Ah, thanks for pointing this out. That was a scenario I thought could
happen when I was investigating this issue but I never confirmed whether
it could really happen. I removed it from the patch description.

>> I don't know if this race condition has any ill effects, but we can make
>> the race a lot more even if we only start querying if the CPU is stopped
>> when the stopping CPU is close to call rtas_stop_self().
>>
>> Since pseries_mach_cpu_die() sets the CPU current state to offline almost
>> immediately before calling rtas_stop_self(), we use that as a signal that
>> it is either already stopped or very close to that point, and we can sta=
rt
>> the busy loop.
>>
>> As suggested by Michael Ellerman, this patch also changes the busy loop =
to
>> wait for a fixed amount of wall time.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> I tried to estimate good amounts for the timeout and loop delays, but
>> I'm not sure how reasonable my numbers are. The busy loops will wait for
>> 100 =C2=B5s between each try, and spin_event_timeout() will timeout after
>> 100 ms. I'll be happy to change these values if you have better
>> suggestions.
>
> Based on the measurements that I did on a POWER9 system, in successful
> cases of smp_query_cpu_stopped(cpu) returning affirmative, the maximum
> time spent inside the loop was was 10ms.

That's very good to know. I added this information to the patch
description.

I also added you in an Analyzed-by tag, I hope it's fine with you.

>> Gautham was able to test this patch and it solved the race condition.
>>
>> v1 was a cruder patch which just increased the number of loops:
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/153734.html
>>
>> v1 also mentioned a kernel crash but Gautham narrowed it down to a bug
>> in RTAS, which is in the process of being fixed.
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc=
/platforms/pseries/hotplug-cpu.c
>> index 97feb6e79f1a..424146cc752e 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -214,13 +214,21 @@ static void pseries_cpu_die(unsigned int cpu)
>>  			msleep(1);
>>  		}
>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE) {
>> +		/*
>> +		 * If the current state is not offline yet, it means that the
>> +		 * dying CPU (which is in pseries_mach_cpu_die) didn't have a
>> +		 * chance to call rtas_stop_self yet and therefore it's too
>> +		 * early to query if the CPU is stopped.
>> +		 */
>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFLIN=
E,
>> +				   100000, 100);
>>
>>  		for (tries =3D 0; tries < 25; tries++) {
>
> Can we bumped up the tries to 100, so that we wait for 10ms before
> printing the warning message ?

Good idea. I increased the loop to 200 iterations so that it can take up
to 20 ms, just to be sure.

>>  			cpu_status =3D smp_query_cpu_stopped(pcpu);
>>  			if (cpu_status =3D=3D QCSS_STOPPED ||
>>  			    cpu_status =3D=3D QCSS_HARDWARE_ERROR)
>>  				break;
>> -			cpu_relax();
>> +			udelay(100);
>>  		}
>>  	}
>>


--
Thiago Jung Bauermann
IBM Linux Technology Center

