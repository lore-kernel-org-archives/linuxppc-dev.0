Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1CFADE4DA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:25:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIP0wQ032488
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:25:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIP0X5189806
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:25:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIOxkp008490
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:25:00 -0400
Date: Wed, 23 Jul 2008 13:25:00 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 01/16 v4] powerpc: Remove extraneous error reporting for
	hcall failures in lparcfg
Message-ID: <20080723182500.GD12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
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
Acked-by: Paul Mackerras <paulus@samba.org>

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
