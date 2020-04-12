Return-Path: <SRS0=Pd+i=54=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966CC2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2020 12:09:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8210520656
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2020 12:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8210520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 490Vsw1BZMzDqSs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2020 22:09:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 490Vq10Q4ZzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2020 22:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 490Vpz5zLJz8tQH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2020 22:06:51 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 490Vpz5Fx8z9sSr; Sun, 12 Apr 2020 22:06:51 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=psampat@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 490Vpz0MJmz9sSj
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2020 22:06:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03CC4Zgb095488
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2020 08:06:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30ba1fsxsb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2020 08:06:46 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <psampat@linux.ibm.com>;
 Sun, 12 Apr 2020 13:06:21 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 12 Apr 2020 13:06:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 03CC6eeA45416758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2020 12:06:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4194EAE045;
 Sun, 12 Apr 2020 12:06:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73695AE055;
 Sun, 12 Apr 2020 12:06:38 +0000 (GMT)
Received: from [9.79.189.139] (unknown [9.79.189.139])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2020 12:06:38 +0000 (GMT)
Subject: Re: [RFC] Support stop state version quirk and firmware enabled stop
To: ego@linux.vnet.ibm.com
References: <20200304155648.11501-1-psampat@linux.ibm.com>
 <20200408095033.GC950@in.ibm.com>
From: Pratik Sampat <psampat@linux.ibm.com>
Date: Sun, 12 Apr 2020 17:36:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408095033.GC950@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20041212-0008-0000-0000-0000036F447B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041212-0009-0000-0000-00004A90ECD6
Message-Id: <6a784877-6fe6-0d48-1141-11fdb060930a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-12_02:2020-04-11,
 2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120106
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
Cc: mikey@neuling.org, pratik.r.sampat@gmail.com, vaidy@linux.ibm.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, linuxppc-dev@ozlabs.org,
 oohall@gmail.com, skiboot@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Gautham,

On 08/04/20 3:20 pm, Gautham R Shenoy wrote:
> Hi Pratik,
>
> On Wed, Mar 04, 2020 at 09:26:48PM +0530, Pratik Rajesh Sampat wrote:
>> A concept patch in Skiboot to illustrate the case wherein handling of
>> stop states for different DD versions of a CPU can be achieved by a
>> simple modification in the list of cpu_features.
>> As an example idle-stop1 is defined which uses P9_CPU_DD1 to define the
>> cpu feature.
>>
>> Along with that, an implementation is being worked upon the LE OPAL
>> series which helps OPAL handle the stop state entry and exit.
>>
>> This patch advertises this capability of the firmware which can be
>> availed if the quirk-version-setting is not cognizable.
>>
>> The firmware-enabled stop is being worked by Abhishek Goel
>> <huntbag@linux.vnet.ibm.com> building upon the LE OPAL series.
>>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   core/cpufeatures.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/core/cpufeatures.c b/core/cpufeatures.c
>> index ec30c975..b9875e7b 100644
>> --- a/core/cpufeatures.c
>> +++ b/core/cpufeatures.c
>> @@ -510,6 +510,25 @@ static const struct cpu_feature cpu_features_table[] = {
>>   	-1, -1, -1,
>>   	NULL, },
>>
>> +	/*
>> +	 * QUIRK for ISAv3.0B stop idle instructions and registers
>> +	 * Helps us determine if there are any quirks
>> +	 * XXX: Same of idle-stop
>> +	 */
>> +	{ "idle-stop-v1",
>> +	CPU_P9_DD1,
>> +	ISA_V3_0B, USABLE_HV|USABLE_OS,
>> +	HV_CUSTOM, OS_CUSTOM,
>> +	-1, -1, -1,
>> +	NULL, },
>
> So, at this point, we don't need any such quirk for any of the DD
> version right ? This is to demonstrate that if say P9_DD1 had a quirk
> w.r.t stop-state handling, then this is how we would advertise it to
> the kernel.

Absolutely, A dummy property has been added to show how quirk handling
with stop-states.

>> +
>> +	{ "firmware-stop-supported",
>> +	CPU_P9,
>> +	ISA_V3_0B, USABLE_HV|USABLE_OS,
>> +	HV_CUSTOM, OS_CUSTOM,
>> +	-1, -1, -1,
>> +	NULL, },
>> +
>
> I suppose this is for the opal-cpuidle driver support posted here:
> https://lists.ozlabs.org/pipermail/skiboot/2020-April/016726.html

Right, this complements in usage of the opal-cpuidle driver

>>   	/*
>>   	 * ISAv3.0B Hypervisor Virtualization Interrupt
>>   	 * Also associated system registers, LPCR EE, HEIC, HVICE,
>> @@ -883,6 +902,9 @@ static void add_cpufeatures(struct dt_node *cpus,
>>   		const struct cpu_feature *f = &cpu_features_table[i];
>>
>>   		if (f->cpus_supported & cpu_feature_cpu) {
>> +			if (!strcmp(f->name, "firmware-stop-supported") &&
>> +			    HAVE_BIG_ENDIAN)
>> +				continue;
> In OPAL do we have an macro defining BIG_ENDIAN ? If yes, you could
> wrap the "firmware-stop-supported" in cpu_features_table[] within
> #ifndef BIG_ENDIAN. That way you won't need a special case here.
>
HAVE_BIG_ENDIAN is actually a macro. Its a good idea to wrap it in
the declaration itself.

>
>>   			DBG("  '%s'\n", f->name);
>>   			add_cpu_feature_nodeps(features, f);
>>   		}
>> -- 
>> 2.24.1
>>
> --
> Thanks and Regards
> gautham.

