Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs1D823pqzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:26:15 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CANeng053639
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 06:26:13 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxb828gj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 06:26:13 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 12 Sep 2017 20:26:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8CAQ9Ar33357948
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:26:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8CAQ9CY031339
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 20:26:09 +1000
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit
 for early allocations
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org
Date: Tue, 12 Sep 2017 20:26:07 +1000
In-Reply-To: <87wp54usvj.fsf@linux.vnet.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
 <1502716387.4493.27.camel@au1.ibm.com> <87wp54usvj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1505211967.12628.126.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-12 at 15:43 +0530, Aneesh Kumar K.V wrote:
> Yes. I added the limit to radix after I observed that we have MSR[SF] =
> 0.
> 
> IIRC it was PACA access that was causing it to crash on return from RTAS.
> 
> hmm the commit also explains that.
> 
> powerpc/mm/radix: Limit paca allocation in radix
> 
> On return from RTAS we access the paca variables and we have 64 bit
> disabled. This requires us to limit paca in 32 bit range.
> 
> Fix this by setting ppc64_rma_size to first_memblock_size/1G range.

That should be fixable with better use of temporaries...

Ben.
