Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48CC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 10:58:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3492086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 10:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3492086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43413W5N5NzDqjb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 21:58:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4341191CDczDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 21:56:12 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARArr9j046133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 05:56:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p13g5k8g9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 05:56:09 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 10:56:07 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 10:56:05 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARAu4eg56754214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 10:56:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF55A405B;
 Tue, 27 Nov 2018 10:56:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78205A4057;
 Tue, 27 Nov 2018 10:56:02 +0000 (GMT)
Received: from [9.77.211.220] (unknown [9.77.211.220])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 27 Nov 2018 10:56:02 +0000 (GMT)
Subject: Re: [PATCH RESEND] powerpc/perf: Update perf_regs structure to
 include SIER
To: Christophe LEROY <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
 acme@kernel.org
References: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20d4dbad-3b93-37dd-2278-74356bec3393@c-s.fr>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 27 Nov 2018 16:25:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20d4dbad-3b93-37dd-2278-74356bec3393@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18112710-0028-0000-0000-000003222186
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112710-0029-0000-0000-000023DE29DC
Message-Id: <881b06d6-b101-c662-2ac9-7704e580ad6d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270096
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 27/11/18 12:24 PM, Christophe LEROY wrote:
>
>
> Le 26/11/2018 à 19:04, Madhavan Srinivasan a écrit :
>> On each sample, Sample Instruction Event Register (SIER) content
>> is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
>> but instead, SIER content is saved in the "dar" register of pt_regs.
>>
>> Patch adds another entry to the perf_regs structure to include the 
>> "SIER"
>> printing which internally maps to the "dar" of pt_regs.
>>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>
> I see this patch is already in patchwork 
> https://patchwork.ozlabs.org/patch/941908/ and I can't spot any 
> difference between the two. Please say here (under the ---) the reason 
> for resending.


Yes there is no change, justed added the Tested-by tag
and resent it for arnaldo's review/ack.
May be should have avoided resend tag. My bad.

Maddy

>
> Christophe
>
>
>> arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
>>   arch/powerpc/perf/perf_regs.c                   | 1 +
>>   tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
>>   tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
>>   tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
>>   5 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h 
>> b/arch/powerpc/include/uapi/asm/perf_regs.h
>> index 9e52c86ccbd3..ff91192407d1 100644
>> --- a/arch/powerpc/include/uapi/asm/perf_regs.h
>> +++ b/arch/powerpc/include/uapi/asm/perf_regs.h
>> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>>       PERF_REG_POWERPC_TRAP,
>>       PERF_REG_POWERPC_DAR,
>>       PERF_REG_POWERPC_DSISR,
>> +    PERF_REG_POWERPC_SIER,
>>       PERF_REG_POWERPC_MAX,
>>   };
>>   #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
>> diff --git a/arch/powerpc/perf/perf_regs.c 
>> b/arch/powerpc/perf/perf_regs.c
>> index 09ceea6175ba..c262aea22ad9 100644
>> --- a/arch/powerpc/perf/perf_regs.c
>> +++ b/arch/powerpc/perf/perf_regs.c
>> @@ -69,6 +69,7 @@ static unsigned int 
>> pt_regs_offset[PERF_REG_POWERPC_MAX] = {
>>       PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
>>       PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
>>       PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
>> +    PT_REGS_OFFSET(PERF_REG_POWERPC_SIER, dar),
>>   };
>>     u64 perf_reg_value(struct pt_regs *regs, int idx)
>> diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h 
>> b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
>> index 9e52c86ccbd3..ff91192407d1 100644
>> --- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
>> +++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
>> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>>       PERF_REG_POWERPC_TRAP,
>>       PERF_REG_POWERPC_DAR,
>>       PERF_REG_POWERPC_DSISR,
>> +    PERF_REG_POWERPC_SIER,
>>       PERF_REG_POWERPC_MAX,
>>   };
>>   #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
>> diff --git a/tools/perf/arch/powerpc/include/perf_regs.h 
>> b/tools/perf/arch/powerpc/include/perf_regs.h
>> index 00e37b106913..1076393e6f43 100644
>> --- a/tools/perf/arch/powerpc/include/perf_regs.h
>> +++ b/tools/perf/arch/powerpc/include/perf_regs.h
>> @@ -62,7 +62,8 @@ static const char *reg_names[] = {
>>       [PERF_REG_POWERPC_SOFTE] = "softe",
>>       [PERF_REG_POWERPC_TRAP] = "trap",
>>       [PERF_REG_POWERPC_DAR] = "dar",
>> -    [PERF_REG_POWERPC_DSISR] = "dsisr"
>> +    [PERF_REG_POWERPC_DSISR] = "dsisr",
>> +    [PERF_REG_POWERPC_SIER] = "sier"
>>   };
>>     static inline const char *perf_reg_name(int id)
>> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c 
>> b/tools/perf/arch/powerpc/util/perf_regs.c
>> index ec50939b0418..07fcd977d93e 100644
>> --- a/tools/perf/arch/powerpc/util/perf_regs.c
>> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
>> @@ -52,6 +52,7 @@ const struct sample_reg sample_reg_masks[] = {
>>       SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
>>       SMPL_REG(dar, PERF_REG_POWERPC_DAR),
>>       SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
>> +    SMPL_REG(sier, PERF_REG_POWERPC_SIER),
>>       SMPL_REG_END
>>   };
>>
>

