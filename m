Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 181A51A028C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 16:47:15 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 15:47:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D1A342CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 16:47:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D5l2t837945370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 16:47:10 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D5kbvK009588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 16:46:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the powerpc tree
In-Reply-To: <1452162650.5826.2.camel@ellerman.id.au>
References: <20160107191613.0228560b@canb.auug.org.au>
 <1452162650.5826.2.camel@ellerman.id.au>
Date: Wed, 13 Jan 2016 11:16:10 +0530
Message-ID: <87vb6yc9r1.fsf@linux.vnet.ibm.com>
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

> On Thu, 2016-01-07 at 19:16 +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> After merging the powerpc tree, today's linux-next build (powerpc64
>> allnoconfig) failed like this:
>> 
>> arch/powerpc/mm/hash_utils_64.c: In function 'get_paca_psize':
>> arch/powerpc/mm/hash_utils_64.c:869:19: error: 'struct paca_struct' has no member named 'context'
>>   return get_paca()->context.user_psize;
>>                    ^
>> arch/powerpc/mm/hash_utils_64.c:870:1: error: control reaches end of non-void function [-Werror=return-type]
>>  }
>>  ^
>> 
>> Caused by commit
>> 
>>   2fc251a8dda5 ("powerpc: Copy only required pieces of the mm_context_t to the paca")
>
> Well that's rather embarrassing, for Mikey ;D
>
>> This build has CONFIG_PPC_MM_SLICES not set ...
>
> Ugh, but it would seem none of our defconfigs do :/

4K page size with hugetlb disabled will get that 

-aneesh
