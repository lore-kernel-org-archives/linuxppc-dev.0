Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 47/63] pseries: Add H_SET_MODE to change exception endianness
Date: Wed,  7 Aug 2013 02:02:04 +1000
Message-Id: <1375804940-22050-48-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On little endian builds call H_SET_MODE so exceptions have the
correct endianness. We need a better hook to handle flipping back
into big endian mode on a kexec, but insert it into the mmu
teardown callback for now.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/hvcall.h               |  2 ++
 arch/powerpc/platforms/pseries/lpar.c           | 17 ++++++++++
 arch/powerpc/platforms/pseries/plpar_wrappers.h | 26 +++++++++++++++
 arch/powerpc/platforms/pseries/setup.c          | 42 +++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 0c7f2bf..d8b600b 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -403,6 +403,8 @@ static inline unsigned long cmo_get_page_size(void)
 extern long pSeries_enable_reloc_on_exc(void);
 extern long pSeries_disable_reloc_on_exc(void);
 
+extern long pseries_big_endian_exceptions(void);
+
 #else
 
 #define pSeries_enable_reloc_on_exc()  do {} while (0)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0b7c86e..f28bf35 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -239,6 +239,23 @@ static void pSeries_lpar_hptab_clear(void)
 					&(ptes[j].pteh), &(ptes[j].ptel));
 		}
 	}
+
+#ifdef __LITTLE_ENDIAN__
+	/* Reset exceptions to big endian */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		long rc;
+
+		rc = pseries_big_endian_exceptions();
+		/*
+		 * At this point it is unlikely panic() will get anything
+		 * out to the user, but at least this will stop us from
+		 * continuing on further and creating an even more
+		 * difficult to debug situation.
+		 */
+		if (rc)
+			panic("Could not enable big endian exceptions");
+	}
+#endif
 }
 
 /*
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index 417d0bf..6c1c218 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -287,6 +287,32 @@ static inline long disable_reloc_on_exceptions(void) {
 	return plpar_set_mode(0, 3, 0, 0);
 }
 
+/*
+ * Take exceptions in big endian mode on this partition
+ *
+ * Note: this call has a partition wide scope and can take a while to complete.
+ * If it returns H_LONG_BUSY_* it should be retried periodically until it
+ * returns H_SUCCESS.
+ */
+static inline long enable_big_endian_exceptions(void)
+{
+	/* mflags = 0: big endian exceptions */
+	return plpar_set_mode(0, 4, 0, 0);
+}
+
+/*
+ * Take exceptions in little endian mode on this partition
+ *
+ * Note: this call has a partition wide scope and can take a while to complete.
+ * If it returns H_LONG_BUSY_* it should be retried periodically until it
+ * returns H_SUCCESS.
+ */
+static inline long enable_little_endian_exceptions(void)
+{
+	/* mflags = 1: little endian exceptions */
+	return plpar_set_mode(1, 4, 0, 0);
+}
+
 static inline long plapr_set_ciabr(unsigned long ciabr)
 {
 	return plpar_set_mode(0, 1, ciabr, 0);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 33d6196..51c195d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -430,6 +430,32 @@ static void pSeries_machine_kexec(struct kimage *image)
 }
 #endif
 
+#ifdef __LITTLE_ENDIAN__
+long pseries_big_endian_exceptions(void)
+{
+	long rc;
+
+	while (1) {
+		rc = enable_big_endian_exceptions();
+		if (!H_IS_LONG_BUSY(rc))
+			return rc;
+		mdelay(get_longbusy_msecs(rc));
+	}
+}
+
+static long pseries_little_endian_exceptions(void)
+{
+	long rc;
+
+	while (1) {
+		rc = enable_little_endian_exceptions();
+		if (!H_IS_LONG_BUSY(rc))
+			return rc;
+		mdelay(get_longbusy_msecs(rc));
+	}
+}
+#endif
+
 static void __init pSeries_setup_arch(void)
 {
 	panic_timeout = 10;
@@ -687,6 +713,22 @@ static int __init pSeries_probe(void)
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pseries_probe_fw_features, NULL);
 
+#ifdef __LITTLE_ENDIAN__
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		long rc;
+		/*
+		 * Tell the hypervisor that we want our exceptions to
+		 * be taken in little endian mode. If this fails we don't
+		 * want to use BUG() because it will trigger an exception.
+		 */
+		rc = pseries_little_endian_exceptions();
+		if (rc) {
+			ppc_md.progress("H_SET_MODE LE exception fail", 0);
+			panic("Could not enable little endian exceptions");
+		}
+	}
+#endif
+
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
 	else
-- 
1.8.1.2
