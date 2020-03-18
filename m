Return-Path: <SRS0=Ik3v=5D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE44C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 07:40:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BE320768
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 07:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BE320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48j25g04TRzDqj4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 18:40:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48j1wT2gM1zDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 18:32:57 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02I7W2cU026436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 03:32:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu719euwr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 03:32:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Wed, 18 Mar 2020 07:32:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 07:32:47 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02I7Wkcn44499008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 07:32:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3289CA4062;
 Wed, 18 Mar 2020 07:32:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92E91A405C;
 Wed, 18 Mar 2020 07:32:37 +0000 (GMT)
Received: from [9.199.43.180] (unknown [9.199.43.180])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 07:32:36 +0000 (GMT)
Subject: Re: [PATCH 08/15] powerpc/watchpoint: Disable all available
 watchpoints when !dawr_force_enable
To: Christophe Leroy <christophe.leroy@c-s.fr>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-9-ravi.bangoria@linux.ibm.com>
 <1381b9f9-4999-0e03-8344-af84a88fa074@c-s.fr>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Wed, 18 Mar 2020 13:02:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1381b9f9-4999-0e03-8344-af84a88fa074@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031807-0012-0000-0000-00000393063F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031807-0013-0000-0000-000021CFE7B7
Message-Id: <8c97ae26-e0df-1e71-e70f-5d1b1b4e1097@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_02:2020-03-17,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=884
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180034
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
Cc: apopple@linux.ibm.com, mikey@neuling.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, peterz@infradead.org,
 oleg@redhat.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, jolsa@kernel.org, fweisbec@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 3/17/20 4:05 PM, Christophe Leroy wrote:
> 
> 
> Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
>> Instead of disabling only first watchpoint, disable all available
>> watchpoints while clearing dawr_force_enable.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/dawr.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
>> index 311e51ee09f4..5c882f07ac7d 100644
>> --- a/arch/powerpc/kernel/dawr.c
>> +++ b/arch/powerpc/kernel/dawr.c
>> @@ -50,9 +50,13 @@ int set_dawr(struct arch_hw_breakpoint *brk, int nr)
>>       return 0;
>>   }
>> -static void set_dawr_cb(void *info)
>> +static void disable_dawrs(void *info)
> 
> Can you explain a bit more what you do exactly ? Why do you change the name of the function and why the parameter becomes NULL ? And why it doens't take into account the parameter anymore ?

Before:
   static void set_dawr_cb(void *info)
   {
           set_dawr(info);
   }
   
   static ssize_t dawr_write_file_bool(...)
   {
   	...
           /* If we are clearing, make sure all CPUs have the DAWR cleared */
           if (!dawr_force_enable)
                   smp_call_function(set_dawr_cb, &null_brk, 0);
   }

After:
   static void disable_dawrs(void *info)
   {
           struct arch_hw_breakpoint null_brk = {0};
           int i;
   
           for (i = 0; i < nr_wp_slots(); i++)
                   set_dawr(&null_brk, i);
   }
   
   static ssize_t dawr_write_file_bool(...)
   {
   	...
           /* If we are clearing, make sure all CPUs have the DAWR cleared */
           if (!dawr_force_enable)
                   smp_call_function(disable_dawrs, NULL, 0);
   }

We use callback function only for disabling watchpoint. Thus I renamed
it to disable_dawrs(). And we are passing null_brk as parameter which
is not really required while disabling watchpoint. So removed it.

Thanks,
Ravi

