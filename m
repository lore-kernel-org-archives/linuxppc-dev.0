Return-Path: <SRS0=nti5=QR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71351C282C2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:17:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738AD21773
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738AD21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xxx93m2czDqVN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xxvM5fsDzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 16:15:27 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1A5Dxsn043239
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 00:15:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qjd1bskjj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 00:15:24 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Sun, 10 Feb 2019 05:15:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 10 Feb 2019 05:15:20 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1A5FJ298389040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 10 Feb 2019 05:15:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B562A11C04A;
 Sun, 10 Feb 2019 05:15:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6426411C04C;
 Sun, 10 Feb 2019 05:15:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 10 Feb 2019 05:15:19 +0000 (GMT)
Received: from [9.81.210.234] (unknown [9.81.210.234])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E4D92A01C9;
 Sun, 10 Feb 2019 16:15:09 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc/64s: Work around spurious warning on old gccs
 with -fsanitize-coverage
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
 <20190207063736.GS14180@gate.crashing.org>
 <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
 <20190207074947.GT14180@gate.crashing.org>
 <e1e1fc85-6ab6-ba91-c91f-21c3f51ee6ee@au1.ibm.com>
 <87h8dfj83j.fsf@concordia.ellerman.id.au>
 <20190208154147.GX14180@gate.crashing.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Sun, 10 Feb 2019 16:14:37 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208154147.GX14180@gate.crashing.org>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19021005-0028-0000-0000-00000346B689
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021005-0029-0000-0000-00002404CE87
Message-Id: <0202627b-ac63-233b-41bc-b16a19b54c0f@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-10_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100040
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
Cc: syzkaller@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 dvyukov@google.com, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/2/19 2:41 am, Segher Boessenkool wrote:
> On Fri, Feb 08, 2019 at 02:02:24PM +1100, Michael Ellerman wrote:
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> index 8be3721d9302..a1acccd25839 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -675,12 +675,10 @@ static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
>>   		}
>>   	}
>>   
>> -	if (!known && enable_unknown) {
>> -		if (!feat_try_enable_unknown(f)) {
>> -			pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
>> -				f->name);
>> -			return false;
>> -		}
>> +	if (!known && (!enable_unknown || !feat_try_enable_unknown(f))) {
>> +		pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
>> +			f->name);
>> +		return false;
>>   	}
>>   
>>   	if (m->cpu_ftr_bit_mask)
>     		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
> 
> This still set the wrong mask here, which is the bug you're trying to fix.
> It should only do this if "known", afaics.

I've got a v2 ready to send which fixes both things.

> 
> 
> Segher
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

