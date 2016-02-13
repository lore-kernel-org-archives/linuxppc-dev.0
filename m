Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 534CE1A0076
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 16:08:45 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 22:08:41 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8EBC93E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 22:08:38 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1D58c0N33816690
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 05:08:38 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1D58bnJ006104
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 00:08:37 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 01/29] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
In-Reply-To: <20160212024906.GB13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160212024906.GB13831@oak.ozlabs.ibm.com>
Date: Sat, 13 Feb 2016 10:38:32 +0530
Message-ID: <8737sxrycv.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Feb 08, 2016 at 02:50:13PM +0530, Aneesh Kumar K.V wrote:
>> Not really needed. But this brings it back to as it was before
>
> If it's not really needed, what's the motivation for putting this
> patch in?  You need to explain where you are heading with this patch.

I explained this in the last review.

What confused me in the beginning was difference between 4k and 64k
page size. I was trying to find out whether we miss a hpte flush in any
scenario because of this. ie, a pte update on a linux pte, for which we
are doing a parallel hash pte insert. After looking at it closer my
understanding is this won't happen because pte update also look at
_PAGE_BUSY and we will wait for hash pte insert to finish before going
ahead with the pte update. But to avoid further confusion I was wondering
whether we should keep this closer to what we have with __hash_page_4k.
Hence the statement "Not really needed".

I will add more information in the commit message.


>
>> Check this
>> 41743a4e34f0777f51c1cf0675b91508ba143050
>
> The SHA1 is useful, but you need to be more explicit - something like
>
> "This partially reverts commit 41743a4e34f0 ("powerpc: Free a PTE bit
> on ppc64 with 64K pages", 2008-06-11)."
>

ok

-aneesh
