Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A353C282DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:02:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C011F217FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 01:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C011F217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l16M0cpszDqPK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:02:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l14B1XTXzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 11:00:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3I0xGYE029611
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 21:00:18 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rxdx52bau-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 21:00:18 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 18 Apr 2019 02:00:18 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Apr 2019 02:00:16 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3I10F8R18350122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2019 01:00:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFE4FAE06B;
 Thu, 18 Apr 2019 01:00:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 075FBAE05F;
 Thu, 18 Apr 2019 01:00:14 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.230.182])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Apr 2019 01:00:13 +0000 (GMT)
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
 <87bm1dfog4.fsf@morokweng.localdomain>
 <1555389147.okxbj1prw2.astroid@bobo.none>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to
 rtas_stop_self()
In-reply-to: <1555389147.okxbj1prw2.astroid@bobo.none>
Date: Wed, 17 Apr 2019 22:00:09 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19041801-0052-0000-0000-000003ADC89F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010947; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190610; UDB=6.00623914; IPR=6.00971408; 
 MB=3.00026491; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-18 01:00:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041801-0053-0000-0000-0000608A4696
Message-Id: <87r2a0jffq.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180004
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello Nick,

Thank you very much for reviewing this patch!

Nicholas Piggin <npiggin@gmail.com> writes:

> Thiago Jung Bauermann's on April 11, 2019 9:08 am:
>>
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerp=
c/platforms/pseries/hotplug-cpu.c
>>> index 97feb6e79f1a..ac6dc35ab829 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>>> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>>>  			msleep(1);
>>>  		}
>>>  	} else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLINE)=
 {
>>> +		/*
>>> +		 * If the current state is not offline yet, it means that the
>>> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
>>> +		 * the process of getting there) didn't have a chance yet to
>>> +		 * call rtas_stop_self() and therefore it's too early to query
>>> +		 * if the CPU is stopped.
>>> +		 */
>>> +		spin_event_timeout(get_cpu_current_state(cpu) =3D=3D CPU_STATE_OFFLI=
NE,
>>> +				   100000, 100);
>
> If the CPU state does not go to offline here, you should give up and
> return online, right? Otherwise I think query-cpu-stopped-state can
> get confused by CPUs in idle and you get a false positive.

Can it get confused? My impression from reading the definition for
query-cpu-stopped-state in the PAPR is that it will simply return a
CPU_status value of 2 in that case, meaning that "the processor thread
is not in the RTAS stopped state", but I don't know much about this.

> That race can still happen, we would really need a sequence count check
> over current CPU state to ensure we got a race-free qcss value, but at
> least a check here should make the race implausible to hit.

Actually, since rtas_stop_self() panics if the processor fails to stop
and also since callers of pseries_cpu_die()=C2=B9 already assume that it is
going to succeed in stopping the CPU (given that the function returns
void and can't signal an error), a more straightforward way of
eliminating the race is to simply do this:

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/pl=
atforms/pseries/hotplug-cpu.c
index 97feb6e79f1a..2331a609f48f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -215,7 +215,7 @@ static void pseries_cpu_die(unsigned int cpu)
                }
        } else if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_OFFLIN=
E) {

-               for (tries =3D 0; tries < 25; tries++) {
+               while (true) {
                        cpu_status =3D smp_query_cpu_stopped(pcpu);
                        if (cpu_status =3D=3D QCSS_STOPPED ||
                            cpu_status =3D=3D QCSS_HARDWARE_ERROR)


What do you think?

--
Thiago Jung Bauermann
IBM Linux Technology Center

=C2=B9 dlpar_offline_cpu() and takedown_cpu() in generic code

