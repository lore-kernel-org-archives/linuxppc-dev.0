Return-Path: <kas@node.shutemov.name>
Received: from jenni2.inet.fi (mta-out1.inet.fi [62.71.2.195])
 by lists.ozlabs.org (Postfix) with ESMTP id 5736F1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 19:20:11 +1000 (AEST)
Date: Tue, 12 May 2015 12:19:51 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 1/3] mm/thp: Split out pmd collpase flush into a
 separate functions
Message-ID: <20150512091951.GA18365@node.dhcp.inet.fi>
References: <1431410914-21102-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431410914-21102-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 11:38:32AM +0530, Aneesh Kumar K.V wrote:
> Architectures like ppc64 [1] need to do special things while clearing
> pmd before a collapse. For them this operation is largely different
> from a normal hugepage pte clear. Hence add a separate function
> to clear pmd before collapse. After this patch pmdp_* functions
> operate only on hugepage pte, and not on regular pmd_t values
> pointing to page table.
> 
> [1] ppc64 needs to invalidate all the normal page pte mappings we
> already have inserted in the hardware hash page table. But before
> doing that we need to make sure there are no parallel hash page
> table insert going on. So we need to do a kick_all_cpus_sync()
> before flushing the older hash table entries. By moving this to
> a separate function we capture these details and mention how it
> is different from a hugepage pte clear.
> 
> This patch is a cleanup and only does code movement for clarity.
> There should not be any change in functionality.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

For the patchset:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
