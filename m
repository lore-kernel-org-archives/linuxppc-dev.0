Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D08F3DF9AD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:55:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m64CtYpt020772
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:55:34 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m64CtYOU168934
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:55:34 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m64CtYcq018249
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:55:34 -0400
Date: Fri, 4 Jul 2008 07:55:25 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 12/16 v3] powerpc: Verify CMO memory entitlement updates
	with virtual I/O
Message-ID: <20080704125525.GO1310@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080704124449.GA1310@linux.vnet.ibm.com>
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

Verify memory entitlement updates can be handled by vio.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -34,6 +34,7 @@
 #include <asm/time.h>
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
+#include <asm/vio.h>
=20
 #define MODULE_VERS "1.7"
 #define MODULE_NAME "lparcfg"
@@ -528,6 +529,15 @@ static ssize_t update_mpp(u64 *entitleme
 	u8 new_weight;
 	ssize_t rc;
=20
+	if (entitlement) {
+		/* Check with vio to ensure the new memory entitlement
+		 * can be handled.
+		 */
+		rc =3D vio_cmo_entitlement_update(*entitlement);
+		if (rc)
+			return rc;
+	}
+
 	rc =3D h_get_mpp(&mpp_data);
 	if (rc)
 		return rc;
