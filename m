Return-Path: <agl@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78488DDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:26:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67FQtj2012435
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 11:26:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67FQnqO149816
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:26:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67FQmPt022706
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:26:48 -0600
Subject: Re: [Libhugetlbfs-devel] libbugetlbfs: Test case for powerpc
	huge_ptep_set_wrprotect() bug
From: Adam Litke <agl@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080707071955.GA27709@yookeroo.seuss>
References: <20080707071955.GA27709@yookeroo.seuss>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 10:27:00 -0500
Message-Id: <1215444420.14825.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 17:19 +1000, David Gibson wrote:
> Until very recently (in fact, even now in mainline) powerpc kernels
> had a bug in huge_ptep_set_wrprotect() which meant the 'huge' flag was
> not passed down to pte_update() and hpte_need_flush().  This meant the
> hash ptes for hugepages would not be correctly flushed on fork(),
> allowing the parent to pollute the child's mapping after the fork().
> 
> This patch adds a testcase to libhugetlbfs for this behaviour, also
> doing some other checking of the COW semantics over a fork().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Good test David, thanks...
Acked-by: Adam Litke <agl@us.ibm.com>

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
