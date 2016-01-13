Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE0B1A028D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:04:08 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 16:04:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 459D02CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:03:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D63jZr59506806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:03:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D63KsL005962
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:03:20 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 01/33] powerpc/mm: add _PAGE_HASHPTE similar to 4K
 hash
In-Reply-To: <20160113134821.41d4e006@cotter.ozlabs.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160113134821.41d4e006@cotter.ozlabs.ibm.com>
Date: Wed, 13 Jan 2016 11:32:53 +0530
Message-ID: <87si22c8z6.fsf@linux.vnet.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Tue, 12 Jan 2016 12:45:36 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Not really needed. But this brings it back to as it was before
>> 
>
> Could you expand on not really needed. Could the changelog describe how
> the bits will be used in the follow on patches.
>

What confused me in the beginning was difference between 4k and 64k
page size. I was trying to find out whether we miss a hpte flush in any
scenario because of this. ie, a pte update on a linux pte, for which we
are doing a parallel hash pte insert. After looking at it closer my
understanding is this won't happen because pte update also look at
_PAGE_BUSY and we will wait for hash pte insert to finish before going
ahead with the pte update. But to avoid further confusion I was wondering
whether we should keep this closer to what we have with __hash_page_4k.
Hence the statement "Not really needed".

-aneesh
