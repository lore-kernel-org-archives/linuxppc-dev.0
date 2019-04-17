Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452FC10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C23F21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kRqh6tt2zDqNv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kRnm02BMzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 13:00:59 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3H2tYee100663
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 23:00:56 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwr247akm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 23:00:56 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 04:00:55 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 04:00:54 +0100
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3H30quC45678668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 03:00:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EAB36A054;
 Wed, 17 Apr 2019 03:00:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33E496A057;
 Wed, 17 Apr 2019 03:00:51 +0000 (GMT)
Received: from [9.199.40.202] (unknown [9.199.40.202])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 03:00:50 +0000 (GMT)
Subject: Re: [PATCH v3 7/8] powerpc/mm: Consolidate radix and hash address map
 details
To: Nicholas Piggin <npiggin@gmail.com>, mpe@ellerman.id.au, paulus@samba.org
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
 <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
 <1555422365.eio3zgx55b.astroid@bobo.none>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 17 Apr 2019 08:30:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555422365.eio3zgx55b.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041703-0020-0000-0000-00000ED89E4C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010941; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190175; UDB=6.00623652; IPR=6.00970972; 
 MB=3.00026475; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 03:00:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041703-0021-0000-0000-00006575F9D8
Message-Id: <b6cc2965-27ab-5ee6-0e57-a6ed9122ee08@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170017
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/16/19 7:33 PM, Nicholas Piggin wrote:
> Aneesh Kumar K.V's on April 16, 2019 8:07 pm:
>> We now have
>>
>> 4K page size config
>>
>>   kernel_region_map_size = 16TB
>>   kernel vmalloc start   = 0xc000100000000000
>>   kernel IO start        = 0xc000200000000000
>>   kernel vmemmap start   = 0xc000300000000000
>>
>> with 64K page size config:
>>
>>   kernel_region_map_size = 512TB
>>   kernel vmalloc start   = 0xc008000000000000
>>   kernel IO start        = 0xc00a000000000000
>>   kernel vmemmap start   = 0xc00c000000000000
> 
> Hey Aneesh,
> 
> I like the series, I like consolidating the address spaces into 0xc,
> and making the layouts match or similar isn't a bad thing. I don't
> see any real reason to force limitations on one layout or another --
> you could make the argument that 4k radix should match 64k radix
> as much as matching 4k hash IMO.
> 
> I wouldn't like to tie them too strongly to the same base defines
> that force them to stay in sync.
> 
> Can we drop this patch? Or at least keep the users of the H_ and R_
> defines and set them to the same thing in map.h?
> 
> 

I did that based on the suggestion from Michael Ellerman. I guess he 
wanted the VMALLOC_START to match. I am not sure whether we should match 
the kernel_region_map_size too. I did mention that in the cover letter.

I agree with your suggestion above. I still can keep the VMALLOC_START 
at 16TB and keep the region_map_size as 512TB for radix 4k. I am not 
sure we want to do that.

I will wait for feedback from Michael to make the suggested changes.

-aneesh

