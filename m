Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2vkV3TbszDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 16:52:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rashmica Gupta <rashmica.g@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/mm: fix up pgtable dump flags
In-Reply-To: <c68c1247-b676-5b48-264d-8affe0c10ead@gmail.com>
References: <20170331013749.17874-1-oohall@gmail.com>
 <c68c1247-b676-5b48-264d-8affe0c10ead@gmail.com>
Date: Wed, 12 Apr 2017 16:52:50 +1000
Message-ID: <8737deungd.fsf@concordia.ellerman.id.au>
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

Rashmica Gupta <rashmica.g@gmail.com> writes:

> On 31/03/17 12:37, Oliver O'Halloran wrote:
>> On Book3s we have two PTE flags used to mark cache-inhibited mappings:
>> _PAGE_TOLERANT and _PAGE_NON_IDEMPOTENT. Currently the kernel page
>> table dumper only looks at the generic _PAGE_NO_CACHE which is
>> defined to be _PAGE_TOLERANT. This patch modifies the dumper so
>> both flags are shown in the dump.
>>
>> Cc: Rashmica Gupta <rashmica.g@gmail.com>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

> Should we also add in _PAGE_SAO  that is in Book3s?

I don't think we ever expect to see it in the kernel page tables. But if
we did that would be "interesting".

I've forgotten what the code does with unknown bits, does it already
print them in some way?

If not we should either add that or add _PAGE_SAO and everything else
that could possibly ever be there.

cheers
