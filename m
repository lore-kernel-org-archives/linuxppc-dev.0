Return-Path: <csnook@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 1581EDDE05
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:55:56 +1100 (EST)
Message-ID: <47547A79.2060206@redhat.com>
Date: Mon, 03 Dec 2007 16:51:53 -0500
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
To: kniht@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] powerpc: make 64K huge pages more reliable
References: <474CF694.8040700@us.ibm.com>
	<20071203020648.GF26919@localhost.localdomain>
In-Reply-To: <20071203020648.GF26919@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Nov 27, 2007 at 11:03:16PM -0600, Jon Tollefson wrote:
>> This patch adds reliability to the 64K huge page option by making use of 
>> the PMD for 64K huge pages when base pages are 4k.  So instead of a 12 
>> bit pte it would be 7 bit pmd and a 5 bit pte. The pgd and pud offsets 
>> would continue as 9 bits and 7 bits respectively.  This will allow the 
>> pgtable to fit in one base page.  This patch would have to be applied 
>> after part 1.
> 
> Hrm.. shouldn't we just ban 64K hugepages on a 64K base page size
> setup?  There's not a whole lot of point to it, after all...
> 

Actually, it sounds to me like an ideal way to benchmark the efficiency of the 
hugepage implementation and VM effects, without the TLB performance obscuring 
the results.

I agree that it's not something people will want to do very often, but the same 
can be said about quite a lot of strange things that we allow just because 
there's no fundamental reason why they cannot be.

	-- Chris
