Message-ID: <1290.81.137.83.225.1086682323.squirrel@www.solinno.co.uk>
Date: Tue, 8 Jun 2004 09:12:03 +0100 (BST)
Subject: [PATCH][RFC] have_residual_data()
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040608091203_83559"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


------=_20040608091203_83559
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I just read Gustavo's email, and co-incidently have finally began looking
again at my patches over the last couple of days to see about making
them good enough to submit.  To this end, please find attached a patch
to create a new inline function have_residual_data(), which looks like
this:

static inline int have_residual_data(void) {
#if       defined(CONFIG_PREP_RESIDUAL)
	return res && res->ResidualLength;
#else /* !defined(CONFIG_PREP_RESIDUAL) */
	return 0;
#endif /* defined(CONFIG_PREP_RESIDUAL) */
}

The idea is that instead of:

#ifdef CONFIG_PREP_RESIDAL
	do_something_cool_with_residual_data();
#else
	do_something_icky_with_hardcoded_values();
#endif

you can do:

	if (have_residual_data())
		do_something_cool();
	else
		do_something_icky();

When CONFIG_PREP_RESIDUAL is not defined then the compiler does the
right thing.

The rest of the patch is changing the code that can make use of it.
All of my patches depend on residual data so without this patch they
look kind of ugly.  I've also attached it because my webmail client
will break it.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-07
11:44:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-07
16:25:54.000000000 +0100
@@ -836,52 +836,52 @@
 void __init
 ibm_prep_init(void)
 {
-#ifdef CONFIG_PREP_RESIDUAL
-	u32 addr, real_addr, len;
-	PPC_DEVICE *mpic;
-	PnP_TAG_PACKET *pkt;
-
-	/* Use the PReP residual data to determine if an OpenPIC is
-	 * present.  If so, get the large vendor packet which will
-	 * tell us the base address and length in memory.
-	 * If we are successful, ioremap the memory area and set
-	 * OpenPIC_Addr (this indicates that the OpenPIC was found).
-	 */
-	mpic = residual_find_device(-1, NULL, SystemPeripheral,
-			    ProgrammableInterruptController, MPIC, 0);
-	if (!mpic)
-		return;
+	if (have_residual_data()) {
+		u32 addr, real_addr, len;
+		PPC_DEVICE *mpic;
+		PnP_TAG_PACKET *pkt;
+
+		/* Use the PReP residual data to determine if an OpenPIC is
+		 * present.  If so, get the large vendor packet which will
+		 * tell us the base address and length in memory.
+		 * If we are successful, ioremap the memory area and set
+		 * OpenPIC_Addr (this indicates that the OpenPIC was found).
+		 */
+		mpic = residual_find_device(-1, NULL, SystemPeripheral,
+				    ProgrammableInterruptController, MPIC, 0);
+		if (!mpic)
+			return;

-	pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
-			mpic->AllocatedOffset, 9, 0);
+		pkt = PnP_find_large_vendor_packet(res->DevicePnPHeap +
+				mpic->AllocatedOffset, 9, 0);

-	if (!pkt)
-		return;
+		if (!pkt)
+			return;

 #define p pkt->L4_Pack.L4_Data.L4_PPCPack
-	if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
-		return; /* not a 32-bit memory address */
-
-	real_addr = ld_le32((unsigned int *) (p.PPCData + 4));
-	if (real_addr == 0xffffffff)
-		return;
+		if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
+			return; /* not a 32-bit memory address */

-	/* Adjust address to be as seen by CPU */
-	addr = real_addr + PREP_ISA_MEM_BASE;
-
-	len = ld_le32((unsigned int *) (p.PPCData + 12));
-	if (!len)
-		return;
+		real_addr = ld_le32((unsigned int *) (p.PPCData + 4));
+		if (real_addr == 0xffffffff)
+			return;
+
+		/* Adjust address to be as seen by CPU */
+		addr = real_addr + PREP_ISA_MEM_BASE;
+
+		len = ld_le32((unsigned int *) (p.PPCData + 12));
+		if (!len)
+			return;
 #undef p
-	OpenPIC_Addr = ioremap(addr, len);
-	ppc_md.get_irq = openpic_get_irq;
+		OpenPIC_Addr = ioremap(addr, len);
+		ppc_md.get_irq = openpic_get_irq;

-	OpenPIC_InitSenses = prep_openpic_initsenses;
-	OpenPIC_NumInitSenses = sizeof(prep_openpic_initsenses);
+		OpenPIC_InitSenses = prep_openpic_initsenses;
+		OpenPIC_NumInitSenses = sizeof(prep_openpic_initsenses);

-	printk(KERN_INFO "MPIC at 0x%08x (0x%08x), length 0x%08x "
-	       "mapped to 0x%p\n", addr, real_addr, len, OpenPIC_Addr);
-#endif
+		printk(KERN_INFO "MPIC at 0x%08x (0x%08x), length 0x%08x "
+		       "mapped to 0x%p\n", addr, real_addr, len, OpenPIC_Addr);
+	}
 }

 static void __init
@@ -1262,8 +1262,8 @@
 			   PREP_ISA_IO_BASE + 0xcfc);

 	printk("PReP architecture\n");
-#ifdef CONFIG_PREP_RESIDUAL
-	{
+
+	if (have_residual_data()) {
 		PPC_DEVICE *hostbridge;

 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
@@ -1284,7 +1284,6 @@
 				setup_indirect_pci(hose, 0x80000cf8, 0x80000cfc);
 		}
 	}
-#endif /* CONFIG_PREP_RESIDUAL */

 	ppc_md.pcibios_fixup = prep_pcibios_fixup;
 	ppc_md.pcibios_after_init = prep_pcibios_after_init;
diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c
linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c	2004-06-07
11:44:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-07
16:37:25.000000000 +0100
@@ -194,9 +194,8 @@
 		seq_printf(m, "bad");
 	seq_printf(m, "\n");

-#ifdef CONFIG_PREP_RESIDUAL
 	/* print info about SIMMs */
-	if (res->ResidualLength != 0) {
+	if (have_residual_data()) {
 		int i;
 		seq_printf(m, "simms\t\t: ");
 		for (i = 0; (res->ActualNumMemories) && (i < MAX_MEMS); i++) {
@@ -208,7 +207,6 @@
 		}
 		seq_printf(m, "\n");
 	}
-#endif
 }

 static int __prep
@@ -432,9 +430,8 @@
 	}

 no_l2:
-#ifdef CONFIG_PREP_RESIDUAL
 	/* print info about SIMMs */
-	if (res->ResidualLength != 0) {
+	if (have_residual_data()) {
 		int i;
 		seq_printf(m, "simms\t\t: ");
 		for (i = 0; (res->ActualNumMemories) && (i < MAX_MEMS); i++) {
@@ -446,7 +443,6 @@
 		}
 		seq_printf(m, "\n");
 	}
-#endif

 	return 0;
 }
@@ -562,14 +558,12 @@
 {
 	/* PREP's without residual data will give incorrect values here */
 	seq_printf(m, "clock\t\t: ");
-#ifdef CONFIG_PREP_RESIDUAL
-	if (res->ResidualLength)
+	if (have_residual_data())
 		seq_printf(m, "%ldMHz\n",
 			   (res->VitalProductData.ProcessorHz > 1024) ?
 			   res->VitalProductData.ProcessorHz / 1000000 :
 			   res->VitalProductData.ProcessorHz);
 	else
-#endif /* CONFIG_PREP_RESIDUAL */
 		seq_printf(m, "???\n");

 	return 0;
@@ -599,9 +593,10 @@
 	 * Get the needed resource informations from residual data.
 	 *
 	 */
-#ifdef CONFIG_PREP_RESIDUAL
-	audiodevice = residual_find_device(~0, NULL, MultimediaController,
-			AudioController, -1, 0);
+	if (have_residual_data())
+		audiodevice = residual_find_device(~0, NULL,
+				MultimediaController, AudioController, -1, 0);
+
 	if (audiodevice != NULL) {
 		PnP_TAG_PACKET *pkt;

@@ -614,7 +609,6 @@
 		if (pkt != NULL)
 			ppc_cs4232_dma2 = masktoint(pkt->S5_Pack.DMAMask);
 	}
-#endif

 	/*
 	 * These are the PReP specs' defaults for the cs4231.  We use these
@@ -650,13 +644,14 @@
 static void __init
 prep_init_vesa(void)
 {
-#if defined(CONFIG_PREP_RESIDUAL) && \
-	(defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
+#if     (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
 	 defined(CONFIG_FB_VESA))
-	PPC_DEVICE *vgadev;
+	PPC_DEVICE *vgadev = NULL;
+
+	if (have_residual_data())
+		vgadev = residual_find_device(~0, NULL, DisplayController,
+							SVGAController, -1, 0);

-	vgadev = residual_find_device(~0, NULL, DisplayController, SVGAController,
-									-1, 0);
 	if (vgadev != NULL) {
 		PnP_TAG_PACKET *pkt;

@@ -681,7 +676,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_PREP_RESIDUAL */
+#endif
 }

 static void __init
@@ -822,18 +817,19 @@
 static void __init
 prep_calibrate_decr(void)
 {
-#ifdef CONFIG_PREP_RESIDUAL
-	unsigned long freq, divisor = 4;
+	if (have_residual_data()) {
+		unsigned long freq, divisor = 4;

-	if ( res->VitalProductData.ProcessorBusHz ) {
-		freq = res->VitalProductData.ProcessorBusHz;
-		printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
-				(freq/divisor)/1000000,
-				(freq/divisor)%1000000);
-		tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
-		tb_ticks_per_jiffy = freq / HZ / divisor;
-	} else
-#endif
+		if ( res->VitalProductData.ProcessorBusHz ) {
+			freq = res->VitalProductData.ProcessorBusHz;
+			printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+					(freq/divisor)/1000000,
+					(freq/divisor)%1000000);
+			tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+			tb_ticks_per_jiffy = freq / HZ / divisor;
+		}
+	}
+	else
 		todc_calibrate_decr();
 }

@@ -1001,15 +997,14 @@
 	DMA_MODE_WRITE = 0x48;

 	/* figure out what kind of prep workstation we are */
