Date: Sun, 28 Nov 1999 22:35:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.30-pre3
Message-ID: <Pine.LNX.4.05.9911282232240.361-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  - Plain 2.3.30-pre3 screws your .config because of two missing `fi's in the
    config scripts.
  - Kill one more warning

This does not mean 2.3.30-pre3 is running on my box, I'm just compiling...
Paul's unstable rsync tree (linux-pmac-devel) doesn't compile, so I wanted to
give Linus' tree a try

--- chrp-2.3.30/arch/ppc/config.in.orig	Sun Nov 28 20:29:50 1999
+++ chrp-2.3.30/arch/ppc/config.in	Sun Nov 28 22:31:04 1999
@@ -85,12 +85,16 @@
 
 if [ "$CONFIG_APUS" = "y" ]; then
   define_bool CONFIG_PCI n
-else if [ "$CONFIG_OAK" = "y" ]; then
-  define_bool CONFIG_PCI n
-else if [ "$CONFIG_8xx" = "y" ]; then
-    bool 'QSpan PCI' CONFIG_PCI
 else
-    define_bool CONFIG_PCI y
+  if [ "$CONFIG_OAK" = "y" ]; then
+    define_bool CONFIG_PCI n
+  else
+    if [ "$CONFIG_8xx" = "y" ]; then
+      bool 'QSpan PCI' CONFIG_PCI
+    else
+      define_bool CONFIG_PCI y
+    fi
+  fi
 fi
 
 bool 'Networking support' CONFIG_NET


--- chrp-2.3.30/arch/ppc/chrpboot/piggyback.c.orig	Tue Jan 13 00:18:13 1998
+++ chrp-2.3.30/arch/ppc/chrpboot/piggyback.c	Sun Nov 28 22:27:31 1999
@@ -1,8 +1,9 @@
 #include <stdio.h>
+#include <unistd.h>
 
 extern long ce_exec_config[];
 
-main(int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 	int i, cnt, pos, len;
 	unsigned int cksum, val;

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
