Return-Path: <rcjenn@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10B6FDE26E
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 06:18:24 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m7FJ9xXM001413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:09:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FJ9ix0007131
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:09:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7FJ9Xv1220592
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:09:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7FJ9X5k024503
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:09:33 -0400
Date: Fri, 15 Aug 2008 14:09:33 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc: Fix CMM page loaning on 64k page kernel with
	4k hardware pages
Message-ID: <20080815190932.GC20629@austin.ibm.com>
References: <20080815190230.GA20629@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080815190230.GA20629@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Brian King <brking@linux.vnet.ibm.com>

If the firmware page size used for collaborative memory overcommit
is 4k, but the kernel is using 64k pages, the page loaning is currently
broken as it only marks the first 4k page of each 64k page as loaned.
This fixes this to iterate through each 4k page and mark them all as
loaned/active.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

 arch/powerpc/platforms/pseries/plpar_wrappers.h |   27 +++++++++++++++++++=
+++--
 1 file changed, 25 insertions(+), 2 deletions(-)

Index: b/arch/powerpc/platforms/pseries/plpar_wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -2,6 +2,7 @@
 #define _PSERIES_PLPAR_WRAPPERS_H
=20
 #include <asm/hvcall.h>
+#include <asm/page.h>
=20
 static inline long poll_pending(void)
 {
@@ -44,12 +45,34 @@ static inline long register_slb_shadow(u
=20
 static inline long plpar_page_set_loaned(unsigned long vpa)
 {
-	return plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa, 0);
+	unsigned long cmo_page_sz =3D cmo_get_page_size();
+	long rc =3D 0;
+	int i;
+
+	for (i =3D 0; !rc && i < PAGE_SIZE; i +=3D cmo_page_sz)
+		rc =3D plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa + i, 0);
+
+	for (i -=3D cmo_page_sz; rc && i !=3D 0; i -=3D cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
 }
=20
 static inline long plpar_page_set_active(unsigned long vpa)
 {
-	return plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa, 0);
+	unsigned long cmo_page_sz =3D cmo_get_page_size();
+	long rc =3D 0;
+	int i;
+
+	for (i =3D 0; !rc && i < PAGE_SIZE; i +=3D cmo_page_sz)
+		rc =3D plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa + i, 0);
+
+	for (i -=3D cmo_page_sz; rc && i !=3D 0; i -=3D cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
 }
=20
 extern void vpa_init(int cpu);
