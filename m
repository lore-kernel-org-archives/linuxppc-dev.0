Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 751571A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 03:47:02 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Mar 2015 22:16:59 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5896AE0044
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 22:19:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2TGkpYJ2753008
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 22:16:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2TGkp1W019869
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 22:16:51 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Subject: Re: [V4, 1/4] KVM: PPC: Use READ_ONCE when dereferencing pte_t pointer
In-Reply-To: <20150328103326.7568E14016B@ozlabs.org>
References: <20150328103326.7568E14016B@ozlabs.org>
Date: Sun, 29 Mar 2015 22:16:52 +0530
Message-ID: <87384nn43n.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Thu, 2015-26-03 at 13:13:39 UTC, "Aneesh Kumar K.V" wrote:
>> pte can get updated from other CPUs as part of multiple activities
>> like THP split, huge page collapse, unmap. We need to make sure we
>> don't reload the pte value again and again for different checks.
>> 
>> ---
>>  arch/powerpc/include/asm/kvm_book3s_64.h |  5 ++++-
>>  arch/powerpc/kvm/e500_mmu_host.c         | 20 ++++++++++++--------
>>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> So this series is partly KVM but mostly powerpc.
>
> I assume you can't split it into two separate series easily?

Yes, will do. But before that I was looking for feedback from Ben or
Paul.

>
> You haven't sent it to the KVM lists or to Alex AFAICS. You'll need to do that
> for the KVM pieces at least. We can probably take it all via powerpc, but I'll
> need an ACK from Alex at least.
>

If I can get an ack from Ben, that makes it easy for the kvm list.

-aneesh
