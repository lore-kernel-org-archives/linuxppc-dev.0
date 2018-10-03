Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEA6C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 08:31:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B9320684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 08:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B9320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q8Pc59HDzF3JN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:31:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q8M74vyzzF3D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 18:29:22 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w938T3eb067908
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 04:29:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mvsgx1w59-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 04:29:19 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 3 Oct 2018 09:29:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 09:29:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w938TChi66191560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 08:29:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12F6111C050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 11:28:50 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6E4311C04A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 11:28:49 +0100 (BST)
Received: from [9.145.45.50] (unknown [9.145.45.50])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 11:28:49 +0100 (BST)
Subject: Re: [PATCH kernel] cxl: Remove unused include
To: linuxppc-dev@lists.ozlabs.org
References: <20180928063804.35692-1-aik@ozlabs.ru>
 <875zypu6vg.fsf@concordia.ellerman.id.au>
 <548a710f-b542-b361-b056-74a8d58c5ceb@ozlabs.ru>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 3 Oct 2018 10:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <548a710f-b542-b361-b056-74a8d58c5ceb@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100308-0008-0000-0000-0000027A47F3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100308-0009-0000-0000-000021E367A3
Message-Id: <0f52023f-75a6-5eb6-a094-6ee88a1d9fa6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-03_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=809 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030086
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 03/10/2018 à 09:46, Alexey Kardashevskiy a écrit :
> 
> 
> On 28/09/2018 22:46, Michael Ellerman wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>> The included opal.h gives a wrong idea that CXL makes PPC OPAL calls
>>> while it does not so let's remote it.
>>
>> But it does use eg.
>>
>>    OPAL_PHB_CAPI_MODE_SNOOP_ON
>>    OPAL_PHB_CAPI_MODE_CAPI
>>
>> Which come from opal-api.h via opal.h.
>>
>> So you should at least include opal-api.h.
> 
> 
> I'd say that since it includes pnv-pci.h (and this is why this patch
> compiles), it should be a different set of values for powernv (which
> would map 1:1 to OPAL_PHB_xxx). The powernv platform knowledge is
> already intimate enough for a driver to have. Dunno, I found this opal.h
> inclusion confusing, that's all.


I agree, it would be the cleaner way of doing it. It's going to be 
pretty low on my list though...

   Fred


> 
> 
>>
>> cheers
>>
>>> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
>>> index b66d832..8cbcbb7 100644
>>> --- a/drivers/misc/cxl/pci.c
>>> +++ b/drivers/misc/cxl/pci.c
>>> @@ -17,7 +17,6 @@
>>>   #include <linux/pci.h>
>>>   #include <linux/of.h>
>>>   #include <linux/delay.h>
>>> -#include <asm/opal.h>
>>>   #include <asm/msi_bitmap.h>
>>>   #include <asm/pnv-pci.h>
>>>   #include <asm/io.h>
>>> -- 
>>> 2.11.0
> 

