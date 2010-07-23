Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: print cores passed to firmware in decimal
In-reply-to: <4C48B36E.6040505@linux.vnet.ibm.com>
References: <4553.1279775749@neuling.org> <4C48B36E.6040505@linux.vnet.ibm.com>
Date: Fri, 23 Jul 2010 11:44:40 +1000
Message-ID: <10860.1279849480@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we look pretty stupid when printing out the number of cores
passed to FW

  Max number of cores passed to firmware: 0x0000000000000080

So I've change this to print in decimal:

  Max number of cores passed to firmware: 128 (NR_CPUS = 256)

This required adding a prom_print_dec() function. 

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
> >   		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCO
RES_OFFSET]);
> >   		if (*cores != NR_CPUS) {
> >   			prom_printf("WARNING ! "
> > -				    "ibm_architecture_vec structure inconsisten
t: 0x%x !\n",
> > +				    "ibm_architecture_vec structure inconsisten
t: 0x%i !\n",
> >   				    *cores);
> >    
> 
> Since we're changing from hex to decimal, we shouldn't print the "0x".

Oops yes.  Thanks!

BTW please CC me directly rather than sending only to the list.

 arch/powerpc/kernel/prom_init.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 3b6f8ae..28b9116 100644
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
@@ -869,12 +898,12 @@ static void __init prom_send_capabilities(void)
 		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET]);
 		if (*cores != NR_CPUS) {
 			prom_printf("WARNING ! "
-				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
+				    "ibm_architecture_vec structure inconsistent: %lu !\n",
 				    *cores);
 		} else {
 			*cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
-			prom_printf("Max number of cores passed to firmware: 0x%x\n",
-				    (unsigned long)*cores);
+			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
+				    *cores, NR_CPUS);
 		}
 
 		/* try calling the ibm,client-architecture-support method */
