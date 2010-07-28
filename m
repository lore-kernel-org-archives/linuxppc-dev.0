Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>, benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
	anton@samba.org
Subject: [PATCH] powerpc: print decimal values in prom_init.c
In-reply-to: <10860.1279849480@neuling.org>
References: <4553.1279775749@neuling.org> <4C48B36E.6040505@linux.vnet.ibm.com>
	<10860.1279849480@neuling.org>
Date: Wed, 28 Jul 2010 11:24:01 +1000
Message-ID: <3394.1280280241@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we look pretty stupid when printing out a bunch of things in
prom_init.c.  eg.

  Max number of cores passed to firmware: 0x0000000000000080

So I've change this to print in decimal:

  Max number of cores passed to firmware: 128 (NR_CPUS = 256)

This required adding a prom_print_dec() function and changing some
prom_printk() calls from %x to %lu.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This version changes more things over to decimal.

 arch/powerpc/kernel/prom_init.c |   47 +++++++++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 3b6f8ae..7bc5ae8 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -311,6 +311,27 @@ static void __init prom_print_hex(unsigned long val)
 	call_prom("write", 3, 1, _prom->stdout, buf, nibbles);
 }
 
+/* max number of decimal digits in an unsigned long */
+#define UL_DIGITS 21
+static void __init prom_print_dec(unsigned long val)
+{
+	int i, size;
+	char buf[UL_DIGITS+1];
+	struct prom_t *_prom = &RELOC(prom);
+
+	for (i = UL_DIGITS-1; i >= 0;  i--) {
+		buf[i] = (val % 10) + '0';
+		val = val/10;
+		if (val == 0)
+			break;
+	}
+	/* shift stuff down */
+	size = UL_DIGITS - i;
+	for (i = 0 ; i < size ; i++)
+		buf[i] = buf[i + UL_DIGITS - size];
+	buf[size+1] = '\0';
+	call_prom("write", 3, 1, _prom->stdout, buf, size);
+}
 
 static void __init prom_printf(const char *format, ...)
 {
@@ -350,6 +371,14 @@ static void __init prom_printf(const char *format, ...)
 			v = va_arg(args, unsigned long);
 			prom_print_hex(v);
 			break;
+		case 'l':
+			++q;
+			if (*q == 'u') { /* '%lu' */
+				++q;
+				v = va_arg(args, unsigned long);
+				prom_print_dec(v);
+			}
+			break;
 		}
 	}
 }
@@ -835,11 +864,11 @@ static int __init prom_count_smt_threads(void)
 		if (plen == PROM_ERROR)
 			break;
 		plen >>= 2;
-		prom_debug("Found 0x%x smt threads per core\n", (unsigned long)plen);
+		prom_debug("Found %lu smt threads per core\n", (unsigned long)plen);
 
 		/* Sanity check */
 		if (plen < 1 || plen > 64) {
-			prom_printf("Threads per core 0x%x out of bounds, assuming 1\n",
+			prom_printf("Threads per core %lu out of bounds, assuming 1\n",
 				    (unsigned long)plen);
 			return 1;
 		}
@@ -869,12 +898,12 @@ static void __init prom_send_capabilities(void)
 		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET]);
 		if (*cores != NR_CPUS) {
 			prom_printf("WARNING ! "
-				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
+				    "ibm_architecture_vec structure inconsistent: %lu!\n",
 				    *cores);
 		} else {
 			*cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
-			prom_printf("Max number of cores passed to firmware: 0x%x\n",
-				    (unsigned long)*cores);
+			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
+				    *cores, NR_CPUS);
 		}
 
 		/* try calling the ibm,client-architecture-support method */
@@ -1482,7 +1511,7 @@ static void __init prom_hold_cpus(void)
 		reg = -1;
 		prom_getprop(node, "reg", &reg, sizeof(reg));
 
-		prom_debug("cpu hw idx   = 0x%x\n", reg);
+		prom_debug("cpu hw idx   = %lu\n", reg);
 
 		/* Init the acknowledge var which will be reset by
 		 * the secondary cpu when it awakens from its OF
@@ -1492,7 +1521,7 @@ static void __init prom_hold_cpus(void)
 
 		if (reg != _prom->cpu) {
 			/* Primary Thread of non-boot cpu */
-			prom_printf("starting cpu hw idx %x... ", reg);
+			prom_printf("starting cpu hw idx %lu... ", reg);
 			call_prom("start-cpu", 3, 0, node,
 				  secondary_hold, reg);
 
@@ -1507,7 +1536,7 @@ static void __init prom_hold_cpus(void)
 		}
 #ifdef CONFIG_SMP
 		else
-			prom_printf("boot cpu hw idx %x\n", reg);
+			prom_printf("boot cpu hw idx %lu\n", reg);
 #endif /* CONFIG_SMP */
 	}
 
@@ -2420,7 +2449,7 @@ static void __init prom_find_boot_cpu(void)
 	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
 	_prom->cpu = getprop_rval;
 
-	prom_debug("Booting CPU hw index = 0x%x\n", _prom->cpu);
+	prom_debug("Booting CPU hw index = %lu\n", _prom->cpu);
 }
 
 static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
