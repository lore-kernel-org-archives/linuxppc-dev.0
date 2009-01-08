Return-Path: <chandru@in.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AF0CDE6BB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 21:29:25 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id n08ARqiX005661
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 21:27:52 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n08ATMnb312614
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 21:29:22 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n08ATMv0004160
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 21:29:22 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Thu, 8 Jan 2009 15:59:21 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901071828.13719.chandru@in.ibm.com>
	<1231349125.23462.81.camel@nimitz>
In-Reply-To: <1231349125.23462.81.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901081559.22204.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009 22:55:25 Dave Hansen wrote:
> 
> I'm just suggesting making your fix in the ppc code instead of in
> mm/bootmem.c.
> 

Here are the changes that helped to boot the kernel. Please review it.
Thanks,

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>
---

 arch/powerpc/mm/numa.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- linux-2.6.28/arch/powerpc/mm/numa.c.orig	2009-01-08 03:20:41.000000000 -0600
+++ linux-2.6.28/arch/powerpc/mm/numa.c	2009-01-08 03:50:41.000000000 -0600
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/nodemask.h>
 #include <linux/cpu.h>
+#include <linux/pfn.h>
 #include <linux/notifier.h>
 #include <linux/lmb.h>
 #include <linux/of.h>
@@ -898,9 +899,17 @@ static void mark_reserved_regions_for_ni
 			 * if reserved region extends past active region
 			 * then trim size to active region
 			 */
-			if (end_pfn > node_ar.end_pfn)
+			if (end_pfn > node_ar.end_pfn) {
 				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
 					- (start_pfn << PAGE_SHIFT);
+				/*
+				 * resize it further if the reservation could
+				 * cross the last page in this node
+				 */
+				if (PFN_UP(physbase+reserve_size) >
+						 node_end_pfn)
+					reserve_size -= PAGE_SIZE;
+			}
 			/*
 			 * Only worry about *this* node, others may not
 			 * yet have valid NODE_DATA().
