Message-ID: <1822.80.7.99.14.1086886383.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 17:53:03 +0100 (BST)
Subject: [RFC][PATCH 2/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is my version of the status led support.  I like it because:

1. It works much earlier on due to setting up the BATs.  This is code
I stole from pplus_setup.c.

2. It prints out 505 on the display when the machine panics, but
only if it managed to finish booting up.

3. It works on all IBM PRePs that have LED displays.

4. It mangles the progress number to work around the fact it can only
cope with 000-FFF.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c
linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c	2004-06-07
16:37:25.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-07
17:26:04.000000000 +0100
@@ -448,12 +448,6 @@
 }

 static void __prep
-prep_tiger1_progress(char *msg, unsigned short code)
-{
-	outw(code, PREP_IBM_DISP);
-}
-
-static void __prep
 prep_restart(char *cmd)
 {
 #define PREP_SP92	0x92	/* Special Port 92 */
@@ -679,6 +673,117 @@
 #endif
 }

+/*
+ * Set BAT 2 to access 0x80000000 so early progress messages will work
+ */
+static __inline__ void
+prep_set_bat(void)
+{
+	static int mapping_set = 0;
+
+	if (!mapping_set) {
+		/* wait for all outstanding memory access to complete */
+		mb();
+
+		/* setup DBATs */
+		mtspr(DBAT2U, 0x80001ffe);
+		mtspr(DBAT2L, 0x8000002a);
+
+		/* wait for updates */
+		mb();
+
+		mapping_set = 1;
+	}
+}
+
+/*
+ * IBM 3-digit status LED
+ */
+static unsigned int ibm_statusled_base __prepdata;
+
+static void __prep
+ibm_statusled_progress(char *s, unsigned short hex);
+
+static int __prep
+ibm_statusled_panic(struct notifier_block *dummy1, unsigned long dummy2,
+		    void * dummy3)
+{
+	ibm_statusled_progress(NULL, 0x505); /* SOS */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ibm_statusled_block __prepdata = {
+	ibm_statusled_panic,
+	NULL,
+	INT_MAX /* try to do it first */
+};
+
+static void __prep
+ibm_statusled_progress(char *s, unsigned short hex)
+{
+	static int notifier_installed;
+	/*
+	 * Progress uses 4 digits and we have only 3.  So, we map 0xffff to
+	 * 0xfff for display switch off.  Out of range values are mapped to
+	 * 0xeff, as I'm told 0xf00 and above are reserved for hardware codes.
+	 * Install the panic notifier when the display is first switched off.
+	 */
+	if (hex == 0xffff) {
+		hex = 0xfff;
+		if (!notifier_installed) {
+			++notifier_installed;
+			notifier_chain_register(&panic_notifier_list,
+						&ibm_statusled_block);
+		}
+	}
+	else
+		if (hex > 0xfff)
+			hex = 0xeff;
+
+	mb();
+	outw(hex, ibm_statusled_base);
+}
+
+static void __init
+ibm_statusled_init(void)
+{
+	/*
+	 * The IBM 3-digit LED display is specified in the residual data
+	 * as an operator panel device, type "System Status LED".  Find
+	 * that device and determine its address.  We validate all the
+	 * other parameters on the off-chance another, similar device
+	 * exists.
+	 */
+	if (have_residual_data()) {
+		PPC_DEVICE *led;
+		PnP_TAG_PACKET *pkt;
+
+		led = residual_find_device(~0, NULL, SystemPeripheral,
+					   OperatorPanel, SystemStatusLED, 0);
+		if (!led)
+			return;
+
+		pkt = PnP_find_packet((unsigned char *)
+		       &res->DevicePnPHeap[led->AllocatedOffset], S8_Packet, 0);
+		if (!pkt)
+			return;
+
+		if (pkt->S8_Pack.IOInfo != ISAAddr16bit)
+			return;
+		if (*(unsigned short *)pkt->S8_Pack.RangeMin !=
+		    *(unsigned short *)pkt->S8_Pack.RangeMax)
+			return;
+		if (pkt->S8_Pack.IOAlign != 2)
+			return;
+		if (pkt->S8_Pack.IONum != 2)
+			return;
+
+		ibm_statusled_base = ld_le16((unsigned short *)
+					     (pkt->S8_Pack.RangeMin));
+		ppc_md.progress = ibm_statusled_progress;
+	}
+}
+
 static void __init
 prep_setup_arch(void)
 {
@@ -741,7 +846,6 @@
 				setup_ibm_pci = prep_tiger1_setup_pci;
 				ppc_md.power_off = prep_sig750_poweroff;
 				ppc_md.show_cpuinfo = prep_tiger1_cpuinfo;
-				ppc_md.progress = prep_tiger1_progress;
 				break;
 		}
 		printk("\n");
@@ -1008,6 +1112,10 @@
 		_prep_type = _PREP_Motorola;
 	}

+	/* Initialise progress early to get maximum benefit */
+	prep_set_bat();
+	ibm_statusled_init();
+
 	ppc_md.setup_arch     = prep_setup_arch;
 	ppc_md.show_percpuinfo = prep_show_percpuinfo;
 	ppc_md.show_cpuinfo   = NULL; /* set in prep_setup_arch() */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
