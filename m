Subject: [PATCH] linuxppc-2.5 build fixes
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-cR9ebrpBfMb7aMbt+vVv"
Message-Id: <1063317992.1654.17.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: Fri, 12 Sep 2003 00:06:33 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-cR9ebrpBfMb7aMbt+vVv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Include drivers/cpufreq/Kconfig instead of duplicating it in
/arch/ppc/Kconfig, and define MODULE_ALIAS_LDISC.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

--=-cR9ebrpBfMb7aMbt+vVv
Content-Disposition: attachment; filename=linuxppc-2.6.0-test5.diff
Content-Type: text/x-patch; name=linuxppc-2.6.0-test5.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -up -x logo -x .config -r linuxppc-2.6.0-test5/arch/ppc/Kconfig linuxppc-2.6.0-test5-md/arch/ppc/Kconfig
--- linuxppc-2.6.0-test5/arch/ppc/Kconfig	2003-09-09 15:21:14.000000000 +0200
+++ linuxppc-2.6.0-test5-md/arch/ppc/Kconfig	2003-09-09 21:36:34.000000000 +0200
@@ -705,31 +705,7 @@ config CPU_FREQ_TABLE
 	depends on CPU_FREQ
 	default y

-config CPU_FREQ_PROC_INTF
-	bool "/proc/cpufreq interface (DEPRECATED)"
-	depends on CPU_FREQ && PROC_FS
-	help
-	  This enables the /proc/cpufreq interface for controlling
-	  CPUFreq. Please note that it is recommended to use the sysfs
-	  interface instead (which is built automatically).
-
-	  For details, take a look at linux/Documentation/cpufreq.
-
-	  If in doubt, say N.
-
-config CPU_FREQ_24_API
-	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
-	depends on CPU_FREQ
-	help
-	  This enables the /proc/sys/cpu/ sysctl interface for controlling
-	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
-	  uses a sysfs interface instead. Please note that some drivers do
-	  not work well with the 2.4. /proc/sys/cpu sysctl interface,
-	  so if in doubt, say N here.
-
-	  For details, take a look at linux/Documentation/cpufreq.
-
-	  If in doubt, say N.
+source 'drivers/cpufreq/Kconfig'

 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
diff -up -x logo -x .config -r linuxppc-2.6.0-test5/include/asm-ppc/termios.h linuxppc-2.6.0-test5-md/include/asm-ppc/termios.h
--- linuxppc-2.6.0-test5/include/asm-ppc/termios.h	2003-09-09 15:21:36.000000000 +0200
+++ linuxppc-2.6.0-test5-md/include/asm-ppc/termios.h	2003-09-09 21:20:13.000000000 +0200
@@ -227,6 +227,8 @@ struct termio {
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))

+#define MODULE_ALIAS_LDISC(ldisc) \
+	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 #endif	/* __KERNEL__ */

 #endif	/* _PPC_TERMIOS_H */

--=-cR9ebrpBfMb7aMbt+vVv--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
