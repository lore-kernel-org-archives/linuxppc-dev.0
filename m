Message-ID: <3973882B.1C9A581E@noos.fr>
Date: Tue, 18 Jul 2000 00:26:52 +0200
From: Guillaume Laurès <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: progress on l2cr
Content-Type: multipart/mixed;
 boundary="------------BDE8B9928BF36E5B448DC555"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Il s'agit d'un message multivolet au format MIME.
--------------BDE8B9928BF36E5B448DC555
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 7bit

Hi all,

I've made big improvements in understantding basic kernel code ;-), but
it's still not that good...

Here are two patches against current stable tree, the first,
l2cr-display-gom.diff, fixes the ouput of "cat /proc/sys/kernel.l2cr"
according to M Lanners' patch for G3, and according to the Motorola 7400
Users' Manual.
Tested on G4, but not G3 yet. It should be clean and harmful anyway.

The second, l2cr-cmdline-gom.diff, is a try to enable "l2cr=xx" kernel
command line option.
All is fine if you don't put the option, and hangs at boot with
something like this: l2cr=0xb5100000.
Since when I tried to kill calls to __set_L2CR in ppc_setup_l2cr()
commenting the following two lines:
 _set_L2CR(0);  /* disable cache */
 _set_L2CR(val);  /* enable it */
it stills hangs at the same point, I guess the way I call
ppc_setup_l2cr() is wrong. I couldn't find documentation on this, but I
figured out reading init/main.c that doing this would be sufficient,
tell me were I'm wrong :

--- linux-pmac-stable-orig/init/main.c Mon Jul 17 21:31:00 2000
+++ linux/init/main.c Mon Jul 17 21:04:15 2000
@@ -355,6 +355,9 @@
 #ifdef CONFIG_ADBMOUSE
 extern void adb_mouse_setup(char *str, int *ints);
 #endif
+#ifdef CONFIG_PPC
+extern void ppc_setup_l2cr(char *str, int *ints);
+#endif
 #ifdef CONFIG_WDT
 extern void wdt_setup(char *str, int *ints);
 #endif
@@ -1044,6 +1047,9 @@
 #endif
 #ifdef CONFIG_ADBMOUSE
  { "adb_buttons=", adb_mouse_setup },
+#endif
+#ifdef CONFIG_PPC
+ { "l2cr=", ppc_setup_l2cr },
 #endif
 #ifdef CONFIG_LTPC
  { "ltpc=", ltpc_setup },

Thanks,

--
Guillaume

--------------BDE8B9928BF36E5B448DC555
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="l2cr-display-gom.diff"
Content-Disposition: inline;
 filename="l2cr-display-gom.diff"
Content-Transfer-Encoding: 8bit

--- linux-pmac-stable-orig/arch/ppc/kernel/ppc_htab.c	Mon Jul 17 21:30:43 2000
+++ linux-pmac-stable/arch/ppc/kernel/ppc_htab.c	Mon Jul 17 22:14:46 2000
@@ -536,8 +536,8 @@
 		"unknown size", "256KB", "512KB", "1MB"
 	};
 	static const char *clockstrings[8] = {
-		"clock disabled", "+1 clock", "+1.5 clock", "reserved(3)",
-		"+2 clock", "+2.5 clock", "+3 clock", "reserved(7)"
+		"clock disabled", "÷1 clock", "÷1.5 clock", "reserved(3)",
+		"÷2 clock", "÷2.5 clock", "÷3 clock", "reserved(7)"
 	};
 	static const char *typestrings[4] = {
 		"flow-through burst SRAM", "reserved SRAM",
@@ -547,6 +547,17 @@
 		"0.5", "1.0", "(reserved2)", "(reserved3)"
 	};

+	if ((_get_PVR() >> 16) == 12) {
+			/* update those values when CPU is a G4 */
+		sizestrings[0] = "2MB";
+		clockstrings[3] = "÷3.5 clock";
+		clockstrings[3] = "÷4 clock";
+		holdstrings[0] = "0.6";
+		holdstrings[1] = "1.0";
+		holdstrings[2] = "1.4";
+		holdstrings[3] = "1.8";
+	}
+
 	if ( ((_get_PVR() >> 16) != 8) && ((_get_PVR() >> 16) != 12))
 		return -EFAULT;

@@ -590,25 +601,43 @@
 			_set_L2CR(val);
 			while ( _get_L2CR() & 0x1 )
 				/* wait for invalidate to finish */;
