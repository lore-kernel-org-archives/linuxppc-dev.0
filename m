Return-Path: <SRS0=ZMG4=T3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95976C07542
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 09:37:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE684206C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 09:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE684206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CBhf01PFzDqLN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 19:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CBfy1Ry9zDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 19:35:52 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4R9Yb8H004284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 05:35:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2srdcrg2ck-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 05:35:46 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 27 May 2019 10:35:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 27 May 2019 10:35:43 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4R9ZgFG51707976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2019 09:35:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE9E4AE058;
 Mon, 27 May 2019 09:35:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C802BAE053;
 Mon, 27 May 2019 09:35:41 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.31.115])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2019 09:35:41 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/nvdimm: Use correct alignment when looking at first
 pfn from a region
In-Reply-To: <925e41ad-cc57-bc03-a2b6-6913c9e98abf@linux.ibm.com>
References: <20190514025512.9670-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hgNUDxjgYNkxOXJ9hfLb6z2+E1yasNoZNDKFUxkCzWLA@mail.gmail.com>
 <925e41ad-cc57-bc03-a2b6-6913c9e98abf@linux.ibm.com>
Date: Mon, 27 May 2019 15:05:40 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052709-0020-0000-0000-00000340DB7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052709-0021-0000-0000-00002193D197
Message-Id: <87k1ecutn7.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-27_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=894 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270067
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 5/14/19 9:59 AM, Dan Williams wrote:
>> On Mon, May 13, 2019 at 7:55 PM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>>
>>> We already add the start_pad to the resource->start but fails to section
>>> align the start. This make sure with altmap we compute the right first
>>> pfn when start_pad is zero and we are doing an align down of start address.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>   kernel/memremap.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/memremap.c b/kernel/memremap.c
>>> index a856cb5ff192..23d77b60e728 100644
>>> --- a/kernel/memremap.c
>>> +++ b/kernel/memremap.c
>>> @@ -59,9 +59,9 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap)
>>>   {
>>>          const struct resource *res = &pgmap->res;
>>>          struct vmem_altmap *altmap = &pgmap->altmap;
>>> -       unsigned long pfn;
>>> +       unsigned long pfn = PHYS_PFN(res->start);
>>>
>>> -       pfn = res->start >> PAGE_SHIFT;
>>> +       pfn = SECTION_ALIGN_DOWN(pfn);
>> 
>> This does not seem right to me it breaks the assumptions of where the
>> first expected valid pfn occurs in the passed in range.
>> 
>
> How do we define the first valid pfn? Isn't that at pfn_sb->dataoff ?

for altmap the pfn_first should be

pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);

?

-aneesh

