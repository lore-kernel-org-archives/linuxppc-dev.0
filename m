Message-Id: <20001223145258.Postino-022361@smtp01.highway.ne.jp>
Date: Sat, 23 Dec 2000 14:52:58 +0900
To: <linuxppc-dev@lists.linuxppc.org>
CC: <gcc@gcc.gnu.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: kerne-2.4.0-test13pre3 with gcc-2.97
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I tried to compile kernel-2.4.0-test13-pre3 with gcc-2.97.
It need the patch.
The gcc-2.97 makes singleCPU work kernel  well,
But the smp kernel didn't work.

The gcc-2.95.3 makes both work kernel , very well without this patch.

Does this kernel problems or gcc problems?

My system is linuxppc.

Kaoru

------ gcc --------
[root@g4mpKFUKUI kernel-single]# gcc -v
Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.97/specs
Configured with: /usr/src/redhat/BUILD/gcc-2.97/configure --prefix=/usr --enable-shared -
-enable-threads --host=ppc-redhat-linux --with-cpp-install-dir=../lib --enable-libstdcxx-v3
ppc-redhat-linux
gcc version 2.97 20001217 (experimental)
[root@g4mpKFUKUI kernel-single]#

----- patch for kernel-2.4.0-test13pre3 ---------
diff -urN base/linux/drivers/usb/audio.c fixed/linux/drivers/usb/audio.c
--- base/linux/drivers/usb/audio.c	Fri Dec 22 13:47:44 2000
+++ fixed/linux/drivers/usb/audio.c	Sat Dec 23 12:18:21 2000
@@ -788,7 +788,7 @@
 {
 	union {
 		__s16 s[64];
-		unsigned char b[0];
+		unsigned char *b;
 	} tmp;
 	unsigned int scnt, maxs, ufmtsh, dfmtsh;

@@ -1139,7 +1139,7 @@
 {
 	union {
 		__s16 s[64];
-		unsigned char b[0];
+		unsigned char *b;
 	} tmp;
 	unsigned int scnt, maxs, ufmtsh, dfmtsh;

diff -urN base/linux/drivers/video/aty128fb.c fixed/linux/drivers/video/aty128fb.c
--- base/linux/drivers/video/aty128fb.c	Fri Dec 22 13:47:45 2000
+++ fixed/linux/drivers/video/aty128fb.c	Sat Dec 23 10:09:02 2000
@@ -148,7 +148,7 @@
 };

 /* supported Rage128 chipsets */
-static const struct aty128_chip_info aty128_pci_probe_list[] __initdata =
+static const struct aty128_chip_info *aty128_pci_probe_list __initdata =
 {
     {"Rage128 RE (PCI)", PCI_DEVICE_ID_ATI_RAGE128_RE, rage_128},
     {"Rage128 RF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_RF, rage_128},
diff -urN base/linux/net/ipv4/netfilter/ip_nat_rule.c fixed/linux/net/ipv4/
netfilter/ip_nat_rule.c
--- base/linux/net/ipv4/netfilter/ip_nat_rule.c	Fri Dec 22 13:48:22 2000
+++ fixed/linux/net/ipv4/netfilter/ip_nat_rule.c	Sat Dec 23 10:47:59 2000
@@ -62,31 +62,31 @@
       { [NF_IP_PRE_ROUTING] 0,
 	[NF_IP_POST_ROUTING] sizeof(struct ipt_standard),
 	[NF_IP_LOCAL_OUT] sizeof(struct ipt_standard) * 2 },
-      0, NULL, { } },
+      0, NULL },
     {
 	    /* PRE_ROUTING */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } },
 	    /* POST_ROUTING */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } },
 	    /* LOCAL_OUT */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } }
     },
     /* ERROR */
@@ -94,9 +94,8 @@
 	0,
 	sizeof(struct ipt_entry),
 	sizeof(struct ipt_error),
-	0, { 0, 0 }, { } },
-      { { { { IPT_ALIGN(sizeof(struct ipt_error_target)), IPT_ERROR_TARGET }
 },

-	  { } },
+	0, { 0, 0 } },
+      { { { { IPT_ALIGN(sizeof(struct ipt_error_target)), IPT_ERROR_TARGET }
 } },
 	"ERROR"
       }
     }
diff -urN base/linux/net/ipv4/netfilter/ip_tables.c fixed/linux/net/ipv4/netfilter/
ip_tables.c
--- base/linux/net/ipv4/netfilter/ip_tables.c	Fri Dec 22 13:48:22 2000
+++ fixed/linux/net/ipv4/netfilter/ip_tables.c	Sat Dec 23 10:33:10 2000
@@ -1358,7 +1358,7 @@
 	int ret;
 	struct ipt_table_info *newinfo;
 	static struct ipt_table_info bootstrap
-		= { 0, 0, { 0 }, { 0 }, { } };
+		= { 0, 0, { 0 }, { 0 }, {0} };

 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct ipt_table_info)
diff -urN base/linux/net/ipv4/netfilter/iptable_filter.c fixed/linux/net/ipv4/
netfilter/iptable_filter.c
--- base/linux/net/ipv4/netfilter/iptable_filter.c	Fri Dec 22 13:48:22 2000
+++ fixed/linux/net/ipv4/netfilter/iptable_filter.c	Sat Dec 23 10:44:56 2000
@@ -41,31 +41,31 @@
       { [NF_IP_LOCAL_IN] 0,
 	[NF_IP_FORWARD] sizeof(struct ipt_standard),
 	[NF_IP_LOCAL_OUT] sizeof(struct ipt_standard) * 2 },
-      0, NULL, { } },
+      0, NULL },
     {
 	    /* LOCAL_IN */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } },
 	    /* FORWARD */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } },
 	    /* LOCAL_OUT */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
 		0,
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
-		0, { 0, 0 }, { } },
-	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
+		0, { 0, 0 } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } } },
 		-NF_ACCEPT - 1 } }
     },
     /* ERROR */
@@ -73,9 +73,8 @@
 	0,
 	sizeof(struct ipt_entry),
 	sizeof(struct ipt_error),
-	0, { 0, 0 }, { } },
-      { { { { IPT_ALIGN(sizeof(struct ipt_error_target)), IPT_ERROR_TARGET }
 },
-	  { } },
+	0, { 0, 0 } },
+      { { { { IPT_ALIGN(sizeof(struct ipt_error_target)), IPT_ERROR_TARGET }
 } },
 	"ERROR"
       }
     }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
