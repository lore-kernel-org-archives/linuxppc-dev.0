Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs0yk36S5zDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:14:38 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CAEY0O039226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 06:14:35 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxcjfkh60-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 06:14:32 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 20:13:43 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8CADeek41287914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:13:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8CADg95029433
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:13:42 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@au1.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit for
 early allocations
In-Reply-To: <1502716387.4493.27.camel@au1.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
 <1502716387.4493.27.camel@au1.ibm.com>
Date: Tue, 12 Sep 2017 15:43:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp54usvj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Mon, 2017-08-14 at 22:49 +1000, Michael Ellerman wrote:
>> > -     /*
>> > -      * We limit the allocation that depend on ppc64_rma_size
>> > -      * to first_memblock_size. We also clamp it to 1GB to
>> > -      * avoid some funky things such as RTAS bugs.
>> 
>> That comment about RTAS is 7 years old, and I'm pretty sure it was a
>> historical note when it was written.
>> 
>> I'm inclined to drop it and if we discover new bugs with RTAS on Power9
>> then we can always put it back.
>
> Arent' we using a 32-bit RTAS ? (Afaik there's a 64-bit one, we just
> never used it ..). In this case we need to at least clamp to 2G (no
> trust RTAS doing unsigned properly).
>

Yes. I added the limit to radix after I observed that we have MSR[SF] =
0.

IIRC it was PACA access that was causing it to crash on return from RTAS.

hmm the commit also explains that.

powerpc/mm/radix: Limit paca allocation in radix

On return from RTAS we access the paca variables and we have 64 bit
disabled. This requires us to limit paca in 32 bit range.

Fix this by setting ppc64_rma_size to first_memblock_size/1G range.

-aneesh
