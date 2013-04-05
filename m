Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15FBF2C0137
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 07:41:47 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mjw@linux.vnet.ibm.com>;
 Fri, 5 Apr 2013 16:41:45 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DB2F938C8029
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 16:41:41 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r35KffWe337184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 16:41:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r35KffWE003119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 16:41:41 -0400
Message-ID: <1365194500.8578.8.camel@lambeau>
Subject: [PATCH] powerpc: pSeries_lpar_hpte_remove fails from Adjunct
 partition being performed before the ANDCOND test
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Apr 2013 15:41:40 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some versions pHyp will perform the adjunct partition test before the
ANDCOND test.  The result of this is that H_RESOURCE can be returned and
cause the BUG_ON condition to occur. The HPTE is not removed.  So add a
check for H_RESOURCE, it is ok if this HPTE is not removed as
pSeries_lpar_hpte_remove is looking for an HPTE to remove and not a
specific HPTE to remove.  So it is ok to just move on to the next slot
and try again.

Signed-off-by: Michael Wolf <mjw@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index c9a29da..724fa0b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -185,7 +185,13 @@ static long pSeries_lpar_hpte_remove(unsigned long hpte_group)
 					   (0x1UL << 4), &dummy1, &dummy2);
 		if (lpar_rc == H_SUCCESS)
 			return i;
-		BUG_ON(lpar_rc != H_NOT_FOUND);
+
+		/*
+		 * The test for adjunct partition is performed before the
+		 * ANDCOND test.  H_RESOURCE may be returned, so we need to
+		 * check for that as well.
+		 */
+		BUG_ON(lpar_rc != H_NOT_FOUND && lpar_rc != H_RESOURCE);
 
 		slot_offset++;
 		slot_offset &= 0x7;
