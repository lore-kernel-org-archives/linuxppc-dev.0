Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F7D01A014D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:42:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 12:12:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B62D3394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:12:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8M6gIpd8782300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:12:19 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8M6gGgm023151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:12:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/31] powerpc/mm: make a separate copy for book3s
In-Reply-To: <1442872723.19102.188.camel@freescale.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442872723.19102.188.camel@freescale.com>
Date: Tue, 22 Sep 2015 12:12:14 +0530
Message-ID: <87fv273qgp.fsf@linux.vnet.ibm.com>
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

Scott Wood <scottwood@freescale.com> writes:

> On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
>> In this patch we do:
>> cp pgtable-ppc32.h book3s/32/pgtable.h
>> cp pgtable-ppc64.h book3s/64/pgtable.h
>> 
>> This enable us to do further changes to hash specific config.
>> We will change the page table format for 64bit hash in later patches.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/32/pgtable.h | 340 +++++++++++++++
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 618 
>> +++++++++++++++++++++++++++
>>  arch/powerpc/include/asm/book3s/pgtable.h    |  10 +
>>  arch/powerpc/include/asm/mmu-hash64.h        |   2 +-
>>  arch/powerpc/include/asm/pgtable-ppc32.h     |   2 -
>>  arch/powerpc/include/asm/pgtable-ppc64.h     |   4 -
>>  arch/powerpc/include/asm/pgtable.h           |   4 +
>>  7 files changed, 973 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/book3s/32/pgtable.h
>>  create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
>>  create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h
>
> git format-patch -C?

Thanks for the hint. Will use that next time.

>
> Do the book3s/hash-specific parts of the copied file get removed from the non-
> hash files at some point?
>

I tried to keep the changes to non-hash code minimal. My guess is that
we could do more cleanup there. But that can be done as later patches ?

-aneesh
