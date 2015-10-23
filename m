Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CA711A0B32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:07:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 16:07:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C1D483578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:07:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9N67fUX20840488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:07:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9N67HTY027235
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 17:07:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <CAOJe8K1cnLmDdnV-f4XNiJjoK2w59SwEi8vNy2i6yLyOKYxCVQ@mail.gmail.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1cnLmDdnV-f4XNiJjoK2w59SwEi8vNy2i6yLyOKYxCVQ@mail.gmail.com>
Date: Fri, 23 Oct 2015 11:36:56 +0530
Message-ID: <87a8rarudb.fsf@linux.vnet.ibm.com>
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

> On 10/17/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Hi All,
>>
>> This patch series attempt to update book3s 64 linux page table format to
>> make it more flexible. Our current pte format is very restrictive and we
>> overload multiple pte bits. This is due to the non-availability of free bits
>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>> lower half of PTE page. The pte format is updated such that we have a
>> better method for identifying a pte entry at pmd level. This will also
>> enable
>> us to implement hugetlb migration(not yet done in this series).
>
> Hi, what tree does this apply to?
>

linux-powerpc tree -next branch

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/

-aneesh
