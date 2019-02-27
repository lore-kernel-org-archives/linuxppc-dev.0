Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:48:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E5B20C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E5B20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448cTS5GWwzDqL8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448cQX2fbTzDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 00:45:55 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RDbq7X084486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:45:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwtpdkc9e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 08:45:53 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 27 Feb 2019 13:45:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 13:45:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1RDjjcH43384990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Feb 2019 13:45:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EAA942047;
 Wed, 27 Feb 2019 13:45:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1933442054;
 Wed, 27 Feb 2019 13:45:45 +0000 (GMT)
Received: from [9.145.24.93] (unknown [9.145.24.93])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 13:45:45 +0000 (GMT)
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
 <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
 <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
 <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
 <97ad5218-4876-956e-e6ef-fb3449eca68e@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 27 Feb 2019 14:45:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <97ad5218-4876-956e-e6ef-fb3449eca68e@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022713-0016-0000-0000-0000025B92BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022713-0017-0000-0000-000032B5FADA
Message-Id: <13209edc-d027-4d2f-668b-ad969a25eb06@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270091
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
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, 'Greg Kurz' <groug@kaod.org>,
 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/02/2019 à 09:18, Andrew Donnellan a écrit :
> On 27/2/19 7:04 pm, Alastair D'Silva wrote:
>>> -----Original Message-----
>>> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>> Sent: Wednesday, 27 February 2019 6:55 PM
>>> To: Alastair D'Silva <alastair@d-silva.org>; 'Alastair D'Silva'
>>> <alastair@au1.ibm.com>
>>> Cc: 'Greg Kurz' <groug@kaod.org>; 'Frederic Barrat'
>>> <fbarrat@linux.ibm.com>; 'Arnd Bergmann' <arnd@arndb.de>; 'Greg Kroah-
>>> Hartman' <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org;
>>> linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
>>>
>>> On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git
>>> a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index
>>>>>> e6a607488f8a..16eb8a60d5c7 100644
>>>>>> --- a/drivers/misc/ocxl/file.c
>>>>>> +++ b/drivers/misc/ocxl/file.c
>>>>>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
>>>>>> ocxl_context *ctx,
>>>>>>
>>>>>>             if (status == ATTACHED) {
>>>>>>                 int rc;
>>>>>> -            struct link *link = ctx->afu->fn->link;
>>>>>> +            void *link = ctx->afu->fn->link;
>>>>>
>>>>> This doesn't look like a rename...
>>>>
>>>> That corrects the type to what the member (and prototype for
>>> ocxl_link_update_pe) declare it as.
>>>>
>>>> The struct link there is bogus, it shouldn't even compile (since the 
>>>> intended
>>> struct link is defined in a different compilation unit), but instead 
>>> picks up a
>>> different definition of 'struct link' from elsewhere.
>>>>
>>>
>>> Given there's only a handful of struct links defined across the 
>>> entire kernel,
>>> I'm going to guess that the definition it's picking up is in fact the 
>>> ocxl one.
>>>
>>
>> Unlikely, since that's never in a header. It wasn't caught since it 
>> was assigned to/from a void*.
> 
> Ah, yeah that'd explain it... and it's a pointer so it never needs to 
> know its size. I'm clearly not very good at C.
> 
>>
>>> I think the better solution here is to move struct ocxl_link into
>>> ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather 
>>> than void
>>> *, and update the function signature for ocxl_link_update_pe() as well.
>> Not move it, but we could have an opaque declaration there.
>>
> 
> Putting it there would fit with all the other ocxl_* structs, but either 
> way, we definitely need a declaration in there and get rid of the void*, t


Mmm, it might turn out to be more invasive that planned...
The point was only to have it as an opaque to the outside world, for 
APIs we'd like to deprecate at some point, so I wouldn't sweat too much 
over it.

   Fred

