Return-Path: <agl@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EC1C679F6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 01:24:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4IFO55K019628
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 11:24:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4IFO5kO235890
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 11:24:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4IFO5uZ027668
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 11:24:05 -0400
Subject: [RFD] Hugetlb: Allowing hugetlb regions to be closed
From: Adam Litke <agl@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 18 May 2006 10:23:58 -0500
Message-Id: <1147965839.24029.229.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please correct me if I am wrong in any of the following...

On powerpc, once a region of the address space has been 'opened' for use
with hugetlb pages this region can never again contain normal pages for
the remaining life of the process -- even if all hugetlb mappings have
been unmapped from this region.

The above approach is nice and simple, but a bit restrictive too.  Would
people be opposed to a patch which provides methods for closing low/high
hugetlb areas and logic in arch_get_unmapped_area() to perform the
closing?  My thought would be to try closing only in the full_search:
case (so the fast path is left untouched.

As for why I want this... I have an application (libhugetlbfs), which
provides hugetlb pages to applications in an abstracted manner.  There
are situations where the library creates a hugetlb area and needs to
later replace it with normal pages.  The main case this will happen is
for a hugetlb-backed malloc area.  

Thoughts?
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
