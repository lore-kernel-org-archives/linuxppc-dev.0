Message-Id: <20001225090438.Postino-021848@smtp01.highway.ne.jp>
Date: Mon, 25 Dec 2000 09:04:38 +0900
To: Alexandre Oliva <aoliva@redhat.com>, sailer@ife.ee.ethz.ch
CC: linuxppc-dev@lists.linuxppc.org, gcc@gcc.gnu.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks,Alex and Tom.

I have done kernel compiling with the patch.
it boot ,but  unstable.

I will wait gcc-3.0.

Thanks a lot.

Kaoru
-----------------------

diff -urN base/linux/drivers/usb/audio.c fixed/linux/drivers/usb/audio.c
--- base/linux/drivers/usb/audio.c	Fri Dec 22 13:47:44 2000
+++ fixed/linux/drivers/usb/audio.c	Mon Dec 25 04:31:59 2000
@@ -788,7 +788,7 @@
 {
 	union {
 		__s16 s[64];
-		unsigned char b[0];
+		unsigned char b[1];
 	} tmp;
 	unsigned int scnt, maxs, ufmtsh, dfmtsh;

@@ -1139,7 +1139,7 @@
 {
 	union {
 		__s16 s[64];
-		unsigned char b[0];
+		unsigned char b[1];
 	} tmp;
 	unsigned int scnt, maxs, ufmtsh, dfmtsh;

diff -urN base/linux/drivers/video/aty128fb.c fixed/linux/drivers/video/aty128fb.c
--- base/linux/drivers/video/aty128fb.c	Fri Dec 22 13:47:45 2000
+++ fixed/linux/drivers/video/aty128fb.c	Mon Dec 25 05:02:21 2000
@@ -148,7 +148,7 @@
 };

 /* supported Rage128 chipsets */
-static const struct aty128_chip_info aty128_pci_probe_list[] __initdata =
+static const struct aty128_chip_info aty128_pci_probe_list[]  =
 {
     {"Rage128 RE (PCI)", PCI_DEVICE_ID_ATI_RAGE128_RE, rage_128},
     {"Rage128 RF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_RF, rage_128},
diff -urN base/linux/include/linux/netfilter_ipv4/ip_tables.h fixed/linux/include/
linux/netfilter_ipv4/ip_tables.h
--- base/linux/include/linux/netfilter_ipv4/ip_tables.h	Mon Dec 25 05:15:00
2000
+++ fixed/linux/include/linux/netfilter_ipv4/ip_tables.h	Mon Dec 25 05:30:22
2000
@@ -65,7 +65,7 @@
 		u_int16_t match_size;
 	} u;

-	unsigned char data[0];
+	unsigned char data[1];
 };

 struct ipt_entry_target
@@ -88,7 +88,7 @@
 		u_int16_t target_size;
 	} u;

-	unsigned char data[0];
+	unsigned char data[1];
 };

 struct ipt_standard_target
@@ -138,7 +138,7 @@
 	struct ipt_counters counters;

 	/* The matches (if any), then the target. */
-	unsigned char elems[0];
+	unsigned char elems[1];
 };

 /*
@@ -255,7 +255,7 @@
 	struct ipt_counters *counters;

 	/* The entries (hang off end: not really an array). */
-	struct ipt_entry entries[0];
+	struct ipt_entry entries[1];
 };

 /* The argument to IPT_SO_ADD_COUNTERS. */
@@ -267,7 +267,7 @@
 	unsigned int num_counters;

 	/* The counters (actually `number' of these). */
-	struct ipt_counters counters[0];
+	struct ipt_counters counters[1];
 };

 /* The argument to IPT_SO_GET_ENTRIES. */
@@ -280,7 +280,7 @@
 	unsigned int size;

 	/* The entries. */
-	struct ipt_entry entrytable[0];
+	struct ipt_entry entrytable[1];
 };

 /* Standard return verdict, or do jump. */
diff -urN base/linux/net/ipv4/netfilter/ip_tables.c fixed/linux/net/ipv4/netfilter/
ip_tables.c
--- base/linux/net/ipv4/netfilter/ip_tables.c	Fri Dec 22 13:48:22 2000
+++ fixed/linux/net/ipv4/netfilter/ip_tables.c	Mon Dec 25 05:46:05 2000
@@ -90,7 +90,7 @@
 	unsigned int underflow[NF_IP_NUMHOOKS];

 	/* ipt_entry tables: one per CPU */
-	char entries[0] __attribute__((aligned(SMP_CACHE_BYTES)));
+	char entries[1] __attribute__((aligned(SMP_CACHE_BYTES)));
 };

 static LIST_HEAD(ipt_target);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
