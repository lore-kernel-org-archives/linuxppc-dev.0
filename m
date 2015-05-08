Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10A991A0935
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 08:21:52 +1000 (AEST)
Date: Fri, 8 May 2015 15:21:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] powerpc/thp: Serialize pmd clear against a linux
 page table walk.
Message-Id: <20150508152149.7fd52bb4b7c2a0911c33be00@linux-foundation.org>
In-Reply-To: <1430983408-24924-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1430983408-24924-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  7 May 2015 12:53:28 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Serialize against find_linux_pte_or_hugepte which does lock-less
> lookup in page tables with local interrupts disabled. For huge pages
> it casts pmd_t to pte_t. Since format of pte_t is different from
> pmd_t we want to prevent transit from pmd pointing to page table
> to pmd pointing to huge page (and back) while interrupts are disabled.
> We clear pmd to possibly replace it with page table pointer in
> different code paths. So make sure we wait for the parallel
> find_linux_pte_or_hugepage to finish.

I'm not seeing here any description of the problem which is being
fixed.  Does the patch make the machine faster?  Does the machine
crash?
