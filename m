Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5C981A03BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 16:02:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 10:32:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4BF40E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 10:33:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA352hFs4391198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 10:32:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA352guC023947
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 10:32:43 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <CAOJe8K256Kr46VVZEPnbMR1Du4cuyS1hhYEh1FmGBgmDxcixJw@mail.gmail.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1cnLmDdnV-f4XNiJjoK2w59SwEi8vNy2i6yLyOKYxCVQ@mail.gmail.com>
 <87a8rarudb.fsf@linux.vnet.ibm.com>
 <CAOJe8K256Kr46VVZEPnbMR1Du4cuyS1hhYEh1FmGBgmDxcixJw@mail.gmail.com>
Date: Tue, 03 Nov 2015 10:32:41 +0530
Message-ID: <87twp3u13i.fsf@linux.vnet.ibm.com>
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

> On 10/23/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Denis Kirjanov <kda@linux-powerpc.org> writes:
>>
>>> On 10/17/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>>> Hi All,
>>>>
>>>> This patch series attempt to update book3s 64 linux page table format to
>>>> make it more flexible. Our current pte format is very restrictive and we
>>>> overload multiple pte bits. This is due to the non-availability of free
>>>> bits
>>>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>>>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>>>> lower half of PTE page. The pte format is updated such that we have a
>>>> better method for identifying a pte entry at pmd level. This will also
>>>> enable
>>>> us to implement hugetlb migration(not yet done in this series).
>>>
>>> Hi, what tree does this apply to?
>>>
>>
>> linux-powerpc tree -next branch
>>
>> https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/
>
> Ok, but I'm getting the following error after applying the first patch
> from your series:
>
> error: patch failed: arch/powerpc/include/asm/pgalloc-64.h:166
> error: arch/powerpc/include/asm/pgalloc-64.h: patch does not apply
> error: arch/powerpc/mm/hash64_64k.c: No such file or directory
>
> kda@hydra ~/devel/linux $ git branch
>   master
> * next
> kda@hydra ~/devel/linux $ git remote show origin
> * remote origin
>   Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
>   Push  URL: git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
>
> Or am I missing something?


Why not use

The patch series can also be found at
https://github.com/kvaneesh/linux.git book3s-pte-format 
https://github.com/kvaneesh/linux/commits/book3s-pte-format


-aneesh
