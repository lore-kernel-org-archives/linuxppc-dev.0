Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17493.35040.453321.909465@cargo.ozlabs.ibm.com>
Date: Mon, 1 May 2006 14:04:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: will_schmidt@vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Use the ibm,pa-features property where available
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Forthcoming IBM machines will have a "ibm,pa-features" property on CPU
nodes, that contains bits indicating which optional architecture
features are implemented by the CPU.  This adds code to use the
property, if present, to update our CPU feature bitmaps.

This is based on a patch by Will Schmidt <will_schmidt@vnet.ibm.com>

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
At the moment we're looking at all the ibm,pa-features properties and
processing them all...  Maybe we should only look at the one for the
boot cpu.

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1cb69e8..9a07f97 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -885,6 +885,74 @@ void __init unflatten_device_tree(void)
 	DBG(" <- unflatten_device_tree()\n");
 }
 
+/*
+ * ibm,pa-features is a per-cpu property that contains a string of
+ * attribute descriptors, each of which has a 2 byte header plus up
+ * to 254 bytes worth of processor attribute bits.  First header
+ * byte specifies the number of bytes following the header.
+ * Second header byte is an "attribute-specifier" type, of which
+ * zero is the only currently-defined value.
+ * Implementation:  Pass in the byte and bit offset for the feature
+ * that we are interested in.  The function will return -1 if the
+ * pa-features property is missing, or a 1/0 to indicate if the feature
+ * is supported/not supported.  Note that the bit numbers are
+ * big-endian to match the definition in PAPR.
+ */
+static struct ibm_pa_feature {
+	unsigned long	cpu_features;	/* CPU_FTR_xxx bit */
+	unsigned int	cpu_user_ftrs;	/* PPC_FEATURE_xxx bit */
+	unsigned char	pabyte;		/* byte number in ibm,pa-features */
+	unsigned char	pabit;		/* bit number (big-endian) */
+	unsigned char	invert;		/* if 1, pa bit set => clear feature */
+} ibm_pa_features[] __initdata = {
+	{0, PPC_FEATURE_HAS_MMU,	0, 0, 0},
+	{0, PPC_FEATURE_HAS_FPU,	0, 1, 0},
+	{CPU_FTR_SLB, 0,		0, 2, 0},
+	{CPU_FTR_CTRL, 0,		0, 3, 0},
+	{CPU_FTR_NOEXECUTE, 0,		0, 6, 0},
+	{CPU_FTR_NODSISRALIGN, 0,	1, 1, 1},
+	{CPU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
+};
+
+static void __init check_cpu_pa_features(unsigned long node)
+{
+	unsigned char *pa_ftrs;
+	unsigned long len, tablelen, i, bit;
+
+	pa_ftrs = of_get_flat_dt_prop(node, "ibm,pa-features", &tablelen);
+	if (pa_ftrs == NULL)
+		return;
+
+	/* find descriptor with type == 0 */
+	for (;;) {
+		if (tablelen < 3)
+			return;
+		len = 2 + pa_ftrs[0];
+		if (tablelen < len)
+			return;		/* descriptor 0 not found */
+		if (pa_ftrs[1] == 0)
+			break;
+		tablelen -= len;
+		pa_ftrs += len;
+	}
+
+	/* loop over bits we know about */
+	for (i = 0; i < ARRAY_SIZE(ibm_pa_features); ++i) {
+		struct ibm_pa_feature *fp = &ibm_pa_features[i];
+
+		if (fp->pabyte >= pa_ftrs[0])
+			continue;
+		bit = (pa_ftrs[2 + fp->pabyte] >> (7 - fp->pabit)) & 1;
+		if (bit ^ fp->invert) {
+			cur_cpu_spec->cpu_features |= fp->cpu_features;
+			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftrs;
+		} else {
+			cur_cpu_spec->cpu_features &= ~fp->cpu_features;
+			cur_cpu_spec->cpu_user_features &= ~fp->cpu_user_ftrs;
+		}
+	}
+}
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -968,6 +1036,8 @@ #ifdef CONFIG_ALTIVEC
 		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
 	}
 #endif /* CONFIG_ALTIVEC */
+
+	check_cpu_pa_features(node);
 
 #ifdef CONFIG_PPC_PSERIES
 	if (nthreads > 1)
