Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4JsS6CMbzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:47:40 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 11 May 2016 11:47:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 277DE2BB0064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:47:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4B1l42F66912300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:47:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4B1kCX9010796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:46:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] Deduplicate the actual base page size code
In-Reply-To: <8def36ee-f94f-8d31-da87-dfe896df4df4@gmail.com>
References: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
 <1462892262-18066-3-git-send-email-bsingharora@gmail.com>
 <871t59kcnh.fsf@skywalker.in.ibm.com>
 <8def36ee-f94f-8d31-da87-dfe896df4df4@gmail.com>
Date: Wed, 11 May 2016 07:15:39 +0530
Message-ID: <87vb2liczg.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 11/05/16 04:09, Aneesh Kumar K.V wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> 
>>> Deduplicate to one function to compute the actual page size.
>>> Some additional warnings added for AP size as well.
>> 
>> 
>> This is getting chaned in a cleanup series I am testing before posting. 
>> The change from ap to psize need more update in commit message. 
>> 
>> commit 701e0d3dc33c93a97b825f403d58f6be99b89203
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Date:   Tue May 10 11:33:15 2016 +0530
>> 
>>     powerpc/mm/radix/hugetlb: Add helper for finding page size from hstate
>>     
>>     Use the helper instead of open coding the same at multiple place
>>     
>>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> This version makes more sense. While we are at it, mind replacing psize with base_psize and asserting
> that base_psize is always 0 or 5.
>

With radix config there is no base/actual page size. The new function is
returning MMU_PAGE_* values and not the AP encoding.

-aneesh
