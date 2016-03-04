Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB9FB1A0CA5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:40:08 +1100 (AEDT)
In-Reply-To: <1456817364-3329-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [2/8] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Message-Id: <20160304004008.A1145141B7B@ozlabs.org>
Date: Fri,  4 Mar 2016 11:40:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-03 at 07:29:18 UTC, "Aneesh Kumar K.V" wrote:
> We don't need to update linux page table entry with _PAGE_HASHPTE early
> in hash pte fault. A parallel pte update will loop via _PAGE_BUSY
> and look at _PAGE_HASHPTE for a required hpte flush only if
> _PAGE_BUSY is cleared. That ensures a pte update will wait for a
> parallel hpte insert to finish before looking at _PAGE_HASHPTE bit.
> 
> To avoid further confusion drop setting _PAGE_HASHPTE in cmpxchg in __hash_page_4K.
> 
> commit 41743a4e34f0 ("powerpc: Free a PTE bit on ppc64 with 64K pages")
> did similar change for 64K config
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c367a44133bcd7f94fb48b58e9

cheers
