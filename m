MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15983.28808.122462.515758@gargle.gargle.HOWL>
Date: Wed, 12 Mar 2003 18:38:16 +0100
From: mikpe@csd.uu.se
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.24 boot hang fix for old-world PowerMac 4400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kernel 2.2.24 hangs immediately on boot on my PowerMac 4400.
The patch below fixes this problem. I checked the linuxppc_2_2 tree
today and it does not have this fix. Please consider applying it.

I extracted the patch from YDL's 2.2.19-1r kernel, since that
was the only fully functional kernel I could find.
All 2.4 ppc kernels I've tested have problems on this machine
(swim3 floppy driver needs 10 minutes to write a 1.44MB floppy,
and vmlinux.coff aborts with a CLAIM error at boot) which is
why I'm currently using the 2.2.24 kernel.

Please cc: me on replies; I subscribed to linuxppc-dev today but
haven't gotten any confirmation or linuxppc-dev mail yet.

/Mikael

--- linux-2.2.24/arch/ppc/kernel/prom.c.~1~	Mon Mar 26 22:41:59 2001
+++ linux-2.2.24/arch/ppc/kernel/prom.c	Wed Mar 12 15:57:35 2003
@@ -668,8 +668,8 @@
 	}

 #endif
-	/* If PowerMac, then use quiesce call */
-	if (!chrp) {
+	/* If OpenFirmware version >= 3, then use quiesce call */
+	if (RELOC(prom_version) >= 3) {
 	    prom_print(RELOC("Calling quiesce ...\n"));
 	    call_prom(RELOC("quiesce"), 0, 0);
 	    offset = reloc_offset();

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
