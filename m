Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1266BDEBE1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:16:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5PKG05B001562
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:16:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5PKG0oZ075014
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:16:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5PKG0KJ005557
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:16:00 -0400
Date: Wed, 25 Jun 2008 15:15:56 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 06/18 v2] powerpc: Utilities to set firmware page state
Message-ID: <20080625201556.GH17020@linux.vnet.ibm.com>
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

=46rom: Brian King <brking@linux.vnet.ibm.com>

Newer versions of firmware support page states, which are used by the
collaborative memory manager (future patch) to "loan" pages to the
hypervisor for use by other partitions.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

 arch/powerpc/platforms/pseries/plpar_wrappers.h |   10 ++++++++++
 include/asm-powerpc/hvcall.h                    |    5 +++++
 2 files changed, 15 insertions(+)

Index: b/arch/powerpc/platforms/pseries/plpar_wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -42,6 +42,16 @@ static inline long register_slb_shadow(u
 	return vpa_call(0x3, cpu, vpa);
 }
=20
+static inline long plpar_page_set_loaned(unsigned long vpa)
+{
+	return plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa, 0);
+}
+
+static inline long plpar_page_set_active(unsigned long vpa)
+{
+	return plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa, 0);
+}
+
 extern void vpa_init(int cpu);
=20
 static inline long plpar_pte_enter(unsigned long flags,
Index: b/include/asm-powerpc/hvcall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -92,6 +92,11 @@
 #define H_EXACT			(1UL<<(63-24))	/* Use exact PTE or return H_PTEG_FULL */
 #define H_R_XLATE		(1UL<<(63-25))	/* include a valid logical page num in t=
he pte if the valid bit is set */
 #define H_READ_4		(1UL<<(63-26))	/* Return 4 PTEs */
+#define H_PAGE_STATE_CHANGE	(1UL<<(63-28))
+#define H_PAGE_UNUSED		((1UL<<(63-29)) | (1UL<<(63-30)))
+#define H_PAGE_SET_UNUSED	(H_PAGE_STATE_CHANGE | H_PAGE_UNUSED)
+#define H_PAGE_SET_LOANED	(H_PAGE_SET_UNUSED | (1UL<<(63-31)))
+#define H_PAGE_SET_ACTIVE	H_PAGE_STATE_CHANGE
 #define H_AVPN			(1UL<<(63-32))	/* An avpn is provided as a sanity test */
 #define H_ANDCOND		(1UL<<(63-33))
 #define H_ICACHE_INVALIDATE	(1UL<<(63-40))	/* icbi, etc.  (ignored for IO =
pages) */