-
+
 		} else {
 			p = buf;
 			if (!first)
 				*p++ = '\t';
 			val = _get_L2CR();
-			p += sprintf(p, "%08x: ", val);
-			p += sprintf(p, " %s",
-				     (val&0x80000000)?"enabled":"disabled");
-			p += sprintf(p,",%sparity",(val&0x40000000)?"":"no ");
-			p += sprintf(p, ",%s", sizestrings[(val >> 28) & 3]);
-			p += sprintf(p, ",%s", clockstrings[(val >> 25) & 7]);
-			p += sprintf(p, ",%s", typestrings[(val >> 23) & 0x2]);
-			p += sprintf(p,"%s",(val>>22)&1?"":",data only");
-			p += sprintf(p,"%s",(val>>20)&1?",ZZ enabled":"");
-			p += sprintf(p,",%s",(val>>19)&1?"write-through":"copy-back");
-			p += sprintf(p,",%sns hold", holdstrings[(val>>16)&3]);
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+					"disabled");
+			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
+			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 3]);
+			p += sprintf(p, ", %s", clockstrings[(val >> 25) & 7]);
+			p += sprintf(p, ", %s", typestrings[(val >> 23) & 2]);
+			p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");
+			p += sprintf(p, "%s", (val>>20)&1 ? ", ZZ enabled": "");
+			p += sprintf(p, ", %s", (val>>19)&1 ? "write-through" :
+					"copy-back");
+			p += sprintf(p, "%s", (val>>18)&1 ? ", testing" : "");
+			p += sprintf(p, ", %sns hold",holdstrings[(val>>16)&3]);
+			p += sprintf(p, "%s", (val>>15)&1 ? ", DLL slow" : "");
+			p += sprintf(p, "%s", (val>>14)&1 ? ", diff clock" :"");
+			p += sprintf(p, "%s", (val>>13)&1 ? ", DLL bypass" :"");
+			if ((_get_PVR() >> 16) == 12) {
+					/* G4 have more significant bits than G3 */
+				p += sprintf(p, "%s", (val>>12)&1 ? ",
+						flush assist" :"");
+				p += sprintf(p, "%s", (val>>11)&1 ? ",
+						hardware flush" :"");
+				p += sprintf(p, "%s", (val>>10)&1 ? ",
+						instruction-only" :"");
+				p += sprintf(p, "%s", (val>>9)&1 ? ",
+						clock stop" :"");
+				p += sprintf(p, "%s", (val>>8)&1 ? ",
+						rollover checkstop" :"");
+			}

-			p += sprintf(p,"\n");
+			p += sprintf(p, "\n");

 			len = strlen(buf);
 			if (len > left)

--------------BDE8B9928BF36E5B448DC555
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F";
 name="l2cr-cmdline-gom.diff"
Content-Disposition: inline;
 filename="l2cr-cmdline-gom.diff"
Content-Transfer-Encoding: 7bit

--- linux-pmac-stable-orig/arch/ppc/kernel/setup.c	Mon Jul 17 21:30:43 2000
+++ linux/arch/ppc/kernel/setup.c	Mon Jul 17 23:13:58 2000
@@ -549,15 +549,19 @@
 	return 0;
 }

-/* Checks "l2cr=xxxx" command-line option */
+/* Takes care of "l2cr=xxxx" command-line option */
 void ppc_setup_l2cr(char *str, int *ints)
 {
 	if ( ((_get_PVR() >> 16) == 8) || ((_get_PVR() >> 16) == 12) )
+		/* Make sure cpu is G3 or G4 */
 	{
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
-		_set_L2CR(0);
-		_set_L2CR(val);
+		val |= 0x00200000;	/* perform global invalidate */
+		_set_L2CR(0);		/* disable cache */
+		_set_L2CR(val);		/* enable it */
+	} else {
+		printk(KERN_INFO "l2cr: cpu is not suitable\n");
 	}
 }

--- linux-pmac-stable-orig/init/main.c	Mon Jul 17 21:31:00 2000
+++ linux/init/main.c	Mon Jul 17 21:04:15 2000
@@ -355,6 +355,9 @@
 #ifdef CONFIG_ADBMOUSE
 extern void adb_mouse_setup(char *str, int *ints);
 #endif
+#ifdef CONFIG_PPC
+extern void ppc_setup_l2cr(char *str, int *ints);
+#endif
 #ifdef CONFIG_WDT
 extern void wdt_setup(char *str, int *ints);
 #endif
@@ -1044,6 +1047,9 @@
 #endif
 #ifdef CONFIG_ADBMOUSE
 	{ "adb_buttons=", adb_mouse_setup },
+#endif
+#ifdef CONFIG_PPC
+	{ "l2cr=", ppc_setup_l2cr },
 #endif
 #ifdef CONFIG_LTPC
 	{ "ltpc=", ltpc_setup },

--------------BDE8B9928BF36E5B448DC555--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
