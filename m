Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttZHP1tj6zDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 13:18:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v042Ic3u047613
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 21:18:38 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rpyd26d5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 21:18:29 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 19:18:29 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix pgtable pmd cache init
In-Reply-To: <20170104121658.1298adac@roar.ozlabs.ibm.com>
References: <20170103155517.24347-1-npiggin@gmail.com>
 <87eg0j7f7q.fsf@linux.vnet.ibm.com>
 <20170104121658.1298adac@roar.ozlabs.ibm.com>
Date: Wed, 04 Jan 2017 07:48:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmvn7eky.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 04 Jan 2017 07:34:41 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > Commit 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
>> > mixed up PMD_INDEX_SIZE and PMD_CACHE_INDEX a couple of times. This
>> > resulted in 64s/hash/4k configs to panic at boot with a false positive
>> > error check.
>> >
>> > Fix that and simplify error handling by moving the check to the caller.
>> >
>> > Fixes: 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
>> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> > Cc: Scott Wood <oss@buserror.net>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
>> 
>> I did another fix here.
>> 
>> https://lkml.kernel.org/r/20161214043349.23677-1-aneesh.kumar@linux.vnet.ibm.com
>> 
>> But this patch makes it much simpler. Hence.
>> 
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> There is this hunk in the patch I did.
>
> Ah, I missed that. My patch just fixes the 9b081e10805cd bug, but this
> hunk looks like it should still go in as another patch. Will you resend
> it?
>

ok will do that.

-aneesh
