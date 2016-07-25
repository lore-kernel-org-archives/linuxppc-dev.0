Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryWV14vlZzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:26:01 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P6NdeL045743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 02:25:59 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c2qujyf1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 02:25:58 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 00:25:58 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 00/10] Use jump label for cpu/mmu_has_feature
In-Reply-To: <20160725152201.03788ccb@roar.ozlabs.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160725152201.03788ccb@roar.ozlabs.ibm.com>
Date: Mon, 25 Jul 2016 11:55:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shuykzdd.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Sat, 23 Jul 2016 14:42:33 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Changes from V1:
>> * Update "powerpc/mm: Convert early cpu/mmu feature check to use the
>> new helpers" based on resend code changes in this area.
>> 
>> We now do feature fixup early and hence we can reduce the usage of
>>  __cpu/__mmu_has_feature.
>
> Is there a particular reason for for-4.8?
>
> I've only just started following this development so it might be
> obvious, but if you could add some small justifications for why
> a patch or series is done, it would be of great help to me.

The goal is to reduce the impact of radix series on existing MMU
function. With radix series, we do

if (radix_enabled())
        radix_function()
else
        hash_function()

We did try to reduce the impact in most code path like linux page table
accessors by moving linux pte bits around to match the radix/hardware
requirements. But we still have other code paths where we do the above
conditional.

Now for-4.8 is mainly because, I was trying to make sure 4.8 release
will have a good performing radix/hash implementation which distros can
base their kernel on. This series was posted to external list multiple
times and I didn't receive many objections to the series. Hence I was
thinking it to be a good idea to get it upstream by 4.8.
 
-aneesh
