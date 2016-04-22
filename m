Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrt3q1fcXzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 21:01:59 +1000 (AEST)
Message-ID: <1461322918.22163.5.camel@ellerman.id.au>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 22 Apr 2016 21:01:58 +1000
In-Reply-To: <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-04-09 at 11:43 +0530, Aneesh Kumar K.V wrote:

> This enables us to share the same page table code for
> both radix and hash.

To be clear, only 64-bit hash.

In theory there's no reason we can't *always* mark the page tables as BE, after
all everything other than the new ppc64le systems are BE.

But looking at it, that will cause knock-on effects in a few places. So we
won't do it now. But it would be a good clean-up in the medium term I think. It
would get us back to a single pgtable-types.h.

> Radix use a hardware defined big endian page table

So everyone keeps telling me :)

Where is this specified? I can't find it in the ISA. But I must be searching
for the wrong words.

cheers