-#ifdef CONFIG_PREP_RESIDUAL
-	if ( res->ResidualLength !=  ) {
+	if (have_residual_data()) {
 		if ( !strncmp(res->VitalProductData.PrintableModel,"IBM",3) )
 			_prep_type = _PREP_IBM;
 		else
 			_prep_type = _PREP_Motorola;
-	} else /* assume motorola if no residual (netboot?) */
-#endif
-	{
+	}
+	else {
+		/* assume motorola if no residual (netboot?) */
 		_prep_type = _PREP_Motorola;
 	}

diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/residual.c
linux-2.6.6/arch/ppc/platforms/residual.c
--- linux-2.6.6-prev/arch/ppc/platforms/residual.c	2004-01-09
06:59:10.000000000 +0000
+++ linux-2.6.6/arch/ppc/platforms/residual.c	2004-06-07
16:25:54.000000000 +0100
@@ -504,7 +504,7 @@
 #define did dev->DeviceId

 	/* make sure we have residual data first */
-	if ( res->ResidualLength ==  )
+	if (!have_residual_data())
 		return;

 	printk("Residual: %ld devices\n", res->ActualNumDevices);
@@ -639,7 +639,7 @@
 #define did dev->DeviceId

 	/* make sure we have residual data first */
-	if ( res->ResidualLength ==  )
+	if (!have_residual_data())
 		return;
 	printk("Residual: %ld devices\n", res->ActualNumDevices);
 	for ( i = 0;
@@ -790,7 +790,7 @@
 			 int n)
 {
 	int i;
-	if ( !res->ResidualLength ) return NULL;
+	if (!have_residual_data()) return NULL;
 	for (i=0; i<res->ActualNumDevices; i++) {
 #define Dev res->Devices[i].DeviceId
 		if ( (Dev.BusId&BusMask)                                  &&
@@ -813,7 +813,7 @@
 			 int n)
 {
 	int i;
-	if ( !res->ResidualLength ) return NULL;
+	if (!have_residual_data()) return NULL;
 	for (i=0; i<res->ActualNumDevices; i++) {
 #define Dev res->Devices[i].DeviceId
 		if ( (Dev.BusId&BusMask)                                  &&
@@ -901,7 +901,7 @@
 int __init
 proc_prep_residual_init(void)
 {
-	if (res->ResidualLength)
+	if (have_residual_data())
 		create_proc_read_entry("residual", S_IRUGO, NULL,
 					proc_prep_residual_read, NULL);
 	return 0;
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/residual.h
linux-2.6.6/include/asm-ppc/residual.h
--- linux-2.6.6-prev/include/asm-ppc/residual.h	2004-01-09
06:59:27.000000000 +0000
+++ linux-2.6.6/include/asm-ppc/residual.h	2004-06-07 16:25:54.000000000
+0100
@@ -328,6 +328,15 @@
 extern PnP_TAG_PACKET *PnP_find_large_vendor_packet(unsigned char *p,
 						    unsigned packet_type,
 						    int n);
+
+static inline int have_residual_data(void) {
+#if       defined(CONFIG_PREP_RESIDUAL)
+	return res && res->ResidualLength;
+#else /* !defined(CONFIG_PREP_RESIDUAL) */
+	return 0;
+#endif /* defined(CONFIG_PREP_RESIDUAL) */
+}
+
 #endif /* __ASSEMBLY__ */
 #endif  /* ndef _RESIDUAL_ */


------=_20040608091203_83559
Content-Type: application/octet-stream; name="005-have-residual-data.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="005-have-residual-data.diff"

ZGlmZiAtdXJOWCAuZGlmZmV4IGxpbnV4LTIuNi42LXByZXYvYXJjaC9wcGMvcGxhdGZvcm1zL3By
ZXBfcGNpLmMgbGludXgtMi42LjYvYXJjaC9wcGMvcGxhdGZvcm1zL3ByZXBfcGNpLmMKLS0tIGxp
bnV4LTIuNi42LXByZXYvYXJjaC9wcGMvcGxhdGZvcm1zL3ByZXBfcGNpLmMJMjAwNC0wNi0wNyAx
MTo0NDo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi42L2FyY2gvcHBjL3BsYXRmb3Jt
cy9wcmVwX3BjaS5jCTIwMDQtMDYtMDcgMTY6MjU6NTQuMDAwMDAwMDAwICswMTAwCkBAIC04MzYs
NTIgKzgzNiw1MiBAQAogdm9pZCBfX2luaXQKIGlibV9wcmVwX2luaXQodm9pZCkKIHsKLSNpZmRl
ZiBDT05GSUdfUFJFUF9SRVNJRFVBTAotCXUzMiBhZGRyLCByZWFsX2FkZHIsIGxlbjsKLQlQUENf
REVWSUNFICptcGljOwotCVBuUF9UQUdfUEFDS0VUICpwa3Q7Ci0KLQkvKiBVc2UgdGhlIFBSZVAg
cmVzaWR1YWwgZGF0YSB0byBkZXRlcm1pbmUgaWYgYW4gT3BlblBJQyBpcwotCSAqIHByZXNlbnQu
ICBJZiBzbywgZ2V0IHRoZSBsYXJnZSB2ZW5kb3IgcGFja2V0IHdoaWNoIHdpbGwKLQkgKiB0ZWxs
IHVzIHRoZSBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBpbiBtZW1vcnkuCi0JICogSWYgd2UgYXJl
IHN1Y2Nlc3NmdWwsIGlvcmVtYXAgdGhlIG1lbW9yeSBhcmVhIGFuZCBzZXQKLQkgKiBPcGVuUElD
X0FkZHIgKHRoaXMgaW5kaWNhdGVzIHRoYXQgdGhlIE9wZW5QSUMgd2FzIGZvdW5kKS4KLQkgKi8K
LQltcGljID0gcmVzaWR1YWxfZmluZF9kZXZpY2UoLTEsIE5VTEwsIFN5c3RlbVBlcmlwaGVyYWws
Ci0JCQkgICAgUHJvZ3JhbW1hYmxlSW50ZXJydXB0Q29udHJvbGxlciwgTVBJQywgMCk7Ci0JaWYg
KCFtcGljKQotCQlyZXR1cm47CisJaWYgKGhhdmVfcmVzaWR1YWxfZGF0YSgpKSB7CisJCXUzMiBh
ZGRyLCByZWFsX2FkZHIsIGxlbjsKKwkJUFBDX0RFVklDRSAqbXBpYzsKKwkJUG5QX1RBR19QQUNL
RVQgKnBrdDsKKworCQkvKiBVc2UgdGhlIFBSZVAgcmVzaWR1YWwgZGF0YSB0byBkZXRlcm1pbmUg
aWYgYW4gT3BlblBJQyBpcworCQkgKiBwcmVzZW50LiAgSWYgc28sIGdldCB0aGUgbGFyZ2UgdmVu
ZG9yIHBhY2tldCB3aGljaCB3aWxsCisJCSAqIHRlbGwgdXMgdGhlIGJhc2UgYWRkcmVzcyBhbmQg
bGVuZ3RoIGluIG1lbW9yeS4KKwkJICogSWYgd2UgYXJlIHN1Y2Nlc3NmdWwsIGlvcmVtYXAgdGhl
IG1lbW9yeSBhcmVhIGFuZCBzZXQKKwkJICogT3BlblBJQ19BZGRyICh0aGlzIGluZGljYXRlcyB0
aGF0IHRoZSBPcGVuUElDIHdhcyBmb3VuZCkuCisJCSAqLworCQltcGljID0gcmVzaWR1YWxfZmlu
ZF9kZXZpY2UoLTEsIE5VTEwsIFN5c3RlbVBlcmlwaGVyYWwsCisJCQkJICAgIFByb2dyYW1tYWJs
ZUludGVycnVwdENvbnRyb2xsZXIsIE1QSUMsIDApOworCQlpZiAoIW1waWMpCisJCQlyZXR1cm47
CiAKLQlwa3QgPSBQblBfZmluZF9sYXJnZV92ZW5kb3JfcGFja2V0KHJlcy0+RGV2aWNlUG5QSGVh
cCArCi0JCQltcGljLT5BbGxvY2F0ZWRPZmZzZXQsIDksIDApOworCQlwa3QgPSBQblBfZmluZF9s
YXJnZV92ZW5kb3JfcGFja2V0KHJlcy0+RGV2aWNlUG5QSGVhcCArCisJCQkJbXBpYy0+QWxsb2Nh
dGVkT2Zmc2V0LCA5LCAwKTsKIAotCWlmICghcGt0KQotCQlyZXR1cm47CisJCWlmICghcGt0KQor
CQkJcmV0dXJuOwogCiAjZGVmaW5lIHAgcGt0LT5MNF9QYWNrLkw0X0RhdGEuTDRfUFBDUGFjawot
CWlmICghKChwLlBQQ0RhdGFbMF0gPT0gMikgJiYgKHAuUFBDRGF0YVsxXSA9PSAzMikpKQotCQly
ZXR1cm47IC8qIG5vdCBhIDMyLWJpdCBtZW1vcnkgYWRkcmVzcyAqLwotCi0JcmVhbF9hZGRyID0g
bGRfbGUzMigodW5zaWduZWQgaW50ICopIChwLlBQQ0RhdGEgKyA0KSk7Ci0JaWYgKHJlYWxfYWRk
ciA9PSAweGZmZmZmZmZmKQotCQlyZXR1cm47CisJCWlmICghKChwLlBQQ0RhdGFbMF0gPT0gMikg
JiYgKHAuUFBDRGF0YVsxXSA9PSAzMikpKQorCQkJcmV0dXJuOyAvKiBub3QgYSAzMi1iaXQgbWVt
b3J5IGFkZHJlc3MgKi8KIAotCS8qIEFkanVzdCBhZGRyZXNzIHRvIGJlIGFzIHNlZW4gYnkgQ1BV
ICovCi0JYWRkciA9IHJlYWxfYWRkciArIFBSRVBfSVNBX01FTV9CQVNFOwotCi0JbGVuID0gbGRf
bGUzMigodW5zaWduZWQgaW50ICopIChwLlBQQ0RhdGEgKyAxMikpOwotCWlmICghbGVuKQotCQly
ZXR1cm47CisJCXJlYWxfYWRkciA9IGxkX2xlMzIoKHVuc2lnbmVkIGludCAqKSAocC5QUENEYXRh
ICsgNCkpOworCQlpZiAocmVhbF9hZGRyID09IDB4ZmZmZmZmZmYpCisJCQlyZXR1cm47CisKKwkJ
LyogQWRqdXN0IGFkZHJlc3MgdG8gYmUgYXMgc2VlbiBieSBDUFUgKi8KKwkJYWRkciA9IHJlYWxf
YWRkciArIFBSRVBfSVNBX01FTV9CQVNFOworCisJCWxlbiA9IGxkX2xlMzIoKHVuc2lnbmVkIGlu
dCAqKSAocC5QUENEYXRhICsgMTIpKTsKKwkJaWYgKCFsZW4pCisJCQlyZXR1cm47CiAjdW5kZWYg
cAotCU9wZW5QSUNfQWRkciA9IGlvcmVtYXAoYWRkciwgbGVuKTsKLQlwcGNfbWQuZ2V0X2lycSA9
IG9wZW5waWNfZ2V0X2lycTsKKwkJT3BlblBJQ19BZGRyID0gaW9yZW1hcChhZGRyLCBsZW4pOwor
CQlwcGNfbWQuZ2V0X2lycSA9IG9wZW5waWNfZ2V0X2lycTsKIAotCU9wZW5QSUNfSW5pdFNlbnNl
cyA9IHByZXBfb3BlbnBpY19pbml0c2Vuc2VzOwotCU9wZW5QSUNfTnVtSW5pdFNlbnNlcyA9IHNp
emVvZihwcmVwX29wZW5waWNfaW5pdHNlbnNlcyk7CisJCU9wZW5QSUNfSW5pdFNlbnNlcyA9IHBy
ZXBfb3BlbnBpY19pbml0c2Vuc2VzOworCQlPcGVuUElDX051bUluaXRTZW5zZXMgPSBzaXplb2Yo
cHJlcF9vcGVucGljX2luaXRzZW5zZXMpOwogCi0JcHJpbnRrKEtFUk5fSU5GTyAiTVBJQyBhdCAw
eCUwOHggKDB4JTA4eCksIGxlbmd0aCAweCUwOHggIgotCSAgICAgICAibWFwcGVkIHRvIDB4JXBc
biIsIGFkZHIsIHJlYWxfYWRkciwgbGVuLCBPcGVuUElDX0FkZHIpOwotI2VuZGlmCisJCXByaW50
ayhLRVJOX0lORk8gIk1QSUMgYXQgMHglMDh4ICgweCUwOHgpLCBsZW5ndGggMHglMDh4ICIKKwkJ
ICAgICAgICJtYXBwZWQgdG8gMHglcFxuIiwgYWRkciwgcmVhbF9hZGRyLCBsZW4sIE9wZW5QSUNf
QWRkcik7CisJfQogfQogCiBzdGF0aWMgdm9pZCBfX2luaXQKQEAgLTEyNjIsOCArMTI2Miw4IEBA
CiAJCQkgICBQUkVQX0lTQV9JT19CQVNFICsgMHhjZmMpOwogCiAJcHJpbnRrKCJQUmVQIGFyY2hp
dGVjdHVyZVxuIik7Ci0jaWZkZWYgQ09ORklHX1BSRVBfUkVTSURVQUwKLQl7CisKKwlpZiAoaGF2
ZV9yZXNpZHVhbF9kYXRhKCkpIHsKIAkJUFBDX0RFVklDRSAqaG9zdGJyaWRnZTsKIAogCQlob3N0
YnJpZGdlID0gcmVzaWR1YWxfZmluZF9kZXZpY2UoUFJPQ0VTU09SREVWSUNFLCBOVUxMLApAQCAt
MTI4NCw3ICsxMjg0LDYgQEAKIAkJCQlzZXR1cF9pbmRpcmVjdF9wY2koaG9zZSwgMHg4MDAwMGNm
OCwgMHg4MDAwMGNmYyk7CiAJCX0KIAl9Ci0jZW5kaWYgLyogQ09ORklHX1BSRVBfUkVTSURVQUwg
Ki8KIAogCXBwY19tZC5wY2liaW9zX2ZpeHVwID0gcHJlcF9wY2liaW9zX2ZpeHVwOwogCXBwY19t
ZC5wY2liaW9zX2FmdGVyX2luaXQgPSBwcmVwX3BjaWJpb3NfYWZ0ZXJfaW5pdDsKZGlmZiAtdXJO
WCAuZGlmZmV4IGxpbnV4LTIuNi42LXByZXYvYXJjaC9wcGMvcGxhdGZvcm1zL3ByZXBfc2V0dXAu
YyBsaW51eC0yLjYuNi9hcmNoL3BwYy9wbGF0Zm9ybXMvcHJlcF9zZXR1cC5jCi0tLSBsaW51eC0y
LjYuNi1wcmV2L2FyY2gvcHBjL3BsYXRmb3Jtcy9wcmVwX3NldHVwLmMJMjAwNC0wNi0wNyAxMTo0
NDo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi42L2FyY2gvcHBjL3BsYXRmb3Jtcy9w
cmVwX3NldHVwLmMJMjAwNC0wNi0wNyAxNjozNzoyNS4wMDAwMDAwMDAgKzAxMDAKQEAgLTE5NCw5
ICsxOTQsOCBAQAogCQlzZXFfcHJpbnRmKG0sICJiYWQiKTsKIAlzZXFfcHJpbnRmKG0sICJcbiIp
OwogCi0jaWZkZWYgQ09ORklHX1BSRVBfUkVTSURVQUwKIAkvKiBwcmludCBpbmZvIGFib3V0IFNJ
TU1zICovCi0JaWYgKHJlcy0+UmVzaWR1YWxMZW5ndGggIT0gMCkgeworCWlmIChoYXZlX3Jlc2lk
dWFsX2RhdGEoKSkgewogCQlpbnQgaTsKIAkJc2VxX3ByaW50ZihtLCAic2ltbXNcdFx0OiAiKTsK
IAkJZm9yIChpID0gMDsgKHJlcy0+QWN0dWFsTnVtTWVtb3JpZXMpICYmIChpIDwgTUFYX01FTVMp
OyBpKyspIHsKQEAgLTIwOCw3ICsyMDcsNiBAQAogCQl9CiAJCXNlcV9wcmludGYobSwgIlxuIik7
CiAJfQotI2VuZGlmCiB9CiAKIHN0YXRpYyBpbnQgX19wcmVwCkBAIC00MzIsOSArNDMwLDggQEAK
IAl9CiAKIG5vX2wyOgotI2lmZGVmIENPTkZJR19QUkVQX1JFU0lEVUFMCiAJLyogcHJpbnQgaW5m
byBhYm91dCBTSU1NcyAqLwotCWlmIChyZXMtPlJlc2lkdWFsTGVuZ3RoICE9IDApIHsKKwlpZiAo
aGF2ZV9yZXNpZHVhbF9kYXRhKCkpIHsKIAkJaW50IGk7CiAJCXNlcV9wcmludGYobSwgInNpbW1z
XHRcdDogIik7CiAJCWZvciAoaSA9IDA7IChyZXMtPkFjdHVhbE51bU1lbW9yaWVzKSAmJiAoaSA8
IE1BWF9NRU1TKTsgaSsrKSB7CkBAIC00NDYsNyArNDQzLDYgQEAKIAkJfQogCQlzZXFfcHJpbnRm
KG0sICJcbiIpOwogCX0KLSNlbmRpZgogCiAJcmV0dXJuIDA7CiB9CkBAIC01NjIsMTQgKzU1OCwx
MiBAQAogewogCS8qIFBSRVAncyB3aXRob3V0IHJlc2lkdWFsIGRhdGEgd2lsbCBnaXZlIGluY29y
cmVjdCB2YWx1ZXMgaGVyZSAqLwogCXNlcV9wcmludGYobSwgImNsb2NrXHRcdDogIik7Ci0jaWZk
ZWYgQ09ORklHX1BSRVBfUkVTSURVQUwKLQlpZiAocmVzLT5SZXNpZHVhbExlbmd0aCkKKwlpZiAo
aGF2ZV9yZXNpZHVhbF9kYXRhKCkpCiAJCXNlcV9wcmludGYobSwgIiVsZE1IelxuIiwKIAkJCSAg
IChyZXMtPlZpdGFsUHJvZHVjdERhdGEuUHJvY2Vzc29ySHogPiAxMDI0KSA/CiAJCQkgICByZXMt
PlZpdGFsUHJvZHVjdERhdGEuUHJvY2Vzc29ySHogLyAxMDAwMDAwIDoKIAkJCSAgIHJlcy0+Vml0
YWxQcm9kdWN0RGF0YS5Qcm9jZXNzb3JIeik7CiAJZWxzZQotI2VuZGlmIC8qIENPTkZJR19QUkVQ
X1JFU0lEVUFMICovCiAJCXNlcV9wcmludGYobSwgIj8/P1xuIik7CiAKIAlyZXR1cm4gMDsKQEAg
LTU5OSw5ICs1OTMsMTAgQEAKIAkgKiBHZXQgdGhlIG5lZWRlZCByZXNvdXJjZSBpbmZvcm1hdGlv
bnMgZnJvbSByZXNpZHVhbCBkYXRhLgogCSAqCiAJICovCi0jaWZkZWYgQ09ORklHX1BSRVBfUkVT
SURVQUwKLQlhdWRpb2RldmljZSA9IHJlc2lkdWFsX2ZpbmRfZGV2aWNlKH4wLCBOVUxMLCBNdWx0
aW1lZGlhQ29udHJvbGxlciwKLQkJCUF1ZGlvQ29udHJvbGxlciwgLTEsIDApOworCWlmIChoYXZl
X3Jlc2lkdWFsX2RhdGEoKSkKKwkJYXVkaW9kZXZpY2UgPSByZXNpZHVhbF9maW5kX2RldmljZSh+
MCwgTlVMTCwKKwkJCQlNdWx0aW1lZGlhQ29udHJvbGxlciwgQXVkaW9Db250cm9sbGVyLCAtMSwg
MCk7CisKIAlpZiAoYXVkaW9kZXZpY2UgIT0gTlVMTCkgewogCQlQblBfVEFHX1BBQ0tFVCAqcGt0
OwogCkBAIC02MTQsNyArNjA5LDYgQEAKIAkJaWYgKHBrdCAhPSBOVUxMKQogCQkJcHBjX2NzNDIz
Ml9kbWEyID0gbWFza3RvaW50KHBrdC0+UzVfUGFjay5ETUFNYXNrKTsKIAl9Ci0jZW5kaWYKIAog
CS8qCiAJICogVGhlc2UgYXJlIHRoZSBQUmVQIHNwZWNzJyBkZWZhdWx0cyBmb3IgdGhlIGNzNDIz
MS4gIFdlIHVzZSB0aGVzZQpAQCAtNjUwLDEzICs2NDQsMTQgQEAKIHN0YXRpYyB2b2lkIF9faW5p
dAogcHJlcF9pbml0X3Zlc2Eodm9pZCkKIHsKLSNpZiBkZWZpbmVkKENPTkZJR19QUkVQX1JFU0lE
VUFMKSAmJiBcCi0JKGRlZmluZWQoQ09ORklHX0ZCX1ZHQTE2KSB8fCBkZWZpbmVkKENPTkZJR19G
Ql9WR0FfMTZfTU9EVUxFKSB8fCBcCisjaWYgICAgIChkZWZpbmVkKENPTkZJR19GQl9WR0ExNikg
fHwgZGVmaW5lZChDT05GSUdfRkJfVkdBXzE2X01PRFVMRSkgfHwgXAogCSBkZWZpbmVkKENPTkZJ
R19GQl9WRVNBKSkKLQlQUENfREVWSUNFICp2Z2FkZXY7CisJUFBDX0RFVklDRSAqdmdhZGV2ID0g
TlVMTDsKKworCWlmIChoYXZlX3Jlc2lkdWFsX2RhdGEoKSkKKwkJdmdhZGV2ID0gcmVzaWR1YWxf
ZmluZF9kZXZpY2UofjAsIE5VTEwsIERpc3BsYXlDb250cm9sbGVyLAorCQkJCQkJCVNWR0FDb250
cm9sbGVyLCAtMSwgMCk7CiAKLQl2Z2FkZXYgPSByZXNpZHVhbF9maW5kX2RldmljZSh+MCwgTlVM
TCwgRGlzcGxheUNvbnRyb2xsZXIsIFNWR0FDb250cm9sbGVyLAotCQkJCQkJCQkJLTEsIDApOwog
CWlmICh2Z2FkZXYgIT0gTlVMTCkgewogCQlQblBfVEFHX1BBQ0tFVCAqcGt0OwogCkBAIC02ODEs
NyArNjc2LDcgQEAKIAkJCX0KIAkJfQogCX0KLSNlbmRpZiAvKiBDT05GSUdfUFJFUF9SRVNJRFVB
TCAqLworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkIF9faW5pdApAQCAtODIyLDE4ICs4MTcsMTkg
QEAKIHN0YXRpYyB2b2lkIF9faW5pdAogcHJlcF9jYWxpYnJhdGVfZGVjcih2b2lkKQogewotI2lm
ZGVmIENPTkZJR19QUkVQX1JFU0lEVUFMCi0JdW5zaWduZWQgbG9uZyBmcmVxLCBkaXZpc29yID0g
NDsKKwlpZiAoaGF2ZV9yZXNpZHVhbF9kYXRhKCkpIHsKKwkJdW5zaWduZWQgbG9uZyBmcmVxLCBk
aXZpc29yID0gNDsKIAotCWlmICggcmVzLT5WaXRhbFByb2R1Y3REYXRhLlByb2Nlc3NvckJ1c0h6
ICkgewotCQlmcmVxID0gcmVzLT5WaXRhbFByb2R1Y3REYXRhLlByb2Nlc3NvckJ1c0h6OwotCQlw
cmludGsoInRpbWVfaW5pdDogZGVjcmVtZW50ZXIgZnJlcXVlbmN5ID0gJWx1LiUuNmx1IE1Ielxu
IiwKLQkJCQkoZnJlcS9kaXZpc29yKS8xMDAwMDAwLAotCQkJCShmcmVxL2Rpdmlzb3IpJTEwMDAw
MDApOwotCQl0Yl90b191cyA9IG11bGh3dV9zY2FsZV9mYWN0b3IoZnJlcS9kaXZpc29yLCAxMDAw
MDAwKTsKLQkJdGJfdGlja3NfcGVyX2ppZmZ5ID0gZnJlcSAvIEhaIC8gZGl2aXNvcjsKLQl9IGVs
c2UKLSNlbmRpZgorCQlpZiAoIHJlcy0+Vml0YWxQcm9kdWN0RGF0YS5Qcm9jZXNzb3JCdXNIeiAp
IHsKKwkJCWZyZXEgPSByZXMtPlZpdGFsUHJvZHVjdERhdGEuUHJvY2Vzc29yQnVzSHo7CisJCQlw
cmludGsoInRpbWVfaW5pdDogZGVjcmVtZW50ZXIgZnJlcXVlbmN5ID0gJWx1LiUuNmx1IE1Ielxu
IiwKKwkJCQkJKGZyZXEvZGl2aXNvcikvMTAwMDAwMCwKKwkJCQkJKGZyZXEvZGl2aXNvciklMTAw
MDAwMCk7CisJCQl0Yl90b191cyA9IG11bGh3dV9zY2FsZV9mYWN0b3IoZnJlcS9kaXZpc29yLCAx
MDAwMDAwKTsKKwkJCXRiX3RpY2tzX3Blcl9qaWZmeSA9IGZyZXEgLyBIWiAvIGRpdmlzb3I7CisJ
CX0KKwl9CisJZWxzZQogCQl0b2RjX2NhbGlicmF0ZV9kZWNyKCk7CiB9CiAKQEAgLTEwMDEsMTUg
Kzk5NywxNCBAQAogCURNQV9NT0RFX1dSSVRFID0gMHg0ODsKIAogCS8qIGZpZ3VyZSBvdXQgd2hh
dCBraW5kIG9mIHByZXAgd29ya3N0YXRpb24gd2UgYXJlICovCi0jaWZkZWYgQ09ORklHX1BSRVBf
UkVTSURVQUwKLQlpZiAoIHJlcy0+UmVzaWR1YWxMZW5ndGggIT0gMCApIHsKKwlpZiAoaGF2ZV9y
ZXNpZHVhbF9kYXRhKCkpIHsKIAkJaWYgKCAhc3RybmNtcChyZXMtPlZpdGFsUHJvZHVjdERhdGEu
UHJpbnRhYmxlTW9kZWwsIklCTSIsMykgKQogCQkJX3ByZXBfdHlwZSA9IF9QUkVQX0lCTTsKIAkJ
ZWxzZQogCQkJX3ByZXBfdHlwZSA9IF9QUkVQX01vdG9yb2xhOwotCX0gZWxzZSAvKiBhc3N1bWUg
bW90b3JvbGEgaWYgbm8gcmVzaWR1YWwgKG5ldGJvb3Q/KSAqLwotI2VuZGlmCi0JeworCX0KKwll
bHNlIHsKKwkJLyogYXNzdW1lIG1vdG9yb2xhIGlmIG5vIHJlc2lkdWFsIChuZXRib290PykgKi8K
IAkJX3ByZXBfdHlwZSA9IF9QUkVQX01vdG9yb2xhOwogCX0KIApkaWZmIC11ck5YIC5kaWZmZXgg
bGludXgtMi42LjYtcHJldi9hcmNoL3BwYy9wbGF0Zm9ybXMvcmVzaWR1YWwuYyBsaW51eC0yLjYu
Ni9hcmNoL3BwYy9wbGF0Zm9ybXMvcmVzaWR1YWwuYwotLS0gbGludXgtMi42LjYtcHJldi9hcmNo
L3BwYy9wbGF0Zm9ybXMvcmVzaWR1YWwuYwkyMDA0LTAxLTA5IDA2OjU5OjEwLjAwMDAwMDAwMCAr
MDAwMAorKysgbGludXgtMi42LjYvYXJjaC9wcGMvcGxhdGZvcm1zL3Jlc2lkdWFsLmMJMjAwNC0w
Ni0wNyAxNjoyNTo1NC4wMDAwMDAwMDAgKzAxMDAKQEAgLTUwNCw3ICs1MDQsNyBAQAogI2RlZmlu
ZSBkaWQgZGV2LT5EZXZpY2VJZAogCiAJLyogbWFrZSBzdXJlIHdlIGhhdmUgcmVzaWR1YWwgZGF0
YSBmaXJzdCAqLwotCWlmICggcmVzLT5SZXNpZHVhbExlbmd0aCA9PSAwICkKKwlpZiAoIWhhdmVf
cmVzaWR1YWxfZGF0YSgpKQogCQlyZXR1cm47CiAKIAlwcmludGsoIlJlc2lkdWFsOiAlbGQgZGV2
aWNlc1xuIiwgcmVzLT5BY3R1YWxOdW1EZXZpY2VzKTsKQEAgLTYzOSw3ICs2MzksNyBAQAogI2Rl
ZmluZSBkaWQgZGV2LT5EZXZpY2VJZAogCiAJLyogbWFrZSBzdXJlIHdlIGhhdmUgcmVzaWR1YWwg
ZGF0YSBmaXJzdCAqLwotCWlmICggcmVzLT5SZXNpZHVhbExlbmd0aCA9PSAwICkKKwlpZiAoIWhh
dmVfcmVzaWR1YWxfZGF0YSgpKQogCQlyZXR1cm47CiAJcHJpbnRrKCJSZXNpZHVhbDogJWxkIGRl
dmljZXNcbiIsIHJlcy0+QWN0dWFsTnVtRGV2aWNlcyk7CiAJZm9yICggaSA9IDA7CkBAIC03OTAs
NyArNzkwLDcgQEAKIAkJCSBpbnQgbikKIHsKIAlpbnQgaTsKLQlpZiAoICFyZXMtPlJlc2lkdWFs
TGVuZ3RoICkgcmV0dXJuIE5VTEw7CisJaWYgKCFoYXZlX3Jlc2lkdWFsX2RhdGEoKSkgcmV0dXJu
IE5VTEw7CiAJZm9yIChpPTA7IGk8cmVzLT5BY3R1YWxOdW1EZXZpY2VzOyBpKyspIHsKICNkZWZp
bmUgRGV2IHJlcy0+RGV2aWNlc1tpXS5EZXZpY2VJZAogCQlpZiAoIChEZXYuQnVzSWQmQnVzTWFz
aykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJiYKQEAgLTgxMyw3ICs4MTMsNyBA
QAogCQkJIGludCBuKQogewogCWludCBpOwotCWlmICggIXJlcy0+UmVzaWR1YWxMZW5ndGggKSBy
ZXR1cm4gTlVMTDsKKwlpZiAoIWhhdmVfcmVzaWR1YWxfZGF0YSgpKSByZXR1cm4gTlVMTDsKIAlm
b3IgKGk9MDsgaTxyZXMtPkFjdHVhbE51bURldmljZXM7IGkrKykgewogI2RlZmluZSBEZXYgcmVz
LT5EZXZpY2VzW2ldLkRldmljZUlkCiAJCWlmICggKERldi5CdXNJZCZCdXNNYXNrKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmJgpAQCAtOTAxLDcgKzkwMSw3IEBACiBpbnQgX19p
bml0CiBwcm9jX3ByZXBfcmVzaWR1YWxfaW5pdCh2b2lkKQogewotCWlmIChyZXMtPlJlc2lkdWFs
TGVuZ3RoKQorCWlmIChoYXZlX3Jlc2lkdWFsX2RhdGEoKSkKIAkJY3JlYXRlX3Byb2NfcmVhZF9l
bnRyeSgicmVzaWR1YWwiLCBTX0lSVUdPLCBOVUxMLAogCQkJCQlwcm9jX3ByZXBfcmVzaWR1YWxf
cmVhZCwgTlVMTCk7CiAJcmV0dXJuIDA7CmRpZmYgLXVyTlggLmRpZmZleCBsaW51eC0yLjYuNi1w
cmV2L2luY2x1ZGUvYXNtLXBwYy9yZXNpZHVhbC5oIGxpbnV4LTIuNi42L2luY2x1ZGUvYXNtLXBw
Yy9yZXNpZHVhbC5oCi0tLSBsaW51eC0yLjYuNi1wcmV2L2luY2x1ZGUvYXNtLXBwYy9yZXNpZHVh
bC5oCTIwMDQtMDEtMDkgMDY6NTk6MjcuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC0yLjYuNi9p
bmNsdWRlL2FzbS1wcGMvcmVzaWR1YWwuaAkyMDA0LTA2LTA3IDE2OjI1OjU0LjAwMDAwMDAwMCAr
MDEwMApAQCAtMzI4LDYgKzMyOCwxNSBAQAogZXh0ZXJuIFBuUF9UQUdfUEFDS0VUICpQblBfZmlu
ZF9sYXJnZV92ZW5kb3JfcGFja2V0KHVuc2lnbmVkIGNoYXIgKnAsCiAJCQkJCQkgICAgdW5zaWdu
ZWQgcGFja2V0X3R5cGUsCiAJCQkJCQkgICAgaW50IG4pOworCitzdGF0aWMgaW5saW5lIGludCBo
YXZlX3Jlc2lkdWFsX2RhdGEodm9pZCkgeworI2lmICAgICAgIGRlZmluZWQoQ09ORklHX1BSRVBf
UkVTSURVQUwpCisJcmV0dXJuIHJlcyAmJiByZXMtPlJlc2lkdWFsTGVuZ3RoOworI2Vsc2UgLyog
IWRlZmluZWQoQ09ORklHX1BSRVBfUkVTSURVQUwpICovCisJcmV0dXJuIDA7CisjZW5kaWYgLyog
ZGVmaW5lZChDT05GSUdfUFJFUF9SRVNJRFVBTCkgKi8KK30KKwogI2VuZGlmIC8qIF9fQVNTRU1C
TFlfXyAqLwogI2VuZGlmICAvKiBuZGVmIF9SRVNJRFVBTF8gKi8KIAo=
------=_20040608091203_83559--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
