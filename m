Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F07C1A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 06:08:22 +1100 (AEDT)
Received: by ykaz22 with SMTP id z22so130700568yka.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 12:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a8rarudb.fsf@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1cnLmDdnV-f4XNiJjoK2w59SwEi8vNy2i6yLyOKYxCVQ@mail.gmail.com>
 <87a8rarudb.fsf@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 22:08:20 +0300
Message-ID: <CAOJe8K256Kr46VVZEPnbMR1Du4cuyS1hhYEh1FmGBgmDxcixJw@mail.gmail.com>
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
From: Denis Kirjanov <kda@linux-powerpc.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/23/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
>
>> On 10/17/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>> Hi All,
>>>
>>> This patch series attempt to update book3s 64 linux page table format to
>>> make it more flexible. Our current pte format is very restrictive and we
>>> overload multiple pte bits. This is due to the non-availability of free
>>> bits
>>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>>> lower half of PTE page. The pte format is updated such that we have a
>>> better method for identifying a pte entry at pmd level. This will also
>>> enable
>>> us to implement hugetlb migration(not yet done in this series).
>>
>> Hi, what tree does this apply to?
>>
>
> linux-powerpc tree -next branch
>
> https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/

Ok, but I'm getting the following error after applying the first patch
from your series:

error: patch failed: arch/powerpc/include/asm/pgalloc-64.h:166
error: arch/powerpc/include/asm/pgalloc-64.h: patch does not apply
error: arch/powerpc/mm/hash64_64k.c: No such file or directory

kda@hydra ~/devel/linux $ git branch
  master
* next
kda@hydra ~/devel/linux $ git remote show origin
* remote origin
  Fetch URL: git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
  Push  URL: git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git

Or am I missing something?

>
> -aneesh
>
>
