Date: Fri, 30 Jul 2004 18:06:18 +0100
To: trini@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [10/9] Support for old IBM PReP boxes
Message-ID: <20040730170618.GA9009@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Will something like this do?  It won't be that helpful for IBM PRePs,
but it should be an acceptable fallback for Motorolas.  I put the test
after it's determined whether it's an IBM or Motorola PReP on the off
chance there is an IBM PReP that doesn't need any residual data to
function properly.


diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/Kconfig linux-2.6.8-rc2-bk8/arch/ppc/Kconfig
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/Kconfig	2004-07-29 20:38:27.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/Kconfig	2004-07-30 17:55:42.000000000 +0100
@@ -853,10 +853,11 @@
 	  Some PReP systems have residual data passed to the kernel by the
 	  firmware.  This allows detection of memory size, devices present and
 	  other useful pieces of information.  Sometimes this information is
-	  not present or incorrect.
+	  not present or incorrect, in which case it could lead to the machine
+	  behaving incorrectly.  If this happens, either disable PREP_RESIDUAL
+	  or pass the 'noresidual' option to the kernel.

-	  Unless you expect to boot on a PReP system, there is no need to
-	  select Y.
+	  If you are running a PReP system, say Y here, otherwise say N.

 config PROC_PREPRESIDUAL
 	bool "Support for reading of PReP Residual Data in /proc"
Binary files linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/.prep_setup.c.swp and linux-2.6.8-rc2-bk8/arch/ppc/platforms/.prep_setup.c.swp differ
diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c	2004-07-29 20:55:49.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c	2004-07-30 17:58:51.000000000 +0100
@@ -1134,6 +1134,10 @@
 		_prep_type = _PREP_Motorola;
 	}

+	/* Switch off all residual data processing if the user requests it */
+	if (strstr(cmd_line, "noresidual") != NULL)
+			res = NULL;
+
 	/* Initialise progress early to get maximum benefit */
 	prep_set_bat();
 	ibm_statusled_init();

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
