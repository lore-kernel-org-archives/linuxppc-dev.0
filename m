Return-Path: <dave@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B956DDF63
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 07:10:26 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m74LAH6E014879
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Aug 2008 17:10:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m74LAHwW121442
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Aug 2008 15:10:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m74LAGho013933
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Aug 2008 15:10:17 -0600
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080731103137.GD1704@csn.ul.ie>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<20080730193010.GB14138@csn.ul.ie>
	<20080730130709.eb541475.akpm@linux-foundation.org>
	<20080731103137.GD1704@csn.ul.ie>
Content-Type: text/plain
Date: Mon, 04 Aug 2008 14:10:11 -0700
Message-Id: <1217884211.20260.144.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	abh@cray.com, ebmunson@us.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-31 at 11:31 +0100, Mel Gorman wrote:
> We are a lot more reliable than we were although exact quantification is
> difficult because it's workload dependent. For a long time, I've been able
> to test bits and pieces with hugepages by allocating the pool at the time
> I needed it even after days of uptime. Previously this required a reboot.

This is also a pretty big expansion of fs/hugetlb/ use outside of the
filesystem itself.  It is hacking the existing shared memory
kernel-internal user to spit out effectively anonymous memory.

Where do we draw the line where we stop using the filesystem for this?
Other than the immediate code reuse, does it gain us anything?

I have to think that actually refactoring the filesystem code and making
it usable for really anonymous memory, then using *that* in these
patches would be a lot more sane.  Especially for someone that goes to
look at it in a year. :)

-- Dave
