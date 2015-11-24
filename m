Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3672B1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:20:52 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 16:50:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 98507E0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:51:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOBKLCK56492098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:50:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOBKKb4029408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:50:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 30/31] powerpc/mm: Move THP headers around
In-Reply-To: <CAOJe8K1SWE-yHrgCb5PN48mb40C-RoyGGOrYiMJu5KFZ_W4hWw@mail.gmail.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1SWE-yHrgCb5PN48mb40C-RoyGGOrYiMJu5KFZ_W4hWw@mail.gmail.com>
Date: Tue, 24 Nov 2015 16:50:18 +0530
Message-ID: <87io4rfxu5.fsf@linux.vnet.ibm.com>
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

Denis Kirjanov <kda@linux-powerpc.org> writes:

> On 11/23/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> We support THP only with book3s_64 and 64K page size. Move
>> THP details to hash64-64k.h to clarify the same.
...

>> -static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
>> -					  unsigned long addr, pmd_t *pmdp,
>> -					  unsigned long old_pmd)
>> -{
>> -
>> -	WARN(1, "%s called with THP disabled\n", __func__);
> We can't reach this function with huge pages disabled, right?
> Would it be better to use WARN_ON_ONCE?

Shouldn't matter, if should never get called and if we get called, them
something is really wrong, and mostly need a kernel fix. This will only
happen during devel mistakes.

-aneesh
