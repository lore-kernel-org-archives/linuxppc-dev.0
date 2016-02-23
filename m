Return-Path: <kirill@shutemov.name>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3ED51A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 01:03:56 +1100 (AEDT)
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E31371409A0
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 01:03:54 +1100 (AEDT)
Received: by mail-wm0-x22b.google.com with SMTP id g62so223754946wme.1
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 06:03:54 -0800 (PST)
Date: Tue, 23 Feb 2016 17:03:49 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Question on follow_page_mask
Message-ID: <20160223140349.GA21820@node.shutemov.name>
References: <56CC5B59.4030902@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CC5B59.4030902@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 06:45:05PM +0530, Anshuman Khandual wrote:
> Not able to understand the first code block of follow_page_mask
> function. follow_huge_addr function is expected to find the page
> struct for the given address if it turns out to be a HugeTLB page
> but then when it finds the page we bug on if it had been called
> with FOLL_GET flag.
> 
> 	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> 	if (!IS_ERR(page)) {
> 		BUG_ON(flags & FOLL_GET);
> 		return page;
> 	}
> 
> do_move_page_to_node_array calls follow_page with FOLL_GET which
> in turn calls follow_page_mask with FOLL_GET. On POWER, the
> function follow_huge_addr is defined and does not return -EINVAL
> like the generic one. It returns the page struct if its a HugeTLB
> page. Just curious to know what is the purpose behind the BUG_ON.

I would guess requesting pin on non-reclaimable page is considered
useless, meaning suspicius behavior. BUG_ON() is overkill, I think.
WARN_ON_ONCE() would make it.

Not that this follow_huge_addr() on Power is not reachable via
do_move_page_to_node_array(), because the vma is !vma_is_migratable().

-- 
 Kirill A. Shutemov
