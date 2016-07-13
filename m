Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqLGZ6s1bzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 00:06:14 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DE4Jik065226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:06:12 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452atggax-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:06:12 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 08:06:12 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 02/10] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
In-Reply-To: <1468411747.20552.81.camel@kernel.crashing.org>
References: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402690-5373-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468411747.20552.81.camel@kernel.crashing.org>
Date: Wed, 13 Jul 2016 19:36:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k2gpy6nl.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2016-07-13 at 15:08 +0530, Aneesh Kumar K.V wrote:
>> This switch most of the early feature check to use the non static key
>> variant of the function. In later patches we will be switching
>> cpu_has_feature and mmu_has_feature to use static keys and we can use
>> them only after static key/jump label is initialized. Any check for
>> feature before jump label init should be done using this new helper.
>
> I'm not sure about that. This is converting way way way way more
> functions than is needed. Especially if Michael applies my series
> there will be very little code run before the patching, really only the
> MMU initialization....


Michael is also running into boot issues with the early init rewrite
patch series on G5. That is why I didn't rebase my patches on top of
that changes.

-aneesh
