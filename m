Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (unknown [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 200F71A0060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 13:22:11 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 21:11:52 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CAE9EC90043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:11:47 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q2BoRI14155790
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 02:11:50 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q2BnrO026461
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:11:50 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 08/18] powerpc/mm: Copy pgalloc (part 1)
In-Reply-To: <20160225042731.GG18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160225042731.GG18753@oak.ozlabs.ibm.com>
Date: Fri, 26 Feb 2016 07:41:45 +0530
Message-ID: <8760xcjk4e.fsf@linux.vnet.ibm.com>
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

> On Tue, Feb 23, 2016 at 10:18:10AM +0530, Aneesh Kumar K.V wrote:
>> This patch make a copy of pgalloc routines for book3s. The idea is to
>> enable a hash64 copy of these pgalloc routines which can be later
>> updated to have a radix conditional. Radix introduce a new page table
>> format with different page table size.
>> 
>> This mostly does:
>> 
>> cp pgalloc-32.h book3s/32/pgalloc.h
>> cp pgalloc-64.h book3s/64/pgalloc.h
>
> What is the motivation for copying over the 32-bit header?

That was moved, because I was looking to consolidate all book3s headers
under book3s/ and wanted to move pgalloc-64.h to book3s.

>
> Regarding the 64-bit header, I don't see anything in it that will need
> to be changed for radix other than making P{G,U,M}D_INDEX_SIZE be
> variables rather than constants (and possibly have a lowercase name
> instead of uppercase).  What other changes are you expecting to make?
>

I was taking the approach of conditional call rather than variables. Hence
moved them to 64/pgalloc.h so that we can add a static inline for those.

-aneesh
