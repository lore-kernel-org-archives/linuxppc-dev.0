Return-Path: <agl@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8353DDDF82
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 08:53:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m24Lrfbx024157
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 16:53:41 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m24LrfkW234324
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 16:53:41 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m24Lrf6H002922
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 16:53:41 -0500
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel bug while running libhugetlbfs
From: Adam Litke <agl@us.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080304115158.505f33eb.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CDA0F1.9030908@linux.vnet.ibm.com>
	<20080304115158.505f33eb.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 16:01:29 -0600
Message-Id: <1204668089.14779.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, balbir@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-03-04 at 11:51 -0800, Andrew Morton wrote:
> hugetlb-correct-page-count-for-surplus-huge-pages.patch adds:
> 
>         if (page) {
>                 /*
>                  * This page is now managed by the hugetlb allocator and has
>                  * no users -- drop the buddy allocator's reference.
>                  */
>                 int page_count = put_page_testzero(page);
>                 BUG_ON(page_count != 0);
> 
> 

Ugh I got bitten by put_page_testzero().  When it returns 1, the page
count is zero (not the page count).

My initial version had a BUG_ON() with side-effects.  When a reviewer
pointed it out, I thought I could fix the patch up on its way out the
door.  I have self-administered my punishment.  This patch will fix it:

Signed-off-by: Adam Litke <agl@us.ibm.com>

--- mm/hugetlb.c.orig	2008-03-04 13:36:30.000000000 -0800
+++ mm/hugetlb.c	2008-03-04 13:39:30.000000000 -0800
@@ -291,8 +291,8 @@ static struct page *alloc_buddy_huge_pag
 		 * This page is now managed by the hugetlb allocator and has
 		 * no users -- drop the buddy allocator's reference.
 		 */
-		int page_count = put_page_testzero(page);
-		BUG_ON(page_count != 0);
+		put_page_testzero(page);
+		VM_BUG_ON(page_count(page));
 		nid = page_to_nid(page);
 		set_compound_page_dtor(page, free_huge_page);
 		/*
 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
