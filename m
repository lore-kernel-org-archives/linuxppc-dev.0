Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2366EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:19:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69409218E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69409218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448TBL1c1qzDqH2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 19:19:54 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 448T8Y3HlwzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 19:18:20 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1R84uxD091316
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 03:18:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qwpk116tr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 03:18:17 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Feb 2019 08:18:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 08:18:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1R8IBhw31653972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Feb 2019 08:18:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8057F5204F;
 Wed, 27 Feb 2019 08:18:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CC365205A;
 Wed, 27 Feb 2019 08:18:11 +0000 (GMT)
Received: from [9.102.32.74] (unknown [9.102.32.74])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6B845A0243;
 Wed, 27 Feb 2019 19:18:09 +1100 (AEDT)
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
To: "Alastair D'Silva" <alastair@d-silva.org>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
 <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
 <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
 <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 27 Feb 2019 19:18:08 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19022708-4275-0000-0000-000003148120
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022708-4276-0000-0000-00003822C30C
Message-Id: <97ad5218-4876-956e-e6ef-fb3449eca68e@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270055
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
Cc: 'Arnd Bergmann' <arnd@arndb.de>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 'Greg Kurz' <groug@kaod.org>, linux-kernel@vger.kernel.org,
 'Frederic Barrat' <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 27/2/19 7:04 pm, Alastair D'Silva wrote:
>> -----Original Message-----
>> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> Sent: Wednesday, 27 February 2019 6:55 PM
>> To: Alastair D'Silva <alastair@d-silva.org>; 'Alastair D'Silva'
>> <alastair@au1.ibm.com>
>> Cc: 'Greg Kurz' <groug@kaod.org>; 'Frederic Barrat'
>> <fbarrat@linux.ibm.com>; 'Arnd Bergmann' <arnd@arndb.de>; 'Greg Kroah-
>> Hartman' <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
>>
>> On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git
>> a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index
>>>>> e6a607488f8a..16eb8a60d5c7 100644
>>>>> --- a/drivers/misc/ocxl/file.c
>>>>> +++ b/drivers/misc/ocxl/file.c
>>>>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
>>>>> ocxl_context *ctx,
>>>>>
>>>>>     		if (status == ATTACHED) {
>>>>>     			int rc;
>>>>> -			struct link *link = ctx->afu->fn->link;
>>>>> +			void *link = ctx->afu->fn->link;
>>>>
>>>> This doesn't look like a rename...
>>>
>>> That corrects the type to what the member (and prototype for
>> ocxl_link_update_pe) declare it as.
>>>
>>> The struct link there is bogus, it shouldn't even compile (since the intended
>> struct link is defined in a different compilation unit), but instead picks up a
>> different definition of 'struct link' from elsewhere.
>>>
>>
>> Given there's only a handful of struct links defined across the entire kernel,
>> I'm going to guess that the definition it's picking up is in fact the ocxl one.
>>
> 
> Unlikely, since that's never in a header. It wasn't caught since it was assigned to/from a void*.

Ah, yeah that'd explain it... and it's a pointer so it never needs to 
know its size. I'm clearly not very good at C.

> 
>> I think the better solution here is to move struct ocxl_link into
>> ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather than void
>> *, and update the function signature for ocxl_link_update_pe() as well.
>   
> Not move it, but we could have an opaque declaration there.
> 

Putting it there would fit with all the other ocxl_* structs, but either 
way, we definitely need a declaration in there and get rid of the void*, t

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

