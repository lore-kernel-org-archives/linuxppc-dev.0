Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtQpn5tswzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 09:41:05 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 25 Apr 2016 08:30:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ADF082CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 08:30:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3OMUJ1K1573224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 08:30:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3OMTtKr030479
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 08:29:55 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for book3s
 64
In-Reply-To: <1461322918.22163.5.camel@ellerman.id.au>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461322918.22163.5.camel@ellerman.id.au>
Date: Mon, 25 Apr 2016 03:59:36 +0530
Message-ID: <87shya8wtr.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Sat, 2016-04-09 at 11:43 +0530, Aneesh Kumar K.V wrote:
>
>> This enables us to share the same page table code for
>> both radix and hash.
>
> To be clear, only 64-bit hash.
>
> In theory there's no reason we can't *always* mark the page tables as BE, after
> all everything other than the new ppc64le systems are BE.
>
> But looking at it, that will cause knock-on effects in a few places. So we
> won't do it now. But it would be a good clean-up in the medium term I think. It
> would get us back to a single pgtable-types.h.
>
>> Radix use a hardware defined big endian page table
>
> So everyone keeps telling me :)
>
> Where is this specified? I can't find it in the ISA. But I must be searching
> for the wrong words.

It is definied by the pte entry format. We don't call it out as
Big-endian format. But it is derived from powerpc bit naming convention. The same is
true for hash page table entry.

-aneesh
