Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLClN5jd8zDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:47:12 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NAiQTA137843
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:47:10 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dsa7nkun6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 06:47:09 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 11:47:08 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9NAl4QP31326390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 10:47:05 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9NAl42m009057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 21:47:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed HPTE
 pages
In-Reply-To: <1505376837.12628.192.camel@kernel.crashing.org>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
 <1505376837.12628.192.camel@kernel.crashing.org>
Date: Mon, 23 Oct 2017 14:22:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3o28cv7.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2017-09-08 at 15:44 -0700, Ram Pai wrote:
>> The second part of the PTE will hold
>> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
>> NOTE: None of the bits in the secondary PTE were not used
>> by 64k-HPTE backed PTE.
>
> Have you measured the performance impact of this ? The second part of
> the PTE being in a different cache line there could be one...
>

I am also looking at a patch series removing the slot tracking
completely. With randomize address turned off and no swap in guest/host
and making sure we touched most of guest ram, I don't find much impact
in performance when we don't track the slot at all. I will post the
patch series with numbers in a day or two. But my test was

while (5000) {
      mmap(128M)
      touch every page of 2048 pages
      munmap()
}

I could also be the best case in my run because i might have always
found the hash pte slot in the primary. In one measurement with swap on
and address randmization enabled, i did find a 50% impact. But then i
was not able to recreate that again. So could be something i did wrong
in the test setup.

Ram,

Will you be able to get a test run with the above loop?

-aneesh
