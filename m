Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHKnF4fW0zDvMJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 17:07:45 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so5584636pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 22:07:45 -0800 (PST)
Subject: Re: [PATCH V3 1/2] mm: move vma_is_anonymous check within
 pmd_move_must_withdraw
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, benh@au1.ibm.com, michaele@au1.ibm.com,
 michael.neuling@au1.ibm.com, paulus@au1.ibm.com,
 "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a8ff3bc4-45f8-fc3c-2ffe-7d25ce259513@gmail.com>
Date: Mon, 14 Nov 2016 17:07:37 +1100
MIME-Version: 1.0
In-Reply-To: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/11/16 02:00, Aneesh Kumar K.V wrote:
> Architectures like ppc64 want to use page table deposit/withraw
> even with huge pmd dax entries. Allow arch to override the
> vma_is_anonymous check by moving that to pmd_move_must_withdraw
> function
> 

I think the changelog can be reworded a bit

Independent of whether the vma is for anonymous memory, some arches
like ppc64 would like to override pmd_move_must_withdraw(). One option
is to encapsulate the vma_is_anonymous() check for general architectures
inside pmd_move_must_withdraw() so that is always called and architectures
that need unconditional overriding can override this function. ppc64
needs to override the function when the MMU is configured to use hash
PTE's.

What do you think?

Balbir Singh.
