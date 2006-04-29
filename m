Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.52602.577587.524391@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 12:20:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
In-Reply-To: <1146249684.27214.18.camel@localhost.localdomain>
References: <1146249684.27214.18.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt writes:

> This is an initial pass at the functionality.  This has been tested in
> the case where the property is missing, but still needs to be tested
> against a system where the property actually exists.  :-o  

Some random comments, and a modified version of your patch...

- We may want to make a table giving the correspondence between
  pa-features byte/bit numbers and our feature bits, and then just
  have code that walks through the table and sets/clears feature bits
  as appropriate.

- If we are setting/clearing feature bits that are used with the asm
  feature macros, we'll have to do this much earlier, in prom.c,
  before the device tree is unflattened.

Paul.

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4467c49..022b9b3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -106,6 +106,78 @@ static struct notifier_block ppc64_panic
 	.priority = INT_MIN /* may not return; must be done last */
 };
 
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
+static int get_pa_feature(int pabyte, int pabit)
+{
+	struct device_node *cpu;
+	unsigned char *pa_feature_table;
+	int tablelen;
+	int ret = -1;
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu == NULL)
+		return -1;
+
+	pa_feature_table = get_property(cpu, "ibm,pa-features", &tablelen);
+	if (pa_feature_table == NULL)
+		goto out;
+
+	/* find descriptor with type == 0 */
+	for (;;) {
+		if (tablelen < 3 || tablelen < 2 + pa_feature_table[1])
+			goto out;	/* not found */
+		if (pa_feature_table[0] == 0)
+			break;
+		tablelen -= 2 + pa_feature_table[1];
+		pa_feature_table += 2 + pa_feature_table[1];
+	}
+
+	/* check if the specifier is long enough */
+	if (pabyte >= pa_feature_table[1])
+		goto out;
+
+	ret = (pa_feature_table[2 + pabyte] >> (7 - pabit)) & 1;
+
+ out:
+	of_node_put(cpu);
+	return ret;
+}
+
+/*
+ * set values within the cur_cpu_spec table according to
+ * the ibm,pa_features property. 
+ * potential entries include: 
+ * Byte 0, bit 1 - FPU available
+ * Byte 1, bit 2 - cache-inhibited large pages supported
+ * Byte 2, bit 3 - DAR set on alignment interrupt. 
+ */
+static void check_cpu_features(void)
+{
+	int hasit;
+
+	/* test for support of cache-inhibited large pages */
+	hasit = get_pa_feature(1, 2);
+	if (hasit >= 0)
+		if (hasit)
+			cur_cpu_spec->cpu_features |= CPU_FTR_CI_LARGE_PAGE;
+		else
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_CI_LARGE_PAGE;
+
+	/* add more here in future... */
+}
+
 #ifdef CONFIG_SMP
 
 static int smt_enabled_cmdline;
@@ -425,6 +497,8 @@ #endif
 
 	parse_early_param();
 
+	check_cpu_features();
+
 	check_smt_enabled();
 	smp_setup_cpu_maps();
 
