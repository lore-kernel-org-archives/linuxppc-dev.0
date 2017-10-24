Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLf9T73Q5zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 14:37:49 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O3Xt2b050744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 23:37:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dspxr6r9b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 23:37:46 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Oct 2017 23:37:45 -0400
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed HPTE
 pages
To: Ram Pai <linuxram@us.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com,
 mhocko@kernel.org, paulus@samba.org, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
 <1505376837.12628.192.camel@kernel.crashing.org>
 <20171023192236.GA5488@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 24 Oct 2017 09:07:36 +0530
MIME-Version: 1.0
In-Reply-To: <20171023192236.GA5488@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2ca10f6f-972f-b7f9-fcce-81becad58c0c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/24/2017 12:52 AM, Ram Pai wrote:
> On Thu, Sep 14, 2017 at 06:13:57PM +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2017-09-08 at 15:44 -0700, Ram Pai wrote:
>>> The second part of the PTE will hold
>>> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
>>> NOTE: None of the bits in the secondary PTE were not used
>>> by 64k-HPTE backed PTE.
>>
>> Have you measured the performance impact of this ? The second part of
>> the PTE being in a different cache line there could be one...
> 
> hmm..missed responding to this comment.
> 
> I did a preliminay measurement running mmap bench in the selftest.
> Ran it multiple times. almost always the numbers were either equal-to
> or better-than without the patch-series.

mmap bench doesn't do any fault. It is just mmap/munmap in loop.

-aneesh
