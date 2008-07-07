Return-Path: <nacc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2A70DF585
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:49:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67In16E011911
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 14:49:01 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67ImuTn229766
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 14:48:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67ImtrR000441
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 14:48:56 -0400
Date: Mon, 7 Jul 2008 11:48:53 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: libhugetlbfs-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: Re: [Libhugetlbfs-devel] libbugetlbfs: Test case for powerpc
	huge_ptep_set_wrprotect() bug
Message-ID: <20080707184853.GA19240@us.ibm.com>
References: <20080707071955.GA27709@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080707071955.GA27709@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07.07.2008 [17:19:55 +1000], David Gibson wrote:
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

Applied, thanks,
Nish
-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
