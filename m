Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435DA1A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 00:15:26 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0863F14090A
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 00:15:24 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 18:45:21 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NDFA8S65142864
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 18:45:11 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NIiXCe017616
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 00:14:34 +0530
Message-ID: <56CC5B59.4030902@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 18:45:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>
CC: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Question on follow_page_mask
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not able to understand the first code block of follow_page_mask
function. follow_huge_addr function is expected to find the page
struct for the given address if it turns out to be a HugeTLB page
but then when it finds the page we bug on if it had been called
with FOLL_GET flag.

	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
	if (!IS_ERR(page)) {
		BUG_ON(flags & FOLL_GET);
		return page;
	}

do_move_page_to_node_array calls follow_page with FOLL_GET which
in turn calls follow_page_mask with FOLL_GET. On POWER, the
function follow_huge_addr is defined and does not return -EINVAL
like the generic one. It returns the page struct if its a HugeTLB
page. Just curious to know what is the purpose behind the BUG_ON.
Thank you.

Regards
Anshuman
