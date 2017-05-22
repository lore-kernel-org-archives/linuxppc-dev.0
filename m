Return-Path: <srs0=ejaj=44=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWnwP1cX1zDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 04:57:41 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wWnwP104gz8t8V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 04:57:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wWnwN52hcz9s0m
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 04:57:40 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4MIXnFQ079904
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 14:57:36 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2am3vpc6jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 14:57:36 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 23 May 2017 04:57:33 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4MIvN1247054874
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 04:57:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4MIupNt009852
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 04:56:51 +1000
Subject: Re: [PATCH 2/2] powerpc/fadump: update about offset where fadump is
 reserved
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Prarit Bhargava <prarit@redhat.com>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Young <dyoung@redhat.com>
References: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
 <149544568763.16888.16656118217496342159.stgit@hbathini.in.ibm.com>
 <20170522125519.158e9a68@kitsune.suse.cz>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 23 May 2017 00:26:35 +0530
MIME-Version: 1.0
In-Reply-To: <20170522125519.158e9a68@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0edc1c7b-bdc9-f157-ed56-f69ea11ba177@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Michal,

Thanks for the review..

On Monday 22 May 2017 04:25 PM, Michal Suchánek wrote:
> On Mon, 22 May 2017 15:04:47 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> With commit f6e6bedb7731 ("powerpc/fadump: Reserve memory at an offset
>> closer to bottom of RAM"), memory for fadump is no longer reserved at
>> the top of RAM. But there are still a few places which say so. Change
>> them appropriately.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>   Documentation/powerpc/firmware-assisted-dump.txt |    4 ++--
>>   arch/powerpc/kernel/fadump.c                     |    4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
>> b/Documentation/powerpc/firmware-assisted-dump.txt index
>> 9cabaf8..bdd344a 100644 ---
>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -61,8 +61,8 @@
>> as follows: boot successfully. For syntax of crashkernel= parameter,
>>            refer to Documentation/kdump/kdump.txt. If any offset is
>>            provided in crashkernel= parameter, it will be ignored
>> -         as fadump reserves memory at end of RAM for boot memory
>> -         dump preservation in case of a crash.
>> +         as fadump uses a predefined offset to reserve memory
>> +         for boot memory dump preservation in case of a crash.
> What is the reason for fadump to prefer a random offset calculated by
> the kernel over a random offset supplied by the user?
>

An offset provided by user needs multiple checks failing which can be 
tricky.
While implementation is still possible, it makes the code complicated for no
practical gain as commit f6e6bedb7731 is already calculating the best 
possible
offset..

Thanks
Hari
