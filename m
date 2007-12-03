Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D12ADDE39
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:24:09 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id lB32LlLR018975
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 13:21:47 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB32KkmS2166812
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 13:20:46 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB32Kjkv019004
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 13:20:46 +1100
Date: Mon, 3 Dec 2007 13:06:48 +1100
From: David Gibson <dwg@au1.ibm.com>
To: kniht@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] powerpc: make 64K huge pages more reliable
Message-ID: <20071203020648.GF26919@localhost.localdomain>
References: <474CF694.8040700@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474CF694.8040700@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 11:03:16PM -0600, Jon Tollefson wrote:
> This patch adds reliability to the 64K huge page option by making use of 
> the PMD for 64K huge pages when base pages are 4k.  So instead of a 12 
> bit pte it would be 7 bit pmd and a 5 bit pte. The pgd and pud offsets 
> would continue as 9 bits and 7 bits respectively.  This will allow the 
> pgtable to fit in one base page.  This patch would have to be applied 
> after part 1.

Hrm.. shouldn't we just ban 64K hugepages on a 64K base page size
setup?  There's not a whole lot of point to it, after all...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
