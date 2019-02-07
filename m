Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731DC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:01:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE39218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE39218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w8PF1zYFzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 18:01:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w8MV0KD6zDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 18:00:05 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x176sMsZ035233
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2019 02:00:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qge9ukfd9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 02:00:03 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 7 Feb 2019 07:00:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 7 Feb 2019 06:59:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x176xwPL60358674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 06:59:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C35A4AE045;
 Thu,  7 Feb 2019 06:59:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 683DBAE04D;
 Thu,  7 Feb 2019 06:59:58 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  7 Feb 2019 06:59:58 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id F012FA01B6;
 Thu,  7 Feb 2019 17:59:53 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc/64s: Work around spurious warning on old gccs
 with -fsanitize-coverage
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
 <20190207063736.GS14180@gate.crashing.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 7 Feb 2019 17:59:48 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207063736.GS14180@gate.crashing.org>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19020707-0020-0000-0000-00000313D454
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020706-0021-0000-0000-00002164DAF4
Message-Id: <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-07_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=578 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070054
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
 dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 7/2/19 5:37 pm, Segher Boessenkool wrote:
> On Thu, Feb 07, 2019 at 04:33:23PM +1100, Andrew Donnellan wrote:
>> Some older gccs (<GCC 7), when invoked with -fsanitize-coverage=trace-pc,
>> cause a spurious uninitialised variable warning in dt_cpu_ftrs.c:
>>
>>    arch/powerpc/kernel/dt_cpu_ftrs.c: In function ‘cpufeatures_process_feature’:
>>    arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: ‘m’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>      if (m->cpu_ftr_bit_mask)
> 
> It seems to me the warning is correct?  If enable_unknown is false and no
> cpu_feature is found, it will in
> 
> 	if (m->cpu_ftr_bit_mask)
> 		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
> 
> enable random features (whatever was last in the table), or indeed access
> via NULL if the table is length 0?  So maybe this should be
> 
> 	if (known && m->cpu_ftr_bit_mask)
> 		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
> 
> instead?  (The code would be much clearer if all the known vs. !known
> codepath was fully separated here).

The table is never length 0, it's a statically defined array.

> 
> 
> Segher
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

