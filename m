Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB904C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 03:54:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CDE206EB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 03:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CDE206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bh96T2XCnzDqf9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 13:54:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Bh8xw3fjlzDqdl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 13:46:43 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E69D6E;
 Tue,  1 Sep 2020 20:46:42 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0F23F66F;
 Tue,  1 Sep 2020 20:46:38 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
 <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
 <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
 <2fb4ac88-d417-2bdd-3c56-a816c356636a@linux.ibm.com>
 <5d25b02a-887a-432e-7ecd-cc5cbcea9b02@csgroup.eu>
Message-ID: <ffdc1dfb-4ed3-f1d6-5d90-9e2ed7637a97@arm.com>
Date: Wed, 2 Sep 2020 09:15:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5d25b02a-887a-432e-7ecd-cc5cbcea9b02@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 09/01/2020 01:21 PM, Christophe Leroy wrote:
> 
> 
> Le 01/09/2020 à 09:40, Aneesh Kumar K.V a écrit :
>> On 9/1/20 12:20 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
>>>> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>>>>
>>>>>
>>>>>
>>>>> There is a checkpatch.pl warning here.
>>>>>
>>>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>>>>> #7:
>>>>> Architectures like ppc64 use deposited page table while updating the huge pte
>>>>>
>>>>> total: 0 errors, 1 warnings, 40 lines checked
>>>>>
>>>>
>>>> I will ignore all these, because they are not really important IMHO.
>>>>
>>>
>>> When doing a git log in a 80 chars terminal window, having wrapping lines is not really convenient. It should be easy to avoid it.
>>>
>>
>> We have been ignoring that for a long time  isn't it?
>>
>> For example ppc64 checkpatch already had
>> --max-line-length=90
>>
>>
>> There was also recent discussion whether 80 character limit is valid any more. But I do keep it restricted to 80 character where ever it is easy/make sense.
>>
> 
> Here we are not talking about the code, but the commit log.
> 
> As far as I know, the discussions about 80 character lines, 90 lines in powerpc etc ... is for the code.
> 
> We still aim at keeping lines not longer than 75 chars in the commit log.

Agreed.
