Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnZGc6nqtzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:01:12 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E4wt7m146393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 01:01:10 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2w0k39du-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 01:01:10 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 14 Jun 2017 15:01:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5E515DX47448294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:01:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5E50uuh007978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:00:56 +1000
Subject: Re: [PATCH] recordmcount.pl: Add ppc64le to list of supported
 architectures
To: Balbir Singh <bsingharora@gmail.com>
References: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 10:31:03 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=xeDFbyPwsdewq-5NK9cgQpBVCfCX_iL5f8u2-y7HwDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e804f96e-d91a-4a16-ef4c-5dcf0e96a764@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 14 June 2017 04:22 AM, Balbir Singh wrote:
> On Tue, Jun 13, 2017 at 4:49 PM, Kamalesh Babulal <
> kamalesh@linux.vnet.ibm.com> wrote:
>
>> Module make on ppc64le, fails with:
>>
>> make -C /root/kernel/linux M=/root/.kpatch/tmp/patch
>> kpatch-data-read-mostly.ko
>> make[1]: Entering directory '/root/kernel/linux'
>>   CC [M]  /root/.kpatch/tmp/patch/patch-hook.o
>> Arch ppc64le is not supported with CONFIG_FTRACE_MCOUNT_RECORD at
>> ./scripts/recordmcount.pl line 379.
>>
>> Fix it by adding 'ppc64le' to list of supported architectures
>> in recordmcount.pl script.
>>
>> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  scripts/recordmcount.pl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
>> index 1633c3e..683b8b5 100755
>> --- a/scripts/recordmcount.pl
>> +++ b/scripts/recordmcount.pl
>> @@ -264,7 +264,7 @@ if ($arch eq "x86_64") {
>>      $ld .= " -m shlelf_linux";
>>      $objcopy .= " -O elf32-sh-linux";
>>
>> -} elsif ($arch eq "powerpc") {
>> +} elsif ($arch eq "powerpc" || $arch eq "ppc64le") {
>>
>
> I don't get this, the arch should always be powerpc. Where did you get the
> ppc64le
> from? Am I missing anything?
>
> Balbir Singh.
>

Thanks for the review. True, the top level Makefile derives the ARCH 
from SUBARCH where ppc64le is replaced by powerpc. Out of tree module 
build fails, where the ARCH gets overruled to underlying arch type.

-- 
cheers,
Kamalesh.
