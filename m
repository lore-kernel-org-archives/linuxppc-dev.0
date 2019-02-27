Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B21C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 07:56:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DC321852
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 07:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DC321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Sgm4QbDzDq75
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 18:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Sdn07RVzDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 18:55:08 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1R7sV7s002386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 02:55:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qwp0tsm6w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 02:55:05 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Feb 2019 07:55:03 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 07:55:01 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1R7t0Lu56230116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Feb 2019 07:55:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39ACEAE045;
 Wed, 27 Feb 2019 07:55:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC3B4AE04D;
 Wed, 27 Feb 2019 07:54:59 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Feb 2019 07:54:59 +0000 (GMT)
Received: from [9.102.32.74] (unknown [9.102.32.74])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 996ADA0243;
 Wed, 27 Feb 2019 18:54:57 +1100 (AEDT)
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
To: "Alastair D'Silva" <alastair@d-silva.org>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
 <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 27 Feb 2019 18:54:56 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19022707-4275-0000-0000-000003147F18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022707-4276-0000-0000-00003822C0F3
Message-Id: <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270054
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

On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git 
a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index
>>> e6a607488f8a..16eb8a60d5c7 100644
>>> --- a/drivers/misc/ocxl/file.c
>>> +++ b/drivers/misc/ocxl/file.c
>>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
>>> ocxl_context *ctx,
>>>
>>>    		if (status == ATTACHED) {
>>>    			int rc;
>>> -			struct link *link = ctx->afu->fn->link;
>>> +			void *link = ctx->afu->fn->link;
>>
>> This doesn't look like a rename...
> 
> That corrects the type to what the member (and prototype for ocxl_link_update_pe) declare it as.
> 
> The struct link there is bogus, it shouldn't even compile (since the intended struct link is defined in a different compilation unit), but instead picks up a different definition of 'struct link' from elsewhere.
> 

Given there's only a handful of struct links defined across the entire 
kernel, I'm going to guess that the definition it's picking up is in 
fact the ocxl one.

I think the better solution here is to move struct ocxl_link into 
ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather 
than void *, and update the function signature for ocxl_link_update_pe() 
as well.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

