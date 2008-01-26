Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC2C7DDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 18:13:41 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0Q7DAou015600
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 18:13:10 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0Q7HH59279972
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 18:17:17 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0Q7De5o007969
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 18:13:40 +1100
Date: Sat, 26 Jan 2008 12:43:39 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20080126071339.GA25328@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Michael Ellerman <michael@ellerman.id.au> [2008-01-18 16:44:58]:

> 
> This fixes it, although I'm a little worried about some of the
> removals/movings of node_set_online() in the patch.
> 
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 1666e7d..dcedc26 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -49,7 +49,6 @@ static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
>  	static unsigned int fake_nid = 0;
>  	static unsigned long long curr_boundary = 0;
>  
> -	*nid = fake_nid;
>  	if (!p)
>  		return 0;
>  
> @@ -60,6 +59,7 @@ static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
>  	if (mem < curr_boundary)
>  		return 0;
>  
> +	*nid = fake_nid;
>  	curr_boundary = mem;
>  
>  	if ((end_pfn << PAGE_SHIFT) > mem) {
> 

Hi, Michael,

Here's a better and more complete fix for the problem. Could you
please see if it works for you? I tested it on a real NUMA box and it
seemed to work fine there.

Description
-----------

This patch provides a fix for the problem found by
Michael Ellerman <michael@ellerman.id.au> while using fake NUMA nodes
on a cell box. The code modifies node id iff (as in if and only if)
fake NUMA nodes are created.

Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
---

 arch/powerpc/mm/numa.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/powerpc/mm/numa.c~fix-fake-numa-nid-on-numa arch/powerpc/mm/numa.c
--- linux-2.6.24-rc8/arch/powerpc/mm/numa.c~fix-fake-numa-nid-on-numa	2008-01-26 12:20:29.000000000 +0530
+++ linux-2.6.24-rc8-balbir/arch/powerpc/mm/numa.c	2008-01-26 12:27:53.000000000 +0530
@@ -49,7 +49,12 @@ static int __cpuinit fake_numa_create_ne
 	static unsigned int fake_nid = 0;
 	static unsigned long long curr_boundary = 0;
 
-	*nid = fake_nid;
+	/*
+	 * If we did enable fake nodes and cross a node,
+	 * remember the last node and start from there.
+	 */
+	if (fake_nid)
+		*nid = fake_nid;
 	if (!p)
 		return 0;
 
_

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
