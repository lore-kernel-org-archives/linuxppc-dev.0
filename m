Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD621DE1E2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:14:36 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5PKEWfX000368
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:14:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5PKEQhT075652
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 14:14:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5PKELga008345
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 14:14:25 -0600
Date: Wed, 25 Jun 2008 15:14:18 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 01/18 v2] powerpc: Remove extraneous error reporting for
	hcall failures in lparcfg
Message-ID: <20080625201417.GC17020@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625201202.GB17020@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Nathan Fontenot <nfont@austin.ibm.com>

Remove the extraneous error reporting used when a hcall made from lparcfg f=
ails.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |   32 --------------------------------
 1 file changed, 32 deletions(-)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -129,33 +129,6 @@ static int iseries_lparcfg_data(struct s
 /*
  * Methods used to fetch LPAR data when running on a pSeries platform.
  */
-static void log_plpar_hcall_return(unsigned long rc, char *tag)
-{
-	switch(rc) {
-	case 0:
-		return;
-	case H_HARDWARE:
-		printk(KERN_INFO "plpar-hcall (%s) "
-				"Hardware fault\n", tag);
-		return;
-	case H_FUNCTION:
-		printk(KERN_INFO "plpar-hcall (%s) "
-				"Function not allowed\n", tag);
-		return;
-	case H_AUTHORITY:
-		printk(KERN_INFO "plpar-hcall (%s) "
-				"Not authorized to this function\n", tag);
-		return;
-	case H_PARAMETER:
-		printk(KERN_INFO "plpar-hcall (%s) "
-				"Bad parameter(s)\n",tag);
-		return;
-	default:
-		printk(KERN_INFO "plpar-hcall (%s) "
-				"Unexpected rc(0x%lx)\n", tag, rc);
-	}
-}
-
 /*
  * H_GET_PPP hcall returns info in 4 parms.
  *  entitled_capacity,unallocated_capacity,
@@ -191,8 +164,6 @@ static unsigned int h_get_ppp(unsigned l
 	*aggregation =3D retbuf[2];
 	*resource =3D retbuf[3];
=20
-	log_plpar_hcall_return(rc, "H_GET_PPP");
-
 	return rc;
 }
=20
@@ -205,9 +176,6 @@ static void h_pic(unsigned long *pool_id
=20
 	*pool_idle_time =3D retbuf[0];
 	*num_procs =3D retbuf[1];
-
-	if (rc !=3D H_AUTHORITY)
-		log_plpar_hcall_return(rc, "H_PIC");
 }
=20
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
