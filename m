Return-Path: <agl@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22D1EDDF2E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 04:49:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CIn2wX016163
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 14:49:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CIn2Rk195952
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 14:49:02 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CIn1Sb017962
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 14:49:02 -0400
Subject: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig options
From: Adam Litke <agl@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 14:49:00 -0400
Message-Id: <1213296540.17108.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: npiggin@suse.de, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-mips@linux-mips.org, Eric B Munson <ebmunson@us.ibm.com>,
	sparclinux@vger.kernel.org, nacc@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are currently two global Kconfig options that enable/disable the
hugetlb code: CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS.  This may have
made sense before hugetlbfs became ubiquitous but now the pair of
options are redundant.  Merging these two options into one will simplify
the code slightly and will, more importantly, avoid confusion and
questions like: Which hugetlbfs CONFIG option should my code depend on?

CONFIG_HUGETLB_PAGE is aliased to the value of CONFIG_HUGETLBFS, so one
option can be removed without any effect.  The first patch merges the
two options into one option: CONFIG_HUGETLB.  The second patch updates
the defconfigs to set the one new option appropriately.

I have cross-compiled this on i386, x86_64, ia64, powerpc, sparc64 and
sh with the option enabled and disabled.  This is completely mechanical
but, due to the large number of files affected (especially defconfigs),
could do well with a review from several sets of eyeballs.  Thanks.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
